# BOOST-EDS ASLI Application
  <!-- badges: start -->
  [![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
  <!-- badges: end -->
A minimal Shiny application to demonstrate EDS services, using the [Amundsen Sea Low Index](https://github.com/scotthosking/amundsen-sea-low-index) as a case study.

This application reads in data from the JASMIN Object Store, generated from the [ASLI BOOST-EDS pipeline](https://github.com/antarctica/boost-eds-pipeline), which is deployed on JASMIN. 

This application is [deployed on Datalabs](https://ditbas-asliapp.datalabs.ceh.ac.uk/), but has been written to allow deployment elsewhere.

## Development
If you want to run the app locally, clone this repository:

```bash
git clone git@github.com:antarctica/asliapp.git
```

## Reproducible Environment
This packages uses `renv`, which should automatically bootstrap itself on installation. This app also uses Python packages. Once `renv` is activated, run:

```r
renv::use_python()

renv::restore()
```
For more see [collaborating with renv](https://rstudio.github.io/renv/articles/collaborating.html#:~:text=We%20recommend%20using%20a%20version,via%20renv%3A%3Ainit()%20.) for more.

## Running the application
To run the application:
```r
# devtools::load_all()

runApp()
```

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

This application displays ASL data calculated using Hosking & Wilby, based on methods in Hosking et al. 2016. The ASL calculations are use data from Hersbach, H. et al., (2018) downloaded from the Copernicus Climate Change Service (2023). This applications is continually updated, hence these are cited without an access date.

## Citations

Copernicus Climate Change Service (2023): ERA5 hourly data on single levels from 1940 to present. Copernicus Climate Change Service (C3S) Climate Data Store (CDS), DOI: 10.24381/cds.adbb2d47.

Hersbach, H., Bell, B., Berrisford, P., Biavati, G., Horányi, A., Muñoz Sabater, J., Nicolas, J., Peubey, C., Radu, R., Rozum, I., Schepers, D., Simmons, A., Soci, C., Dee, D., Thépaut, J-N. (2018): ERA5 hourly data on single levels from 1940 to present. Copernicus Climate Change Service (C3S) Climate Data Store (CDS), DOI: 10.24381/cds.adbb2d47.

Hosking, J. S., A. Orr, T. J. Bracegirdle, and J. Turner (2016), Future circulation changes off West Antarctica: Sensitivity of the Amundsen Sea Low to projected anthropogenic forcing, Geophys. Res. Lett., 43, 367–376, doi:10.1002/2015GL067143.

Hosking, J. S., & Wilby, D. asli [Computer software]. https://github.com/scotthosking/amundsen-sea-low-index

Lawrence, B. N. , Bennett, V. L., Churchill, J., Juckes, M., Kershaw, P., Pascoe, S., Pepler, S., Pritchard, M. and Stephens, A. (2013) Storing and manipulating environmental big data with JASMIN. In: IEEE Big Data, October 6-9, 2013, San Francisco.
