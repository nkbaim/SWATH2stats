utils::globalVariables(c("aggr_Peak_Area", "Peptide_Charge", "Peptide_Charge_Condition", ".N"))

filter_mscore_condition <- function(data, mscore, n.replica, rm.decoy=TRUE){

  data$Peptide_Charge <- paste(data$FullPeptideName, data$Charge) # a column with unique identifiers for each Precurso (e.g. ADFSDF 3) is generated
  data$Peptide_Charge_Condition <- paste(data$Peptide_Charge, data$Condition) # a column with unique identifiers for each Precursor and Condition is genrated ADFSDF 3 Condition 1
  
  # decoys are removed if present
  if(sum(colnames(data) == "decoy") == 1 & isTRUE(rm.decoy)){
    data <- data[data$decoy == 0,]
    #data <- subset(data, decoy == 0)
  }
  
  # only data that is below the indicated mscore is selected and then only the unique data selected
  #data.filtered <- subset(data, m_score <= mscore)
  data.filtered <- data[data$m_score <= mscore,]
  data.filtered <- unique(data.filtered[,c("Peptide_Charge", "Peptide_Charge_Condition", "aggr_Peak_Area")])
  data.filtered <- data.table(data.filtered)
  
  setkey(data.filtered, Peptide_Charge, Peptide_Charge_Condition, aggr_Peak_Area) 
  # number of occurences of Precursor per Condition is calculated
  data.n <- data.filtered[, .N, by="Peptide_Charge,Peptide_Charge_Condition"]

  # only precursors that are present in more that n.replica are selected
  precursor.filtered <- data.n[data.n$N >= n.replica]
  precursor.filtered <- data.frame(Peptide_Charge = unique(precursor.filtered$Peptide_Charge))
  
  message("Fraction of peptides selected: ",
          signif(length(unique(precursor.filtered$Peptide_Charge))
                 /length(unique(data$Peptide_Charge)), digits=2))
  
  # only data that is present in the precursor.filtered list is selected
  data.filtered <- merge(data, precursor.filtered, by.x="Peptide_Charge", by.y="Peptide_Charge")
  
  message("Dimension difference: ", paste(dim(data)-dim(data.filtered), collapse=", "))
  
  return(data.filtered)
}
