# BOOST-EDS ASLI Application
A minimal Shiny application to demonstrate EDS services, using the [Amundsen Sea Low Index](https://github.com/scotthosking/amundsen-sea-low-index) as a case study.

This application reads in data from the JASMIN Object Store, generated from the [ASLI BOOST-EDS pipeline](https://github.com/antarctica/boost-eds-pipeline), which is deployed on JASMIN. This application is deployed on Datalabs, but has been written to allow deployment elsewhere.

# Installation
This Shiny application is not bundled as a package - this is due to current hosting constraints on Datalabs, only allowing a root-level `app.R`. Therefore it cannot be installed, but a `renv.lock` file is provided to help create a reproducible environment. 

`renv` should automatically bootstrap itself. When this is complete, use `renv::restore()` to set up your environment, see [Collaborating with renv](https://rstudio.github.io/renv/articles/collaborating.html#:~:text=We%20recommend%20using%20a%20version,via%20renv%3A%3Ainit()%20.) for more.

# Configuration
To read in data on the JASMIN object store (or any other object store), you must have valid user credentials. These are associated with your JASMIN account, and will be in the form of 2 string: an Access Key and a Secret Key. There should be kept securely.

It is recommended to keep these in an .Renviron file, you can generate one using `usethis::edit_r_envirion(scope = "user")`. A template `.Renviron` file is provided in this repository.