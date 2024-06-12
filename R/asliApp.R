library(shiny)

asliApp <-function(...) {
  ui <- fluidPage(
    titlePanelBAS(
      "Amundsen Sea Low Index",
    ),
    theme = "bas_light",
    
    bslib::input_dark_mode(
      id = "dark_mode"
    ),
    
    navlistPanel(
      id = "tabset",
      "Background",
      tabPanel(
        "Amundsen Sea Low Index"
      ),
      "ASLI Output",
      tabPanel(
        "ASLI Calculation Output",
        reactable::reactableOutput("asliTable"),
      ),
      tabPanel(
        "ASLI Plotting Output"
      ),
      tabPanel(
        tags$a(
          icon("github"),
          "Application Source Code",
          href = "https://github.com/antarctica/asliapp",
          target = "_blank"
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