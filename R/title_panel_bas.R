#' Title Panel for BAS
#' 
#' Themed title panel
title_panel_bas <- function(
    title = "BAS Shiny app",
    windowTitle = title
){
  htmltools::div(
    htmltools::img(
      src = "https://cdn.web.bas.ac.uk/bas-style-kit/0.6.1/img/logos-symbols/bas-logo-default-transparent-128.png",
      style = "height: 75px;vertical-align:middle;"
    ),
    htmltools::h1(
      title,
      style ='vertical-align:middle; display:inline;padding-left:50px;'
    ),
    htmltools::tagList(
      tags$head(
        tags$title(
          paste0(
            windowTitle,
            " | British Antarctic Survey")),
        tags$link(
          rel = "shortcut icon",
          href = "https://cdn.web.bas.ac.uk/bas-style-kit/0.6.1/img/logos-symbols/bas-roundel-default-transparent-32.png"
        )
      )
    )
  )
}
