#' Build list of packages
#'
#' Creates the list of packages to be installed on the server
#'
#' @export
#'
#' @author VP Nagraj (\email{vpnagraj@virginia.edu})
#'
#' @param cran a character vector specifying packages from CRAN repository that you would like to install
#'
#' @param bioc a character vector specifying packages from the Bioconductor repository that you would like to install
#' @param ... further parameters to be passed the cran_packages() internal function
#'
#' @examples
#' \dontrun{
#'packages(cran = c("dplyr", "ggplot2", "epicontacts", "rrefine"))
#'}

packages <- function(cran = NULL, bioc = NULL, ...) {

  if (is.null(cran) & is.null(bioc)) {

    invisible()

  } else {

    paste0(cran_packages(packages = cran, ...),
           "\n",
           bioc_packages(packages = bioc))

  }
}

#' Build list of CRAN packages
#'
#' Creates the list of packages from CRAN to be installed on the server
#'
#' @export
#'
#' @author VP Nagraj (\email{vpnagraj@virginia.edu})
#'
#' @param packages a character vector specifying packages from CRAN repository that you would like to install
#' @param cran_repo a character vector of length 1 specifying the CRAN mirror from which you want to install the packages; defaults to user's CRAN mirror global option
#'
#'

cran_packages <- function(packages = NULL, cran_repo = getOption("repos")["CRAN"]) {

  # define 'not in' operator
  '%!in%' <- function(x,y)!('%in%'(x,y))

  if(is.null(packages)) {

    invisible()

  } else {

    check <- packages[packages %!in% row.names(available_packages(repos = cran_repo))]

    if (length(check) > 0) {

      stop(sprintf("%s is not available in the CRAN repository you specified ...\n", check))

    } else {

    paste0("sudo R --no-save << EOF\n",
           "install.packages(c(",
           eval(paste0("'", packages, "'", collapse = ",")),
           "), repos = ",
           paste0("'", cran_repo, "'"),
           ")\nEOF")
    }
  }
}

#' Creates the list of packages from Bioconductor to be installed on the server
#'
#' @export
#'
#' @author VP Nagraj (\email{vpnagraj@virginia.edu})
#'
#' @param packages a character vector specifying packages from Bioconductor repository that you would like to install
#'
#'

bioc_packages <- function(packages = NULL) {

  if(is.null(packages)) {

    invisible()

  } else {

    paste0("sudo R --no-save << EOF\n",
           "source('https://bioconductor.org/biocLite.R'); biocLite(c(",
           eval(paste0("'", packages, "'", collapse = ",")),
           "))\nEOF")
  }

}
