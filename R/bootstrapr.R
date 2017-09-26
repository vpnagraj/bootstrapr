#' Create the bootstrapping script
#'
#' This function creates the bootstrapping script
#'
#' @export
#'
#' @author VP Nagraj (\email{vpnagraj@virginia.edu})
#'
#' @param cran character vector indicating the packages to be installed from \url{https://cran.r-project.org/}
#' @param bioc character vector indicating the packages to be installed from \url{http://bioconductor.org/}
#' @param write logical indicating whether or not to write the bootstrapping statement to a file
#' @param file_name name of file to be written; defaults to "bootstrap.sh"
#' @param docker logical indicating whether or not the bootstrapped script generated should be in DOCKERFILE format
#' @param rstudio_server logical indicating whether or not to include a RStudio Server
#' @param shiny_server logical indicating whether or not to include a Shiny Server
#' @param cran_repo a character vector of length 1 specifying the CRAN mirror from which you want to install the packages; defaults to user's CRAN mirror global option

bootstrapr <- function(cran = NULL, bioc = NULL, write = FALSE, file_name = "bootstrap.sh", docker = FALSE, rstudio_server = TRUE, shiny_server = TRUE, cran_repo = getOption("repos")["CRAN"]) {

  script <-
    c(setup(docker),
      dependencies(),
      packages(cran, bioc, cran_repo),
      rstudio_server(rstudio_server),
      shiny_server(shiny_server))

  script <- paste0(c("#!/bin/sh", script), collapse = "\n")

  if(write) {

    write(paste0(script, collapse = "\n"),
          file = file_name,
          append = FALSE)

  }

  paste0(script, collapse = "\n")

}
