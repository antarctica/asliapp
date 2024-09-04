#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    golem_add_external_resources(),
    fluidPage(
      theme = light,
      titlePanelBAS(
        "Amundsen Sea Low Index"
      ),
      # Disables scrollbars - due to double bars for iframe
      tags$head(
        tags$style(
          "body{overflow:hidden;}"
        )
      ),
      br(),
      navlistPanel(
        id = "tabset",
        widths = c(3, 9),
        well = FALSE,
        "Background",
        tabPanel(
          "What is ASLI?",
          htmlOutput("backgroundRender")
        ),
        "ASLI Output",
        tabPanel(
          "ASLI Calculation Output (WIP)",
          tableOutput("asliMetadata"),
          reactable::reactableOutput("asliTable"),
          p("The data can be downloaded from [PDC LOCATION TBC].")
        ),
        tabPanel(
          "ASLI Plotting Output (WIP)"
        ),
        "Source Code",
        bslib::nav_item(
          a(
            icon("github"),
            "Application Source Code",
            href = "https://github.com/antarctica/asliapp",
            target = "_blank"
          )
        ),
        bslib::nav_item(
          a(
            icon("github"),
            "`asli` Python Package Source Code",
            href = "https://github.com/davidwilby/amundsen-sea-low-index",
            target = "_blank"
          )
        ),
        bslib::nav_item(
          a(
            icon("github"),
            "Pipeline Source Code",
            href = "https://github.com/antarctica/boost-eds-pipeline",
            target = "_blank"
          )
        )
      )
    )
  )
}

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
