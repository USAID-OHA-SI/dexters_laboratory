# PROJECT:  dexters_laboratory
# PURPOSE:  upload HRH data to PDAP
# AUTHOR:   A.Chafetz | USAID
# REF ID:   3f4db0af
# LICENSE:  MIT
# DATE:     2024-07-02
# UPDATED:

# DEPENDENCIES ------------------------------------------------------------

library(tidyverse)
library(gagglr)
library(grabr)
library(askpass)
library(arrow)

# GLOBAL VARIABLES --------------------------------------------------------

  path_hrh <- si_path() %>% return_latest("HRH")

  temp_folder()

# IMPORT ------------------------------------------------------------------

  df_hrh <- read_psd(path_hrh)

# EXPORT ------------------------------------------------------------------

  path_out <- file.path(folderpath_tmp,
                        path_hrh %>% basename() %>%
                          str_replace("zip", "parquet"))

  write_parquet(df_hrh, path_out)

# VIZ ---------------------------------------------------------------------

  #test uploading to USAID folder from local machine
  s3_upload(path_out,
            bucket = pdap_bucket("write"),
            prefix = "usaid/",
            access_key = pdap_access(),
            secret_key = pdap_secret())
