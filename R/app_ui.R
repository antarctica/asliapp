#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#' @import shiny
#' @noRd
app_ui <- bslib::page_navbar(
  title = div(
    style = "display: flex; align-items: center; gap: 10px;",
    tags$img(
      src = "https://cdn.web.bas.ac.uk/bas-style-kit/0.7.3/img/logos-symbols/bas-logo-inverse-transparent-128.png",
      height = "50px",
      alt = "British Antarctic Survey Logo"
    ),
    "Amundsen Sea Low Index"
  ),
  theme = bslib::bs_theme(preset = "bootstrap"),
  shinyjs::useShinyjs(),
  # golem_add_external_resources(),

    # Add favicon
    tags$head(
      tags$link(
        rel = "shortcut icon",
        href = "https://cdn.web.bas.ac.uk/bas-style-kit/0.6.1/img/logos-symbols/bas-roundel-default-transparent-32.png"
      )
    ),
  
  bslib::nav_panel(
    title = "Main",
    bslib::layout_sidebar(
      sidebar = bslib::sidebar(
        # title = "Table of Contents",
        bslib::accordion(
          bslib::accordion_panel(
            "Section 1",
            tags$a("1.1 Introduction", href = "#section1-1", class = "nav-link"),
            tags$a("1.2 Background", href = "#section1-2", class = "nav-link")
          ),
          bslib::accordion_panel(
            "Section 2",
            tags$a("2.1 Methods", href = "#section2-1", class = "nav-link"),
            tags$a("2.2 Results", href = "#section2-2", class = "nav-link")
          )
        )
      ),
      
      bslib::card(
        id = "section1-1",
        bslib::card_header("1.1 Introduction"),
        # tags$iframe(
        #   src = "www/what_is_asli.html",
        #   style = "width: 100%; height: 800px; border: none;"
        # )
      ),
      
      bslib::card(
        id = "section1-2",
        bslib::card_header("1.2 Background"),
        p("Here we discuss the background information necessary to understand the topic.")
      ),
      
      bslib::card(
        id = "section2-1",
        bslib::card_header("2.1 ASLI Calculation Output (WIP)"),
        tableOutput("asliMetadata"),
        reactable::reactableOutput("asliTable"),
        p("The data can be downloaded from [PDC LOCATION TBC].")
      ),
      
      bslib::card(
        id = "section2-2",
        bslib::card_header("2.2 ASLI Plotting Output (WIP)"),
        tags$head(
          tags$style(HTML("
              #asliPlot > img {
                max-width: 800px;
              }
            "))
        ),
        numericInput("plot_year", "Year:", 2024, min = 2023, max = 2024),
        imageOutput(outputId = "asliPlot")
      )
    )
  )
)

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )
  
  tags$head(
    favicon(ext = "png"),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "asliapp"
    )
  )
}
