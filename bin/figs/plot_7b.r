source("bin/data/functions.r")

#if(!require(ggplot2)){install.packages("ggplot2")}
#if(!require(plyr)){install.packages("plyr")}
#if(!require(magrittr)){install.packages("magrittr")}
#if(!require(cowplot)){install.packages("cowplot")}


## plot overall cv ######################################################

load("input/rdata/int.rdata")
load("input/rdata/proc.rdata")

df = df.raw

std.idx = grep("LR", colnames(df))

res1 = as.data.frame(cbind(`Log2 Median`=as.numeric(apply(
  df[,std.idx], 1, median, na.rm = T)),
  CV=getCV(as.matrix(2^df[,std.idx])),
  method = rep("Raw",nrow(df))))
df.median = df.median
res2 = as.data.frame(cbind(`Log2 Median`=as.numeric(apply(
  df.median[,std.idx], 1, median, na.rm = T)),
  CV=getCV(as.matrix(2^df.median[,std.idx])),
  method = rep("Med Norm",nrow(df.median))))
res5 = as.data.frame(cbind(`Log2 Median`=as.numeric(apply(
  pep.grp[,std.idx], 1, median, na.rm = T)),
  CV=getCV(as.matrix(2^pep.grp[,std.idx])),
  method = rep("Pep Grp",nrow(pep.grp))))
res4 = as.data.frame(cbind(`Log2 Median`=as.numeric(apply(
  prot.grp[,std.idx], 1, median, na.rm = T)),
  CV=getCV(as.matrix(2^prot.grp[,std.idx])),
  method = rep("Prot Grp",nrow(prot.grp))))


res6 = as.data.frame(cbind(`Log2 Median`=as.numeric(apply(
  nobatch.prot1[,std.idx], 1, median, na.rm = T)),
  CV=getCV(as.matrix(2^nobatch.prot1[,std.idx])),
  method = rep("Adj Prot",nrow(nobatch.prot1))))

res7 = as.data.frame(cbind(`Log2 Median`=as.numeric(apply(
  nobatch.pep1[,std.idx], 1, median, na.rm = T)),
  CV=getCV(as.matrix(2^nobatch.pep1[,std.idx])),
  method = rep("Adj Pep",nrow(nobatch.pep1))))

res123 = rbind(res1,res2,res5,res7,#res3, 
               res4, res6)

df = res123

df$`Feature Median` = as.numeric(df$`Log2 Median`)
df$CV = as.numeric(df$CV)

df$method = factor(df$method, levels = c("Raw", "Med Norm", 
                                         "Pep Grp", 
                                         "Adj Pep", "Prot Grp",
                                         "Adj Prot"))


commonTheme = list(ggplot2::labs(color="Density",fill="Density",
                        title='CV vs Median Abundance'),
                   ggplot2::theme_bw(),
                   ggplot2::theme(legend.position=c(0.995,0.2),
                         legend.justification=c(0.995,0.995)))

sizeTheme = ggplot2::theme(
  axis.title.x = ggplot2::element_text(size = 8),
  axis.text.x = ggplot2::element_text(size = 6),
  axis.text.y = ggplot2::element_text(size = 6),
  axis.title.y = ggplot2::element_text(size = 8))

p1=ggplot2::ggplot(data=df,ggplot2::aes(`Feature Median`,CV)) + 
  ggplot2::geom_point(shape=16, size=0.1, color="grey66", show.legend = FALSE) +
  ggplot2::stat_density2d(ggplot2::aes(fill=..level..,alpha=..level..),
                          geom='polygon',colour='black') + 
  ggplot2::scale_fill_continuous(low="green",high="red")+
  ggplot2::geom_smooth(method="loess", 
              linetype=2,colour="red",se=F) + 
  ggplot2::guides(alpha="none") + 
  ggplot2::facet_grid(method~., scales = "free_x") + commonTheme + 
  ggplot2::theme(strip.text = ggplot2::element_text(size = 7),
        legend.title = ggplot2::element_text(size = 6.5), 
        legend.text = ggplot2::element_text(size = 6), 
        legend.key.size = ggplot2::unit(0.15, 'cm'),
        plot.title = ggplot2::element_text(size = 10)) +
  sizeTheme

`%>%` <- magrittr::`%>%`

mu = plyr::ddply(df, "method", plyr::summarise, grp.mean = mean(CV, na.rm = T))
mu = mu %>% plyr::mutate(Label = prettyNum(round(grp.mean, 4)))

eta = plyr::ddply(df, "method", plyr::summarise, grp.med = median(CV, na.rm = T))
eta = eta %>% plyr::mutate(Label = prettyNum(round(grp.med, 4)))

p2=ggplot2::ggplot(data = df, ggplot2::aes(x = CV)) +
  ggplot2::geom_histogram(color = "black", fill = "white") +
  ggplot2::facet_grid(method ~ .) + ggplot2::geom_vline(data = eta,
                                                        ggplot2::aes(xintercept = grp.med, color = "red"),
                                      linetype = "dashed") +
  ggplot2::geom_text(
    data = eta,
    ggplot2::aes(
      x = grp.med,
      y = 6000,
      label = paste0("\u03b7=", Label)
    ),
    size = 2,
    hjust = -.2
  ) +
  ggplot2::theme_bw() + ggplot2::ylab("Frequency") + 
  ggplot2::labs(title = 'Frequency Distribution of CV') +
  ggplot2::theme(legend.position = "none",strip.text = ggplot2::element_text(size = 7),
        plot.title = ggplot2::element_text(size = 10)) + sizeTheme


bottom_plot <- cowplot::plot_grid(
  p1, p2, 
  ncol = 2,
  label_fontfamily = 'serif',
  label_fontface = 'bold',
  align = 'V',
  rel_widths = c(1, 1) 
)

bottom_plot

ggplot2::ggsave("figs/fig7b.pdf", dpi = 900,
       height = 4, width = 7, 
       units="in", device=cairo_pdf)
