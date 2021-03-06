\name{plot_variation}
\alias{plot_variation}
\title{
Plots the coefficient of variation for different replicates
}
\description{
This function plots the coefficient of variation within replicates for a given value. If decoys are present these are removed before plotting.
}
\usage{
plot_variation(data, column.values = "Intensity", 
Comparison = transition_group_id + Condition ~ BioReplicate,
fun.aggregate = NULL, label=TRUE, ...)
}
\arguments{
  \item{data}{
Data frame that is produced by the OpenSWATH/pyProphet workflow
}
  \item{column.values}{
Indicates the columns for which the variation is assessed. This can be the Intensity or Signal, but also the retention time.
}
  \item{Comparison}{
The comparison for assessing the variability. Default is to assess the variability per transition_group_id and Condition over the different Replicates. Comparison is performed using the dcast() function of the reshape2 package.
}
  \item{fun.aggregate}{
If for the comparison values have to be aggregated one needs to provide the function here.}
  \item{label}{
Option to print value of median cv.}
  \item{\dots}{
further arguments passed to method.}
}
\value{
Returns a list with the data and calculated cv and a table that summarizes the mean, median and mode cv per Condition (if Condition is contained in the comparison). In addition it plots in Rconsole a violin plot with the observed coefficient of variations.
}

\author{
Peter Blattmann
}
\examples{
data("OpenSWATH_data", package="SWATH2stats")
data("Study_design", package="SWATH2stats")
data <- sample_annotation(OpenSWATH_data, Study_design)
plot_variation(data)
}
