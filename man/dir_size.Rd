% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_gh_size.r
\name{dir_size}
\alias{dir_size}
\title{Check size of a directory}
\usage{
dir_size(path)
}
\arguments{
\item{path}{The full path to directory to be sized}
}
\value{
Sum of size of files in directory
}
\description{
The function uses identified path to check the size of given directory. It returns the total size of files in the directory
}
\examples{
\dontrun{
dir_size(path = "C:/ghBackup/R")
}

}
