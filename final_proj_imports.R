# install.packages("htmlwidgets", type = "binary") Resolved install conflict
# install.packages("DT", type = "binary")

library(knitr) # Pretty Print / format summary tables
library(covr)# Code coverage

library(plotly)# Interactive plots with hover etc.
library(readr)# Import file
library(rio)# Import/Export file in many formats
library(tools) # Remove file extensions from data frame names

library(conflicted)# Resolve dplyr / tidyverse package conflicts
library(tidyverse)

conflict_prefer("filter", "dplyr")
conflict_prefer("lag", "dplyr")