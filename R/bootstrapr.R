#' Create the bootstrapping script
#'
#' This function creates the bootstrapping script
#'
#' @export
#'
#' @author VP Nagraj (\email{vpnagraj@virginia.edu})
#'
#' @param write logical indicating whether or not to write the bootstrapping statement to a file
#' @param file_name name of file to be written; defaults to "bootstrap"
#' @param file_ext character vector of length 1 indicating file extension to use; defaults to ".sh"
#' @param rstudio logical indicating whether or not to include a RStudio Server
#' @param shiny logical indicating whether or not to include a Shiny Server
#'
#' @examples
#' bootstrapr()

bootstrapr <- function(cran = NULL, bioc = NULL, write = TRUE, file_name = "bootstrap", file_ext = "sh", rstudio = TRUE, shiny = TRUE) {

  script <-
    c(setup(),
      dependencies(),
      packages(cran, bioc),
      rstudio_server(),
      shiny_server())


  if(file_ext == "sh") {

    script <- paste0(c("#!/bin/sh", script), collapse = "\n")

  }

  if(write) {

    write(paste0(script, collapse = "\n"),
          file = paste0(c(file_name, ".", file_ext), collapse = ""),
          append = FALSE)

  }

  cat(script, collapse = "\n")

}
