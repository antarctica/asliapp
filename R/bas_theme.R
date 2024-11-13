#' BAS Theme
#' 
#' Put togther use style guide
light <- bslib::bs_theme(
  bg = "#FFFFFF",
  fg = "#333333",
  primary = "#28A197",
  secondary = "#6F72AF",
  success = "#379245",
  info = "#2B8CC4",
  warning = "#FFBF47",
  base_font = bslib::font_google("Open Sans")
)

light <- bslib::bs_add_variables(
  light,
  "headings-font-weight" = 600
)
