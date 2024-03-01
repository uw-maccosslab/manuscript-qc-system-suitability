# Load custom functions from the 'functions.r' script
source("src/data/functions.r")

# Check if the 'limma' package is installed, if not, install it
if(!require(limma)){install.packages("limma")}
# Check if the 'data.table' package is installed, if not, install it
if(!require(data.table)){install.packages("data.table")}

## median normalization ########################################################
# Load preprocessed data from an RData file
load("input/rdata/int.rdata")

# Perform median normalization on the raw data
df.median = normalize.median(df.raw)

# Set negative values resulting from normalization to NA
df.median[df.median<0] = NA

## group peptide/protein #######################################################
# Temporarily store the median-normalized data
df.median.temp = df.median

# Calculate median values for peptide groups
pep.grp.median = log2(getPrtGrp(2^df.median.temp, F, average = T))

# Calculate median values for protein groups
prot.grp.median = log2(getPrtGrp(2^df.median.temp, T, average = T))

## batch adjust ################################################################
# Set NA to 0 values
pep.grp.median[pep.grp.median==0] = NA
prot.grp.median[prot.grp.median==0] = NA

# Store peptide and protein groups
pep.grp = pep.grp.median
prot.grp = prot.grp.median

# Identify samples belonging to the standards
idx = grep("Batch", meta.dt$Condition)

nobatch.meta = meta.dt
nobatch.pep0 = pep.grp
nobatch.prot0 = prot.grp

# Perform batch adjustment using removeBatchEffect function from limma package
nobatch.pep1 = limma::removeBatchEffect(nobatch.pep0, batch = nobatch.meta$Plate)
nobatch.prot1 = limma::removeBatchEffect(nobatch.prot0, batch = nobatch.meta$Plate)

# Save processed data and metadata into an RData file
save(df.median, pep.grp, prot.grp,
     nobatch.prot0, nobatch.pep0,
     nobatch.pep1, nobatch.prot1,
     nobatch.meta, file="input/rdata/proc.rdata")

# Export level 3a/3b data
if (F){
  # Prepare peptide data for export
  tempdat = nobatch.pep1
  Peptide = sapply(strsplit(rownames(tempdat), " @ "), "[", 1)
  Protein = sapply(strsplit(rownames(tempdat), " @ "), "[", 2)
  tempdat[is.na(tempdat)] = 0
  tempdat = cbind(Peptide, Protein, tempdat)
  # Write peptide data to a CSV file
  write.csv(tempdat, file="dat/proc/TPAD-CSF-SP3-1_5-Batch_Adj-Peptide.csv", 
            row.names = F, col.names = T)
  
  # Prepare protein data for export
  tempdat = nobatch.prot1
  Peptide = sapply(strsplit(rownames(tempdat), " @ "), "[", 1)
  Protein = sapply(strsplit(rownames(tempdat), " @ "), "[", 2)
  tempdat[is.na(tempdat)] = 0
  tempdat = cbind(Peptide, Protein, tempdat)
  # Write protein data to a CSV file
  write.csv(tempdat, file="dat/proc/TPAD-CSF-SP3-1_5-Batch_Adj-Protein.csv", 
            row.names = F, col.names = T)
}
