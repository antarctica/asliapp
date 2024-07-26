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
  
  s3_keys <- s3$list_objects_v2(Sys.getenv("BUCKET"))
  
  # Initialise a list with keys, this will hold all csvs
  key_list <- list()
  
  # Obtain all content keys, but only return .csv to the list
  for(i in seq_len(length(s3_keys$Contents))) {
    obtain_key <- s3_keys$Contents[[i]]$Key
    obtain_key <- obtain_key[grep("*.csv", obtain_key)]  
    if (!identical(obtain_key, character(0))) {
      key_list[[i]] <- obtain_key
    }
  }
  
  csv_list <- lapply(key_list, function(csv_key) {
    s3_bucket <- s3$get_object(
      Bucket = bucket,
      Key = csv_key
    )
    
    asli_columns <- c(
      "time",
      "lon",
      "lat",
      "ActCenPres",
      "SectorPres",
      "RelCEnPres"
    )
    
    single_file_df <- s3_bucket$Body |> 
      rawToChar() |> 
      readr::read_csv(
        skip = 30,
        col_names = asli_columns,
        show_col_types = FALSE
      )
    
    return(single_file_df)
  })
  
  # Bring together files and return unique rows only
  asli_df <- dplyr::bind_rows(csv_list)
  asli_df <- unique(asli_df)
  return(asli_df)
}

