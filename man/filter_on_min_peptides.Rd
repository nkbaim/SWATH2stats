\name{filter_on_min_peptides}
\alias{filter_on_min_peptides}
\title{
Filter openSWATH output for proteins that are identified by a minimum of n independent peptides
}
\description{
This function removes entries mapping to proteins that are identified by less than n_peptides.

Removing single-hit proteins from an analysis can significantly increase the sensitivity under strict protein fdr criteria, as evaluated by e.g. assess_fdr_overall.
}
\usage{
filter_on_min_peptides(data, n_peptides)
}
\arguments{
  \item{data}{
Data table that is produced by the openSWATH/iPortal workflow.
}
  \item{n_peptides}{
Number of minimal number of peptide IDs associated with a protein ID in order to be kept in the dataset.
}
}
\value{
Returns the filtered data frame with only peptides that map to proteins with >= n_peptides peptides.
}
\author{
Moritz Heusel
}
\examples{
data("OpenSWATH_data", package="SWATH2stats")
data("Study_design", package="SWATH2stats")
data <- sample_annotation(OpenSWATH_data, Study_design)
data.filtered <- filter_mscore_freqobs(data, 0.01,0.8)
data.max <- filter_on_max_peptides(data.filtered, 5)
data.min.max <- filter_on_min_peptides(data.max, 3)
}
