#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Fetch the object store body
  s3_body <- get_s3_body(
    access_key_id = Sys.getenv("ACCESS_KEY"),
    secret_access_key = Sys.getenv("SECRET_KEY"),
    endpoint = Sys.getenv("S3_ENDPOINT"),
    bucket = Sys.getenv("BUCKET")
  )
  
  # Obtain dataframe and metadata
  asli_output <- get_asli_data(
    s3_body,
    data_requested = "dataframe"
  )
  
  asli_metadata <- get_asli_data(
    s3_body,
    data_requested = "metadata"
  )
  
  output$backgroundRender <- renderUI({
    tags$iframe(
      src = "R/what_is_asli.html",
      style = 'width:1000px;height:100vh;'
    )
  })
  
  output$asliMetadata <- renderTable({
    asli_metadata
  })
  
  output$asliTable <- reactable::renderReactable({
    reactable::reactable(
      asli_output
    )
  })
  
  output$asliPlot <- renderImage({
    reticulate::use_virtualenv("aslienv")
    reticulate::source_python("R/asli_import.py")
    list(src = 'plt.png')
  },
  deleteFile = FALSE
  )
}
