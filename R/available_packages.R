#' Find available packages
#'
#' This function is a wrapper for the base \code{available.packages}.
#'
#' @export
#'
#' @author VP Nagraj (\email{vpnagraj@virginia.edu})
#'
#' @param source specify the source for the packages
#'
#' @param ... further parameters to be passed to the \code{\link{available.packages}} function
#'
#' @examples
#'available_packages()
#'available_packages(source = "Bioc")

available_packages <- function(source = "CRAN", ...) {

  sources <- c("CRAN", "Bioconductor")

  if (source == "CRAN") {
    utils::available.packages(...)
  # } else if (source == "Bioconductor") {
  #   cat("will look for bioconductor packages")
  } else {
    stop(paste0("valid 'source' arguments include:",
                sapply(sources, paste0, "\n"),
                collapse = "\n")
    )
  }

}
