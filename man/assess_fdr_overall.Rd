\name{assess_fdr_overall}
\alias{assess_fdr_overall}
\title{
Assess overall FDR in annotated OpenSWATH/pyProphet output table in dependence of m_score cutoff
}
\description{
This function estimates the assay, peptide and protein FDR over a multi-run OpenSWATH/pyProphet output table. It counts target and decoy assays (unique transition_group_id), peptides (unique FullPeptideName) and proteins (unique ProteinName) in dependence of the m-score cutoff (1e-2 to 1e-20).

To arrive from decoy counts at an estimation of the false discovery rate (false positives among the targets remaining at a given mscore cutoff) the ratio of false positives to true negatives (decoys) (FFT) must be supplied. It is estimated for each run individually by pyProphet and contained in the pyProphet statistics [Injection_name]_full_stat.csv. As an approximation, the FFTs of multiple runs are averaged and supplied as argument FFT. For further details see the Vignette Section 1.3 and 4.1.

Protein FDR control on peak group quality level is a very strict filter and should be handled with caution.

FDR is calculated as FDR = (TN*FFT/T); TN=decoys, T=targets, FFT=see above
}
\usage{
assess_fdr_overall(data, FFT, n.range = 20, output = "pdf_csv", plot = TRUE, 
filename="FDR_report_overall")
}
\arguments{
  \item{data}{
Data table that is produced by the OpenSWATH/pyProphet workflow
}
  \item{n.range}{
  Option to set the number of magnitude for which the m_score threshold is decreased (e.g. n.range = 10, m-score from 0.1 until 10^-10)^.
  }

  \item{FFT}{
Ratio of false positives to true negatives, q-values from [Injection_name]_full_stat.csv in pyProphet stats output. As an approximation, the q-values of multiple runs are averaged and supplied as argument FFT. Numeric from 0 to 1. Defaults to 1, the most conservative value (1 Decoy indicates 1 False target).
}
   \item{output}{
Choose output type. "pdf_csv" creates the output as files in the working directory, "Rconsole" triggers delivery of the output to the console enabling further computation or custom plotting / output.
}
  \item{plot}{
Logical, whether or not to create plots from the results (using the associated method plot.fdr_table()
}
  \item{filename}{
Optional, modifying the basename of the result files if applicable.
}
}
\value{
Returns a list of class "fdr_table". If output "pdf_csv" and plot = TRUE were chosen, report files are written to the working folder.
}
\author{
Moritz Heusel
}
\examples{
data("OpenSWATH_data", package="SWATH2stats")
data("Study_design", package="SWATH2stats")
data <- sample_annotation(OpenSWATH_data, Study_design)
assess_fdr_overall(data, FFT=0.7, output = "Rconsole", plot = TRUE, 
filename="Testoutput_assess_fdr_overall")
}
