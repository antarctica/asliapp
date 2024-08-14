#' Get asli metadata from s3 bucket
#' 
#' @param s3_body S3 Body inherited from object_store()
get_asli_metadata <- function(s3_body) {
  # Read the metadata in the asli data from s3_body
  # Only reading the first 22 lines, these contain metadata
  metadata <- readr::read_delim(
    s3_body,
    delim = "# ",
    n_max = 22
  )
}