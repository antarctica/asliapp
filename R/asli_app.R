#' Run the Shiny Application
#'
asli_app <- function(
  ui = app_ui,
  server = app_server
) {
    shiny::shinyApp(
      ui = app_ui,
      server = app_server
  )
}
