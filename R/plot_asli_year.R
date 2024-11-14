#' Plot asli year
#' 
#' R function wrapper for the asli Python package ASLICalculator functionality
#' See the asli Python package for full documentation
#' 
#' @param data_dir Path to data directory
#' @param mask_filename String containing pattern pointing to zarr-lsm files
#' @param msl_pattern String containing pattern pointing to zarr-msl files
#' @param file_name File name to import
#' @param year year to plot
plot_asli_year <- function(
  data_dir = "s3://asli",
  mask_filename = "zarr-lsm",
  msl_pattern = "zarr-msl",
  file_name = "asli_calculation_2024.csv",
  year = 2024
) {
  # Import python packages and assign them to R objects
  asli <- reticulate::import("asli")
  pathlib <- reticulate::import("pathlib")
  plt <- reticulate::import("matplotlib.pyplot")

  
  # Remember to create .s3cfg file
  a <- asli$ASLICalculator(
    data_dir = data_dir,
    mask_filename = mask_filename,
    msl_pattern = msl_pattern
  )
  
  a$read_mask_data()
  a$read_msl_data()
  a$import_from_csv(file_name)

  asli$asli$plot_lows(a$masked_msl_data, a$asl_df)

  plt$show()
}