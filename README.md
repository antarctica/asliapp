# BOOST-EDS ASLI Application
A minimal Shiny application to demonstrate EDS services, using the [Amundsen Sea Low Index](https://github.com/scotthosking/amundsen-sea-low-index) as a case study.

This application reads in data from the JASMIN Object Store, generated from the [ASLI BOOST-EDS pipeline](https://github.com/antarctica/boost-eds-pipeline), which is deployed on JASMIN. This application is deployed on Datalabs, but has been written to allow deployment elsewhere.

## Installation
This Shiny application is not bundled as a package - this is due to current hosting constraints on Datalabs, only allowing a root-level `app.R`. Therefore it cannot be installed, but a `renv.lock` file is provided to help create a reproducible environment. 

`renv` should automatically bootstrap itself. When this is complete, use `renv::restore()` to set up your environment, see [Collaborating with renv](https://rstudio.github.io/renv/articles/collaborating.html#:~:text=We%20recommend%20using%20a%20version,via%20renv%3A%3Ainit()%20.) for more.

## Configuration
To read in data on the JASMIN object store (or any other object store), you must have valid user credentials. These are associated with your JASMIN account, and will be in the form of 2 string: an Access Key and a Secret Key. There should be kept securely.

It is recommended to keep these in an .Renviron file, you can generate one using `usethis::edit_r_environ(scope = "project")`. A template `.Renviron` file is provided in this repository.

## Hosting on Datalabs
To host this application on Datalabs, you can clone this repository to a notebook:
1. In your Project, create a new RStudio notebook, this notebook will be your "backend", so note down `<your-notebook-name>` which you provided under 'URL Name'.
2. Once your notebook is set up, open it and create a New R Project > Version Control. Check out this repository using HTTPS, and enter your credentials. Note down `<your-project-name`>.
3. Run `renv::restore()` as per the instructions under Installation.
4. Create an `.Renviron` file and populate it using the same structure as the `example.app.env` template, as per the instructions under Configuration. Note that `scope = "project"` ensures it appears in the right directory.
5. (Optional) if you want to test run the app in the notebook, run `readRenviron(".Renviron")` before you 'Run App' or in the console `runApp('~/<your-project-name>')`.
6. Exit your notebook, return to your Datalabs Projects page and under Sites, Create Site.
7. Create an RShiny site, ensuring your 'Source Path' is defined as `notebooks/rstudio-<your-notebook-name>/<your-project-name>`.