# Load custom functions from the 'functions.r' script
source("bin/data/functions.r")

# Check if the 'ggplot2' package is installed, if not, install it
#if(!require(ggplot2)){install.packages("ggplot2")}
# Check if the 'plyr' package is installed, if not, install it
#if(!require(plyr)){install.packages("plyr")}
# Check if the 'magrittr' package is installed, if not, install it
#if(!require(magrittr)){install.packages("magrittr")}
# Check if the 'cowplot' package is installed, if not, install it
#if(!require(cowplot)){install.packages("cowplot")}

## plot within plate cv #######################################################

# Load preprocessed data from RData files
load("input/rdata/int.rdata")
load("input/rdata/proc.rdata")

# Initialize a list to store plots
p = list()

# Loop through each plate
for (i in 1:length(levels(factor(meta.dt$Plate)))){
  df = df.raw
  
  # Identify indices of standard samples on the current plate
  std.idx = grep("LR", colnames(df))
  
  # Identify standard samples that belong to the current plate
  std.idx = intersect(which(meta.dt$Plate==levels(factor(meta.dt$Plate))[[i]]), 
                      std.idx)
  
  # Calculate statistics for raw data
  res1 = as.data.frame(cbind(`Log2 Median`=as.numeric(apply(
    df[,std.idx], 1, median, na.rm = T)),
    CV=getCV(as.matrix(2^df[,std.idx])),
    method = rep("Raw",nrow(df))))
  
  # Calculate statistics for median-normalized data
  df.median = df.median
  res2 = as.data.frame(cbind(`Log2 Median`=as.numeric(apply(
    df.median[,std.idx], 1, median, na.rm = T)),
    CV=getCV(as.matrix(2^df.median[,std.idx])),
    method = rep("Med \nNorm",nrow(df.median))))
  
  # Calculate statistics for batch-adjusted peptide data
  res6 = as.data.frame(cbind(`Log2 Median`=as.numeric(apply(
    nobatch.prot1[,std.idx], 1, median, na.rm = T)),
    CV=getCV(as.matrix(2^nobatch.prot1[,std.idx])),
    method = rep("Adj \nProt",nrow(nobatch.prot1))))
  
  # Calculate statistics for batch-adjusted protein data
  res7 = as.data.frame(cbind(`Log2 Median`=as.numeric(apply(
    nobatch.pep1[,std.idx], 1, median, na.rm = T)),
    CV=getCV(as.matrix(2^nobatch.pep1[,std.idx])),
    method = rep("Adj \nPep",nrow(nobatch.pep1))))
  
  # Combine results from different methods
  res123 = rbind(res1,res2,res7, res6)
  
  df = res123
  
  # Convert columns to numeric
  df$`Log2 Median` = as.numeric(df$`Log2 Median`)
  df$CV = as.numeric(df$CV)
  
  # Define method as a factor with specified levels
  df$method = factor(df$method, levels = c("Raw", "Med \nNorm", 
                                           "Adj \nPep", 
                                           "Adj \nProt"))
  
  # Define theme for plot size
  sizeTheme = ggplot2::theme(
    axis.title.x = ggplot2::element_text(size = 8),
    axis.text.x = ggplot2::element_text(size = 6),
    axis.text.y = ggplot2::element_text(size = 6),
    axis.title.y = ggplot2::element_text(size = 8))
  
  `%>%` <- magrittr::`%>%`
  
  # Calculate mean for each method
  mu = plyr::ddply(df, "method", plyr::summarise, 
                   grp.mean = mean(CV, na.rm = T))
  mu = mu %>% plyr::mutate(Label = prettyNum(round(grp.mean, 4)))
  
  # Calculate median for each method
  eta <- plyr::ddply(df, "method", plyr::summarise, 
                     grp.med = median(CV, na.rm = T))
  eta = eta %>% plyr::mutate(Label = prettyNum(round(grp.med, 4)))
  
  # Create histogram plots for each plate
  p[[i]]=ggplot2::ggplot(data = df, ggplot2::aes(x = CV)) +
    ggplot2::geom_histogram(color = "black", fill = "white") +
    ggplot2::facet_grid(method ~ .) + ggplot2::geom_vline(data = eta,
                                                          ggplot2::aes(xintercept = grp.med, 
                                                                       color = "red"),
                                                          linetype = "dashed") +
    ggplot2::geom_text(
      data = eta,
      ggplot2::aes(
        x = grp.med,
        y = 2600,
        label = paste0("\u03b7=", Label)
      ),
      size = 2,
      hjust = -.1
    ) +
    ggplot2::theme_bw() + ggplot2::ylab("Frequency") + sizeTheme +
    ggplot2::labs(title = paste0('Plate ',levels(factor(meta.dt$Plate))[[i]])) +
    ggplot2::theme(legend.position = "none", strip.text = ggplot2::element_text(
      size = 7), plot.title = ggplot2::element_text(size = 10))
}

# Arrange plots in a grid
top_plot <- cowplot::plot_grid(
  p[[1]], p[[2]], p[[3]], p[[4]], p[[5]], p[[6]], p[[7]], p[[8]], 
  ncol = 4,
  label_fontfamily = 'serif',
  label_fontface = 'bold',
  align = 'V', rel_widths = .5,
  rel_heights = 1, label_size = 8)

# Display the grid of plots
top_plot

# Save the combined plot as a PDF file
ggplot2::ggsave("figs/fig7a.pdf", dpi = 900, height = 5, width = 7, 
                units="in", device=cairo_pdf)
