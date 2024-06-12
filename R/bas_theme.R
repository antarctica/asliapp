#theming with bslib
bas_light <- bslib::bs_theme(
  bg = "#FFFFFF",
  fg = "#333333",
  primary = "#28A197",
  secondary = "#6F72AF",
  success = "#379245",
  info = "#2B8CC4",
  warning = "#FFBF47",
  base_font = bslib::font_google("Open Sans")
)

#increase the font weight of the headings (h1, h2, h3, h4, h5, h6)
light <- bslib::bs_add_variables(
  bas_light,
  # low level theming
  "headings-font-weight" = 600
)

#theming with bslib
bas_dark <- bslib::bs_theme(
  bg = "#333333",
  fg = "#FFFFFF",
  primary = "#28A197",
  secondary = "#6F72AF",
  success = "#379245",
  info = "#2B8CC4",
  warning = "#FFBF47",
  base_font = bslib::font_google("Open Sans")
)

#increase the font weight of the headings (h1, h2, h3, h4, h5, h6)
dark <- bslib::bs_add_variables(
  bas_dark,
  # low level theming
  "headings-font-weight" = 600
)