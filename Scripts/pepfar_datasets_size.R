# PROJECT:  dexters_laboratory
# PURPOSE:
# AUTHOR:   A.Chafetz | USAID
# REF ID:   d6048446
# LICENSE:  MIT
# DATE:     2024-07-24
# UPDATED:

# DEPENDENCIES ------------------------------------------------------------

  #general
  library(tidyverse)
  library(glue)
  library(arrow)
  library(aws.s3)
  library(cli)
  #oha
  library(gagglr) ##install.packages('gagglr', repos = c('https://usaid-oha-si.r-universe.dev', 'https://cloud.r-project.org'))
  library(grabr)

# GLOBAL VARIABLES --------------------------------------------------------

  ref_id <- "d6048446"  #a reference to be places in viz captions

  path_msd <-  si_path() %>% return_latest("OU_IM")


  files <- grabr::s3_objects(pdap_bucket(),
                    access_key = pdap_access(),
                    secret_key = pdap_secret())

  files <- files %>%
    filter(str_detect(key, "parquet"),
           str_detect(key, "Narratives", negate = TRUE)) %>%
    pull(key)


  # f <- files[1]

  count_cells <- function(f){

    cli_alert("{basename(f)}...{format(Sys.time(), '%X')}")

    df <- s3read_using(read_parquet,
                       bucket = pdap_bucket(),
                       object = f)

    df_out <- tibble(file = f,
           rows = nrow(df),
           cols = ncol(df))

    write_csv(df_out,
              "Data/PEPFAR_datasets.csv",
              append = TRUE)
  }


  # df_size <- map(files, count_cells) %>%
  #   list_rbind()


  # tibble(file = NA_character_,
  #        rows = NA_integer_,
  #        cols = NA_integer_) %>%
  #   write_csv("Data/PEPFAR_datasets.csv")

  walk(files[107:115], count_cells)

  read_csv("Data/PEPFAR_datasets.csv") %>% glimpse()
  read_csv("Data/PEPFAR_datasets.csv") %>% View()



# LOCAL -------------------------------------------------------------------

  # load_secrets("email")
  #
  # id <- as_id("1KQACKdo7b-M_Un2Fe1x0ZSJkhkNNPTqa")
  #
  # files <- drive_ls(id, recursive = TRUE)


  df <- read_csv("C:/Users/achafetz/Downloads/PEPFAR_datasets.csv")

  df <- df %>%
    filter(!is.na(file))

  df_tidy <- df %>%
    mutate(file = file %>%
             basename() %>%
             str_remove("\\.parquet"),
           data_stream = str_extract(file, "Financial|MER"),
           geo_level = str_extract(file, "(OU|PSNU|Site)_IM"),
           period_type = str_extract(file, "Historic|Recent"),
           org_unit = str_extract(file, "(?<=(Historic|Recent)_).*$"),
           .before = 1) %>%
    mutate(geo_level = ifelse(is.na(geo_level), "OU_IM", geo_level),
           period_type = ifelse(is.na(period_type), "All", period_type),
           period = case_when(period_type == "Historic" ~ "FY15-21",
                              period_type == "Recent" ~ "FY22-24",
                              period_type == "All" ~ "FY18-24"),
           org_unit = ifelse(is.na(org_unit), "All", org_unit)) %>%
    relocate(period, .before = period_type) %>%
    select(-file)


  write_csv(df_tidy,
            "C:/Users/achafetz/Downloads/PEPFAR_datasets_20240724.csv")
