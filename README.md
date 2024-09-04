# BOOST-EDS ASLI Application
  <!-- badges: start -->
  [![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
  <!-- badges: end -->
A minimal Shiny application to demonstrate EDS services, using the [Amundsen Sea Low Index](https://github.com/scotthosking/amundsen-sea-low-index) as a case study.

This application reads in data from the JASMIN Object Store, generated from the [ASLI BOOST-EDS pipeline](https://github.com/antarctica/boost-eds-pipeline), which is deployed on JASMIN. 

This application is [deployed on Datalabs](https://ditbas-asliapp.datalabs.ceh.ac.uk/), but has been written to allow deployment elsewhere.

## Installation
You can install the development version of `asliapp`:

```
remotes::install("antarctica/asliapp")
```

If you want to run the app locally:

```
devtools::load_all()

run_app()
```

## Reproducible Environment
This packages uses `renv`, which should automatically bootstrap itself on installation. When this is complete, use `renv::restore()` to set up your environment, see [collaborating with renv](https://rstudio.github.io/renv/articles/collaborating.html#:~:text=We%20recommend%20using%20a%20version,via%20renv%3A%3Ainit()%20.) for more.

## Configuration
To read in data on the JASMIN object store (or any other object store), you must have valid user credentials. These are associated with your JASMIN account, and will be in the form of 2 string: an Access Key and a Secret Key. These should be kept securely.

It is recommended to keep these in an `.Renviron` file, which you can generate one using `usethis::edit_r_environ(scope = "project")`. A template `.Renviron` file (`example.app.env`) is provided in this repository.

## Hosting on Datalabs
To host this application on Datalabs, you can clone this repository to a notebook:
1. In your Datalabs Project, create a new RStudio notebook. This notebook will be your "backend", so note down `<your-notebook-name>` which you provide under 'URL Name'. **Set access to Private!**
2. Once your notebook is set up, open it and create a New R Project > Version Control. Check out this repository using HTTPS, and enter your credentials. Note down `<your-project-name`>.
3. Run `renv::restore()` as per the instructions under Installation.
4. Create an `.Renviron` file and populate it using the same structure as the `example.app.env` template, as per the instructions under Configuration. Note that `scope = "project"` ensures it appears in the right directory.
5. (Optional) if you want to test run the app in the notebook, run `readRenviron(".Renviron")` before you 'Run App' or in the console `runApp('~/<your-project-name>')`.
6. Exit your notebook, return to your Datalabs Projects page and under Sites, Create Site.
7. Create an RShiny site, ensuring your 'Source Path' is defined as `notebooks/rstudio-<your-notebook-name>/<your-project-name>`. It should now be hosted on `https://ditbas-<yourprojectname>.datalabs.ceh.ac.uk/`.

## Acknowledgement
This work used JASMIN, the UK’s collaborative data analysis environment (https://www.jasmin.ac.uk).

Lawrence, B. N. , Bennett, V. L., Churchill, J., Juckes, M., Kershaw, P., Pascoe, S., Pepler, S., Pritchard, M. and Stephens, A. (2013) Storing and manipulating environmental big data with JASMIN. In: IEEE Big Data, October 6-9, 2013, San Francisco.
