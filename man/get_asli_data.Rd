% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_asli_data.R
\name{get_asli_data}
\alias{get_asli_data}
\title{Get asli dataframe from s3 bucket}
\usage{
get_asli_data(s3, data_requested = "dataframe")
}
\arguments{
\item{s3}{S3 Body inherited from object_store()}

\item{data_requested}{whether you are requesting raw data, or just metadata. Must be one of "dataframe" or "metadata".}
}
\description{
Get asli dataframe from s3 bucket
}
