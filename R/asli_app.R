#' Run the Shiny Application
#'
#' @param ui shiny app_ui() in app_ui.R
#' @param server shiny app_server() in app_server.R
asli_app <- function(
  ui = app_ui,
  server = app_server
) {
    shiny::shinyApp(
      ui = app_ui,
      server = app_server
  )
}
