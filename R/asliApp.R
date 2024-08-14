library(shiny)
my_path <- "R"
addResourcePath(prefix = "R", directoryPath = my_path)

asliApp <-function(...) {
  ui <- fluidPage(
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
        reactable::reactableOutput("asliTable"),
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
  
  server <- function(input, output) {
    # Fetch the object store body
    s3_body <- get_s3_body(
      access_key_id = Sys.getenv("ACCESS_KEY"),
      secret_access_key = Sys.getenv("SECRET_KEY"),
      endpoint = Sys.getenv("S3_ENDPOINT"),
      bucket = Sys.getenv("BUCKET")
    )

    # Obtain dataframe and metadata
    asli_output <- get_asli_df(
      s3_body
    )

    asli_metadata <- get_asli_metadata(
      s3_body
    )
    
    output$backgroundRender <- renderUI({
      tags$iframe(
        src = "R/what_is_asli.html",
        style = 'width:1000px;height:100vh;'
      )
    })
    
    output$asliTable <- reactable::renderReactable({
      reactable::reactable(
        asli_output
      )
    })
  }
  
  shinyApp(ui = ui, server = server)
}