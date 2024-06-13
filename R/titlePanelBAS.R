titlePanelBAS <- function(
    title = "BAS Shiny app",
    windowTitle = title
){
  div(
    column(3,
           img(
             src = "https://cdn.web.bas.ac.uk/bas-style-kit/0.6.1/img/logos-symbols/bas-logo-default-transparent-128.png",
             style = "height: 50px;vertical-align:middle;"
           )
    ),
    column(9,
           h2(  
             title,
             style ='vertical-align:left'
           ),
           tagList(
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
  )
}