#' Get asli output from S3 Bucket
#' 
#' @param access_key_id S3 access id
#' @param secret_access_key S3 secret access key
#' @param endpoint S3 host endpoint
#' @param bucket S3 bucket name
#' @param key filename to target in bucket
get_asli_from_s3 <- function(
    access_key_id,
    secret_access_key,
    endpoint,
    bucket,
    key
) {
  s3 <- paws::s3(
    credentials = list(
      creds = list(
        access_key_id = access_key_id,
        secret_access_key = secret_access_key    
      )
    ),
    endpoint = endpoint
  )
  
  s3_bucket <- s3$get_object(
    Bucket = bucket,
    Key = key
  )
  
  asli_columns <- c(
    "time",
    "lon",
    "lat",
    "ActCenPres",
    "SectorPres",
    "RelCEnPres"
  )
  
  asli_df <- s3_bucket$Body |> 
    rawToChar() |> 
    readr::read_csv(
      skip = 30,
      col_names = asli_columns
      )
}
