#' Get asli dataframe from s3 bucket
#' 
#' @param s3_body S3 Body inherited from object_store()
get_asli_df <- function(s3_body) {
  # Set up column names in advance
  asli_columns <- c(
    "time",
    "lon",
    "lat",
    "ActCenPres",
    "SectorPres",
    "RelCEnPres"
  )

  # Read the df from s3_body
  # Skipping the first 30 lines, these contain metadata
  asli_df <- s3_body |> 
    rawToChar() |> 
    readr::read_csv(
    skip = 30,
    col_names = asli_columns,
    show_col_types = FALSE
  )
}