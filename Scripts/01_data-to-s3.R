# PROJECT:  dexters_laboratory
# AUTHOR:   A.Chafetz | USAID
# PURPOSE:  test pushing data from local GFE to Workbench environment
# REF ID:   2f7e286c
# LICENSE:  MIT
# DATE:     2023-11-07
# UPDATED:


# DEPENDENCIES ------------------------------------------------------------

  library(glamr)
  library(grabr)
  library(askpass)

# GLOBAL VARIABLES --------------------------------------------------------

  #GHSD PRIME Systems team shared the preview MER datasets before the Q4 release
  #https://pepfar.sharepoint.com/sites/ICPI/Products/Forms/AllItems.aspx?csf=1&web=1&e=OuD912&cid=132dce2e%2D5d03%2D417b%2D8ebe%2D0af30677f313&RootFolder=%2Fsites%2FICPI%2FProducts%2FICPI%20Data%20Store%2FMER%2FTesting%2FPreview%20MSDs&FolderCTID=0x012000FA26EFB8C6A67F4EBB109E2CE94C9F2E000FDF5A992548BB4FBF585F9D1BCF1A2E
  path <- file.path(si_path("path_downloads"),
                    "test_MER_Structured_Datasets_PSNU_IM_FY21-24_20231023_Mozambique.zip")

  #check that file exists
  file.exists(path)

# UPLOAD ------------------------------------------------------------------

  #Get secrets from Workbench Environment
  # Sys.getenv("S3_WRITE")
  # Sys.getenv("AWS_ACCESS_KEY_ID")
  # Sys.getenv("AWS_SECRET_ACCESS_KEY")

  #test uploading to USAID folder from local machine
  s3_upload(path,
            bucket = askpass("S3 Write Location"),
            prefix = "usaid/",
            access_key = askpass("Access Key"),
            secret_key = askpass("Secret Key"))

