#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Add smooth scrolling behavior for navigation links
  shiny::observe({
    shinyjs::runjs("
      document.querySelectorAll('a[href^=\"#\"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
          e.preventDefault();
          const targetId = this.getAttribute('href').substring(1);
          const targetElement = document.getElementById(targetId);
          if (targetElement) {
            targetElement.scrollIntoView({ behavior: 'smooth' });
          }
        });
      });
    ")
  })
  
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
  
  asli_image <- reactive({
    asli_image <- get_asli_plot(
      s3_body,
      year = input$plot_year
    )
    
    list(
      raster = as.raster(asli_image),
      w = magick::image_info(asli_image)$width,
      h = magick::image_info(asli_image)$height
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
  
  output$asliPlot <- renderPlot({
    plot(
      asli_image()$raster
    )
  },
  width = 1200,
  height = 1200
  )
}
