#' Run the bootstrapr Shiny app
#'
#' This function launches the \code{bootstrapr} app, which is a Shiny application on a local host. The app features:
#' \itemize{
#' \item{interface for selecting packages to add}
#' }
#'
#' @export
#'
#' @author VP Nagraj (\email{vpnagraj@virginia.edu})
#'
#' @param ... further parameters to be passed to the \code{\link[shiny]{runApp}} function from the Shiny package
#'
#' @examples
#'
#' \dontrun{
#' bootstrapr_app()
#'
#' bootstrapr_app(display.mode = "showcase")
#' }

bootstrapr_app <- function(...) {

    shiny::runApp(system.file("bootstrapr_app", package = "bootstrapr"), ...)

}
