# PROJECT:  dexters_laboratory
# AUTHOR:   A.Chafetz | USAID
# PURPOSE:  setup Workbench instance
# REF ID:   efa9c9cd
# LICENSE:  MIT
# DATE:     2023-11-07
# UPDATED:

#tidyverse packages (all)
install.packages("tidyverse")

#other packages
install.packages("remotes")
install.packages("scales")
install.packages("patchwork")
remotes::install_github("MilesMcBain/datapasta")
remotes::install_github("fkeck/quickview")

#USAID-OHA-SI packages
remotes::install_github("USAID-OHA-SI/glitr")
remotes::install_github("USAID-OHA-SI/glamr")
remotes::install_github("USAID-OHA-SI/gisr")
remotes::install_github("USAID-OHA-SI/gagglr")
remotes::install_github("USAID-OHA-SI/grabr")
remotes::install_github("USAID-OHA-SI/gophr")
remotes::install_github("USAID-OHA-SI/tameDP")
