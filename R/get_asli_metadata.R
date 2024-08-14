#' Get asli metadata from s3 bucket
#' 
#' @param s3 S3 Body inherited from object_store()
get_asli_metadata <- function(s3) {
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
      Bucket = Sys.getenv("BUCKET"),
      Key = csv_key
    )
    
    single_file_df <- s3_bucket$Body |> 
      rawToChar() |> 
      readr::read_delim(
        delim = "# ",
        n_max = 22,
        show_col_types = FALSE
      )
    
    return(single_file_df)
  })
  
  # Bring together files and return unique rows only
  asli_df <- dplyr::bind_rows(csv_list)
  asli_df <- unique(asli_df$`...2`)
  return(asli_df)
}