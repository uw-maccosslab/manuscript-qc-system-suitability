# Function to normalize data by median centering
normalize.median = function(df){
  # Calculate column-wise median of the input dataframe
  df_med = apply(as.matrix(df), 2, median, na.rm = T)
  # Calculate the difference between each column median and the overall median
  df_med_loc = df_med - median(df_med)
  # Subtract the calculated differences from each column of the input dataframe
  df.median = t(t(df)-df_med_loc)
  return(df.median)
}

# Function to get protein groups
getPrtGrp = function(nosv, group.protein = F, average = T) {
  # Split row names to extract peptide and protein information
  pep = sapply(strsplit(row.names(nosv),"@"), "[", 1)
  prot = sapply(strsplit(row.names(nosv),"@"), "[", 2)
  prot = sapply(strsplit(prot,"_"), "[", 1)
  
  # Combine peptide, protein, and data into a single matrix
  pep_prot = cbind(pep, prot, nosv)
  
  # Group by protein if specified
  if(group.protein == T) {
    pep_prot = data.table::setDT(as.data.frame(
      pep_prot))[, lapply(.SD, function(x) toString(na.omit(x))), by = prot] 
  }
  # Group by peptide
  pep_prot = data.table::setDT(as.data.frame(
    pep_prot))[, lapply(.SD, function(x) toString(na.omit(x))), by = pep]
  
  # Initialize matrices for average and sum of protein groups
  prot.grp.avg = pep_prot[, 1:2]
  prot.grp.sum = pep_prot[, 1:2]
  
  # Calculate average or sum based on user choice
  if (group.protein == T) {
    if (average == T) {
      for (i in 3:(ncol(nosv) + 2)) {
        avg = sapply(as.matrix(pep_prot[, ..i]), 
                     function(x) mean(scan(text = x, what=numeric(), sep=",", 
                                           quiet = T), na.rm=TRUE))
        prot.grp.avg = cbind(prot.grp.avg, avg)
      }
      colnames(prot.grp.avg) = colnames(pep_prot)
    } else {
      for (i in 3:(ncol(nosv) + 2)) {
        sum = sapply(as.matrix(pep_prot[, ..i]), 
                     function(x) sum(scan(text = x, what=numeric(), sep=",", 
                                          quiet = T), na.rm=TRUE))
        prot.grp.sum = cbind(prot.grp.sum, sum)
      }
      colnames(prot.grp.sum) = colnames(pep_prot)
    }
  } else {
    for (i in 3:(ncol(nosv) + 2)){
      avg = sapply(strsplit(pep_prot[[i]], ","), "[", 1)
      prot.grp.avg = cbind(prot.grp.avg, avg)
    }
    colnames(prot.grp.avg) = colnames(pep_prot)
  }
  # Choose between average and sum based on user choice
  if (average == T)
    prot.grp = prot.grp.avg
  else
    prot.grp = prot.grp.sum
  # Convert result to matrix and return
  prot.grp = as.matrix(prot.grp[, -c(1,2)])
  prot.grp = apply(prot.grp, 2, as.numeric)
  rownames(prot.grp) = paste0(pep_prot$pep, " @ ", pep_prot$prot)
  return(prot.grp)
}

# Function to calculate coefficient of variation
getCV = function(df){
  # Function to calculate coefficient of variation for each row
  calCV <- function(x){
    (sd(x, na.rm = T)/mean(x, na.rm = T))
  }
  # Apply the function to each row of the dataframe
  cv = apply(df, 1, function (x) calCV(x))
  return(cv)
}
