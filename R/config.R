#' Build dependencies
#'
#' This function makes it possible to parameterize tools to be installed
#'
#' @author VP Nagraj (\email{vpnagraj@virginia.edu})
#'
#' @param deps system dependencies to be installed, specified as a vector
#'

dependencies <- function(deps = NULL) {

  deps <- c(deps,
            "r-base --allow-unauthenticated",
            "libapparmor1",
            "libcurl4-gnutls-dev",
            "libxml2-dev",
            "libssl-dev",
            "gdebi-core",
            "libcairo2-dev",
            "libxt-dev")

  sapply(deps,
         function(x) paste0("\nsudo apt-get -y install ", x, collapse = "\n"))

}

#' Basic system setup
#'
#' Helper function to create basic setup for system
#'
#'
#' @author VP Nagraj (\email{vpnagraj@virginia.edu})

setup <- function() {

  # "sudo sh -c 'echo 'deb http://cran.rstudio.com/bin/linux/ubuntu xenial/' >> /etc/apt/sources.list'"
  "echo 'deb http://cran.rstudio.com/bin/linux/ubuntu xenial/' >> /etc/apt/sources.list\nsudo apt-get update"

}

#' RStudio Server
#'
#' Helper function to create RStudio Server setup
#'
#' @author VP Nagraj (\email{vpnagraj@virginia.edu})
#'
#' @param include logical indicating whether or not you should include the RStudio server

rstudio_server <- function(include = TRUE) {

  if(include) {

    "wget https://download2.rstudio.org/rstudio-server-1.0.143-amd64.deb\n
echo 'y' | sudo gdebi rstudio-server-1.0.143-amd64.deb
    "

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

shiny_server <- function(include = TRUE) {

  if(include) {

    paste0("wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.3.838-amd64.deb\necho 'y'| sudo gdebi shiny-server-1.5.3.838-amd64.deb\n",
           cran_packages("shiny"),
           collapse = "\n")

  } else {

    invisible()

  }

}
