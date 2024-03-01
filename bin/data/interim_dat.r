# Check if 'readr' package is installed, if not, install it
#if(!require(readr)){install.packages("readr")}

# Read data from CSV files
dat = readr::read_csv("input/Figure7_DIAPeptideTotalAreaFragmentPivot.csv")
meta.dt = readr::read_csv("input/Figure7_TPAD_CSF_meta-12-13-2022.csv")

# Create row names by pasting peptide modified sequence and protein
rnames = paste0(dat$PeptideModifiedSequence, "@", dat$Protein)

# Remove first three columns from 'dat' and adjust column names
dat = dat[,-c(1:3)]
colnames(dat) = sapply(strsplit(colnames(dat), "_"), "[", 1)

# Set 'Replicate' column in 'meta.dt' to match 'Public Sample ID'
meta.dt$Replicate = meta.dt$`Public Sample ID`

# Convert 'dat' to numeric matrix
dat = apply(dat, 2, as.numeric)
dat = as.matrix(dat)

# Assign row names to 'dat'
rownames(dat) = rnames

# Sort columns of 'dat' by column names
dat = dat[,order(colnames(dat))]

# Sort 'meta.dt' by 'Public Sample ID'
meta.dt = meta.dt[order(meta.dt$`Public Sample ID`),]

# Check if column names of 'dat' and 'meta.dt' are identical
#identical(colnames(dat), meta.dt$`Public Sample ID`)

# Create 'Condition' column in 'meta.dt' and replace 'DLB' label
meta.dt$Condition = meta.dt$Diagnosis
meta.dt$Plate[grep("^[0-9]", meta.dt$Plate, invert = T)] = NA
meta.dt$Condition[which(meta.dt$Condition == "DLB")] = "LBD"

# Copy 'dat' to 'df' and replace 0 values with NA
df = dat
df[df == 0] = NA
df[log2(df) < 0] = NA

# Log-transformed raw data
df.raw = log2(df)

# Save objects 'df.raw' and 'meta.dt' into an R data file
save(df.raw, meta.dt, file="input/rdata/int.rdata")

# Write log2-transformed raw data to a CSV file
if(F)
  write.csv(cbind(Peptide=sapply(strsplit(rownames(df.raw), "@"), "[",1), 
                  Protein = sapply(strsplit(rownames(df.raw), "@"), "[",2),  
                  df.raw),
            file = "dat/int/tpad-csf_sp3-1_5-log2_raw-v230512.csv",
            row.names = F, col.names = T)
