#' Get asli output from S3 Bucket
#' 
#' @param access_key_id S3 access id
#' @param secret_access_key S3 secret access key
#' @param endpoint S3 host endpoint
#' @param bucket S3 bucket name
get_s3_body <- function(
    access_key_id,
    secret_access_key,
    endpoint,
    bucket
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
  

  return(s3)
}

