# devtools::install_github("DBOSlab/barRoso")
# install.packages("rgbif")

library(devtools)
library(readxl)
library(rgbif)
library(barRoso)
library(dplyr)
library(writexl)


gbifOchnaceaeES <- occ_download(pred_in("taxonKey", "6642"), # taxonKey for "Ochnaceae" in GBIF
                                pred_in("stateProvince", "Espírito Santo"),
                                pred_in("continent", c("south_america", "north_america"))) # neotropical specimens

gbifOchnaceaeES <- gbifOchnaceaeES %>%
  occ_download_get() %>%
  occ_download_import()

gbifOchnaceaeES <- gbifOchnaceaeES[gbifOchnaceaeES$basisOfRecord == "PRESERVED_SPECIMEN", ]

standardized_df <- barroso_std(gbifOchnaceaeES)

standardized_df <- standardized_df %>%
  select_if(function(x) !all(is.na(x))) 

write_xlsx(standardized_df, "OchnaceaeES.xlsx")

