#' Build dependencies
#'
#' This function makes it possible to parameterize tools to be installed
#'
#' @export
#'
#' @author VP Nagraj (\email{vpnagraj@virginia.edu})
#'
#' @param deps system dependencies to be installed, specified as a vector
#'
#' @param update logical vector indicating whether or not to run \code{apt-get update}
#'
#'
#' @examples
#' dependencies()

dependencies <- function(deps = NULL, update = TRUE) {

  deps <- c(deps,
            "r-base",
            "libapparmor1",
            "libcurl4-gnutls-dev",
            "libxml2-dev",
            "libssl-dev",
            "gdebi-core",
            "libcairo2-dev",
            "libxt-dev",
            "git-core")

  res <- sapply(deps,
         function(x) paste0("\nsudo apt-get -y install ", x, collapse = "\n"))

  if(update) {
    # cat(paste0("sudo apt-get update ",res, collapse = "\n"))
    # cat(c("sudo apt-get update\n",res))
    c("sudo apt-get update\n",res)

  } else {
    # cat(res)
    res
  }

}

#' Basic system setup
#'
#' Helper function to create basic setup for system
#'
#' @export
#'
#' @author VP Nagraj (\email{vpnagraj@virginia.edu})
#'
#'
#'
#' @examples
#' setup()

setup <- function() {

  "sudo sh -c 'echo 'deb http://cran.rstudio.com/bin/linux/ubuntu trusty/' >> /etc/apt/sources.list'\ngpg --keyserver keyserver.ubuntu.com --recv-key E084DAB\ngpg -a --export E084DAB9 | sudo apt-key add -\n"

}

