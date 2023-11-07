# PROJECT:  dexters_laboratory
# AUTHOR:   A.Chafetz | USAID
# PURPOSE:  test reading in data from s3 bucket
# REF ID:   e673a62b
# LICENSE:  MIT
# DATE:     2023-11-07
# UPDATED:

# DEPENDENCIES ------------------------------------------------------------

  library(tidyverse)
  library(gagglr)
  library(grabr)
  library(aws.s3)

# GLOBAL VARIABLES --------------------------------------------------------

  ref_id <- "e673a62b" #id for adorning to plots, making it easier to find on GH

  my_bucket <- Sys.getenv("S3_WRITE")
  my_prefix <- "usaid/"

# IMPORT ------------------------------------------------------------------

  #identify path to dataset uploaded in 01_data-to-s3.R
  path_wrkbnch <- s3_objects(bucket = my_bucket,
                             prefix = "usaid/",
                             access_key = Sys.getenv("AWS_ACCESS_KEY_ID"),
                             secret_key = Sys.getenv("AWS_SECRET_ACCESS_KEY")) %>%
    filter(str_detect(key, "Moz")) %>%
    pull(key)

  #review path
  path_wrkbnch

  #read
  df_msd <- s3read_using(read_psd,
                         bucket = my_bucket,
                         object = path_wrkbnch)

  #view df
  glimpse(df_msd)
