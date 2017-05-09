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
#'
#' @examples
#' bootstrapr()

bootstrapr <- function(write = TRUE, file_name = "bootstrap", file_ext = ".sh", ...) {

  if(write) {

    if(file_ext == ".sh") {
        write(
          paste0(
          "#!/bin/sh\n",
          setup(...),
          dependencies(...),
          packages(...),
          rstudio_server(),
          shiny_server(),
          collapse = "\n"),
          file = paste0(file_name,file_ext)
          )
    } else {

      write(
        paste0(
          dependencies(...),
          packages(...),
          rstudio_server(),
          shiny_server(),
          collapse = "\n"),
        file = paste0(file_name,file_ext)
      )
    }
  }

  cat(
    setup(...),
    dependencies(...),
    packages(...),
    rstudio_server(),
    shiny_server(),
    collapse = "\n")

}
