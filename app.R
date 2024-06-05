library(shiny)
source("object_store.R")

ui <- fluidPage(
  titlePanel("ASLI"),
  mainPanel(
    tableOutput("asliTable")
  )
)

server <- function(input, output) {
  # Fetch asli output from the object store
  asli_output <- get_asli_from_s3(
    access_key_id = Sys.getenv("ACCESS_KEY"),
    secret_access_key = Sys.getenv("SECRET_KEY"),
    endpoint = Sys.getenv("S3_ENDPOINT"),
    bucket = Sys.getenv("BUCKET"),
    key = Sys.getenv("KEY")
  )
  
  output$asliTable <- renderTable({
    asli_output
  })
}

shinyApp(ui = ui, server = server)
