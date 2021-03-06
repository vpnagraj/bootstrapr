% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/packages.R
\name{cran_packages}
\alias{cran_packages}
\title{Build list of CRAN packages}
\usage{
cran_packages(packages = NULL, cran_repo = getOption("repos")["CRAN"])
}
\arguments{
\item{packages}{a character vector specifying packages from CRAN repository that you would like to install}

\item{cran_repo}{a character vector of length 1 specifying the CRAN mirror from which you want to install the packages; defaults to user's CRAN mirror global option}
}
\description{
Creates the list of packages from CRAN to be installed on the server
}
\author{
VP Nagraj (\email{vpnagraj@virginia.edu})
}
