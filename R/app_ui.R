#' The application User-Interface
#'
#' @importFrom shiny tags div icon markdown tableOutput numericInput imageOutput
#' @importFrom bslib page_navbar nav_spacer nav_item nav_panel layout_sidebar sidebar accordion accordion_panel bs_theme
#' @importFrom reactable reactableOutput
app_ui <- function() {
  shiny::addResourcePath("www", system.file("www", package = "asliapp"))
  
  bslib::page_navbar(
    header = shiny::tags$head(
      shiny::tags$link(rel = "stylesheet", type = "text/css", href = "www/styles.css")
    ),
    
    title = shiny::div(
      style = "display: flex; align-items: center; gap: 10px;",
      shiny::tags$img(
        src = "https://cdn.web.bas.ac.uk/bas-style-kit/0.7.3/img/logos-symbols/bas-logo-default-transparent-128.png",
        height = "80px",
        alt = "British Antarctic Survey Logo"
      ),
      tags$span(
        style = "color: #333333; font-style: bold; font-size: px; font-weight: light",
        "Amundsen Sea Low Index"
      )
    ),
    theme = bslib::bs_theme(),
    
    bslib::nav_panel(
      title = "Overview",
      position = "right",
      bslib::layout_sidebar(
        sidebar = bslib::sidebar(
          title = "Table of Contents",
          bslib::accordion(
            bslib::accordion_panel(
              "Section 1 - Background",
              shiny::tags$a("1.1 Introduction", href = "#section1-1", class = "nav-link"),
              shiny::tags$a("1.2 Python Package", href = "#section1-2", class = "nav-link"),
              shiny::tags$a("1.3 Demonstrating NERC EDS Services", href = "#section1-3", class = "nav-link"),
              shiny::tags$a("1.4 Reproducible Pipeline", href = "#section1-4", class = "nav-link")
            ),
            bslib::accordion_panel(
              "Section 2 - Data",
              shiny::tags$a("2.1 Methods", href = "#section2-1", class = "nav-link"),
              shiny::tags$a("2.2 Results", href = "#section2-2", class = "nav-link")
            ),
            bslib::accordion_panel(
              "References",
              shiny::tags$a("3.1 References", href = "#references-1", class = "nav-link")
            )
          )
        ),
        
        shiny::div(class = "content-section", id = "section1-1",
                   shiny::div(class = "section-header", "1.1 Introduction"),
                   shiny::div(class = "section-content",
                              shiny::markdown(
                                "
                                The Amundsen Seas Low (ASL) is a highly dynamic and mobile climatological low pressure system located in the Pacific sector of the Southern Ocean. In this sector, variability in sea-level pressure is greater than anywhere in the Southern Hemisphere, making it challenging to isolate local fluctuations in the ASL from larger-scale shifts in atmospheric pressure. The position and strength of the ASL are crucial for understanding regional change over West Antarctica.

                                More information can be found [on Scott Hosking's website](https://scotthosking.com/asl_index).
                                
                                ![Example of an ASL location](https://scotthosking.com/assets/images/asl_index-crop3.png)
                                "
                              )
                   )
        ),
        
        shiny::div(class = "content-section", id = "section1-2",
                   shiny::div(class = "section-header", "1.2 Python Package"),
                   shiny::div(class = "section-content",
                              shiny::markdown(
                                "This application uses a python package (`asli`) which implements the ASL calculation methods described in [Hosking *et al.* (2016)](http://dx.doi.org/10.1002/2015GL067143).
            This package was developed by David Wilby at the British Antarctic Survey. You can find more about this package in this [Github repository](https://github.com/davidwilby/amundsen-sea-low-index)."
                              )
                   )
        ),
        
        shiny::div(class = "content-section", id = "section1-3",
                   shiny::div(class = "section-header", "1.3 Demonstrating NERC EDS Services"),
                   shiny::div(class = "section-content",
                              shiny::markdown(
                                "The aim of this application is to demonstrate the usage of different services provided by the [NERC Environmental Data Service (NERC EDS)](https://eds.ukri.org/environmental-data-service).

            We are using a [JASMIN](https://jasmin.ac.uk/) group workspace (GWS) to run a data processing pipeline. Using the [Copernicus Climate Data Store API](https://cds.climate.copernicus.eu/#!/home), ERA5 data is read in. Calculations are then performed on [LOTUS](https://help.jasmin.ac.uk/docs/batch-computing/lotus-overview/) using `asli` functions.Output data is stored on [JASMIN Object Storage](https://help.jasmin.ac.uk/docs/short-term-project-storage/using-the-jasmin-object-store/). This data is read in and displayed by this application. This application in turn is [hosted on Datalabs](https://datalab.datalabs.ceh.ac.uk/).
            
            This means compute, data storage and application hosting are all separated. Each component could also be deployed on different infrastructure, for example BAS HPCs or commercial cloud providers."
                              )
                   )
        ),
        
        shiny::div(class = "content-section", id = "section1-4",
                   shiny::div(class = "section-header", "1.4 Reproducible Pipeline"),
                   shiny::div(class = "section-content",
                              shiny::markdown(
                                "
                                The data processing pipeline is ***WIP*** [documented on Github](https://github.com/antarctica/boost-eds-pipeline), and can be deployed on other platforms.
                                
                                ![](www/asli-technical-overview-light.png)

                                "
                              )
                   )
        ),
        
        shiny::div(class = "content-section", id = "section2-1",
                   shiny::div(class = "section-header", "2.1 ASLI Calculation Output (WIP)"),
                   shiny::div(class = "section-content",
                              shiny::tableOutput("asliMetadata"),
                              reactable::reactableOutput("asliTable"),
                              shiny::p("The data can be downloaded from [PDC LOCATION TBC].")
                   )
        ),
        
        shiny::div(class = "content-section", id = "section2-2",
                   shiny::div(class = "section-header", "2.2 ASLI Plotting Output (WIP)"),
                   shiny::div(class = "section-content",
                              shiny::numericInput("plot_year", "Year:", 2024, min = 2023, max = 2024),
                              shiny::imageOutput(outputId = "asliPlot")
                   )
        ),

        shiny::div(class = "content-section", id = "references-1",
                  shiny::div(class = "section-header", "References"),
                  shiny::div(class = "section-content",
                              shiny::markdown(
                                "
                                Hosking, J. S., A. Orr, T. J. Bracegirdle, and J. Turner (2016), Future circulation changes off West Antarctica: Sensitivity of the Amundsen Sea Low to projected anthropogenic forcing, Geophys. Res. Lett., 43, 367-376, doi:10.1002/2015GL067143.
                                
                                Hosking, J. S., & Wilby, D. asli [Computer software]. https://github.com/scotthosking/amundsen-sea-low-index
                                "
        )
        )
)
      )
    ),
    bslib::nav_spacer(),
    bslib::nav_item(
      shiny::tags$a(
        href = "https://github.com/antarctica/boost-eds-pipeline",
        target = "_blank",
        shiny::icon("github", "font-awesome"),
        style = "color: inherit; text-decoration: none; font-size: 1.5rem;"
      )
    ),
  )
}