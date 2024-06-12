#' Getting a reactable table theme according to light/darkmode
#'
#' @description This function returns a table of
#' general information for a minileague. Automatically return a
#' table for the current gameweek.
#'
#' @param current_theme the theme is format "dark" or "light"
#'
#' @export
#'
reactable_table_theme <- function(current_theme) {
  if (current_theme() == "dark") {
    reactable::reactableTheme(
      backgroundColor = "#333333",
      borderColor = "#FFFFFF",
      color = "#28A197"
    )
  } else {
    reactable::reactableTheme(
      backgroundColor = "#FFFFFF",
      borderColor = "#333333",
      color = "#6F72AF"
    )
  }
}