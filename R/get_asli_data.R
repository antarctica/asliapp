#' Get asli dataframe from s3 bucket
#' 
#' @param s3 S3 Body inherited from object_store()
#' @param data_requested whether you are requesting raw data, or just metadata. Must be one of "dataframe" or "metadata".
get_asli_data <- function(
    s3,
    data_requested = "dataframe"
) {
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
    
    asli_columns <- c(
      "time",
      "lon",
      "lat",
      "ActCenPres",
      "SectorPres",
      "RelCEnPres",
      "DataSource"
    )
    
    # Setting parameters for read_csv, depending on which type of data is 
    # Requested in data_requested
    if (data_requested %in% c("metadata")) {
      line_skip <- 0
      line_max <- 22
      asli_columns <- TRUE
    } else if (data_requested %in% c("dataframe")) {
      line_skip <- 30
      line_max <- Inf
      
      asli_columns <- c(
        "time",
        "lon",
        "lat",
        "ActCenPres",
        "SectorPres",
        "RelCEnPres",
        "DataSource"
      )
    } else {
      stop(
        paste(
          data_requested, "must be one of 'metadata' or 'dataframe'"
        )
      )
    }
    
    single_file_df <- s3_bucket$Body |> 
      rawToChar() |> 
      readr::read_csv(
        skip = line_skip,
        n_max = line_max,
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