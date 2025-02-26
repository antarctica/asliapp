#' Get asli plot
#' 
#' Fetch the asli plot png from the s3 bucket for the corresponding year
#' 
#' @param s3 S3 Body inherited from object_store()
#' @param year the year for which to fetch the image
#'
get_asli_plot <- function(
    s3,
    year
) {
  s3_bucket <- s3$get_object(
    Bucket = Sys.getenv("BUCKET"),
    Key = paste0(
      "asli_plot_",
      year,
      ".png"
    )
  )
  
  asli_img <- s3_bucket$Body |>
    magick::image_read()
  
  return(asli_img)
}