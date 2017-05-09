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
    c("sudo apt-get update\n",res)

  } else {
    res
  }

}

#' Basic system setup
#'
#' Helper function to create basic setup for system
#'
#'
#' @author VP Nagraj (\email{vpnagraj@virginia.edu})
#'
#'
#'
#' @examples
#' setup()

setup <- function() {

  "sudo sh -c 'echo 'deb http://cran.rstudio.com/bin/linux/ubuntu trusty/' >> /etc/apt/sources.list'"

}

#' RStudio Server
#'
#' Helper function to create RStudio Server setup
#'
#' @author VP Nagraj (\email{vpnagraj@virginia.edu})
#'
#' @param include logical indicating whether or not you should include the RStudio server
#'
#' @examples
#' rstudio_server()

rstudio_server <- function(include = TRUE) {

  if(include) {

    "wget https://download2.rstudio.org/rstudio-server-1.0.143-amd64.deb\n
sudo gdebi rstudio-server-1.0.143-amd64.deb <<EOF
    y
    EOF"

  } else {

    invisible()

  }

}

#' Shiny Server
#'
#' Helper function to create Shiny Server setup
#'
#' @author VP Nagraj (\email{vpnagraj@virginia.edu})
#'
#' @param include logical indicating whether or not you should include the Shiny server
#'
#' @examples
#' shiny_server()

shiny_server <- function(include = TRUE) {

  if(include) {

    "sudo su - \
-c 'R -e \'install.packages('shiny', repos='https://cran.rstudio.com/')\''\nwget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.3.838-amd64.deb\nsudo gdebi shiny-server-1.5.3.838-amd64.deb<<EOF
    y
    EOF"

  } else {

    invisible()

  }

}
