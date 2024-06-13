library(shiny)

asliApp <-function(...) {
  ui <- fluidPage(
    theme = light,
    titlePanelBAS(
      "Amundsen Sea Low Index (ASLI)"
    ),
    
    br(),
    
    navlistPanel(
      id = "tabset",
      widths = c(3, 7),
      well = FALSE,
      header = img(
        src = "https://scotthosking.com/assets/images/asl_index-crop3.png",
        style = "height: 350px;vertical-align:top"
      ),
      "Background",
      tabPanel(
        "What is ASLI?",
        br(),
        htmltools::includeMarkdown("background.md")
      ),
      "ASLI Output",
      tabPanel(
        "ASLI Calculation Output",
        reactable::reactableOutput("asliTable"),
      ),
      tabPanel(
        "ASLI Plotting Output"
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
      ),
      bslib::nav_item(
        bslib::input_dark_mode(
          id = "dark_mode"
        )
      )
    )
  )
  
  server <- function(input, output) {
    # Creating a reactive with the light/dark theme.
    # This is to pass the theme to reactable
    current_theme <- reactive({
      if (input$dark_mode == "dark") {
        "dark"
      } else {
        "light"
      }
    })
    
    # Fetch asli output from the object store
    asli_output <- get_asli_from_s3(
      access_key_id = Sys.getenv("ACCESS_KEY"),
      secret_access_key = Sys.getenv("SECRET_KEY"),
      endpoint = Sys.getenv("S3_ENDPOINT"),
      bucket = Sys.getenv("BUCKET"),
      key = Sys.getenv("KEY")
    )
    
    output$asliTable <- reactable::renderReactable({
      reactable::reactable(
        asli_output,
        theme = reactable_table_theme(
          current_theme
        )
      )
    })
  }
  
  shinyApp(ui = ui, server = server)
}