#' Run the bootstrapr GUI
#'
#' This function launches the \code{bootstrapr} GUI, which is a Shiny application on a local host. The app features:
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
#' bootstrapr_gui()
#'
#' bootstrapr_gui(display.mode = "showcase")
#' }

bootstrapr_gui <- function(...) {

    shiny::runApp(system.file("bootstrapr_gui", package = "bootstrapr"), ...)

}
