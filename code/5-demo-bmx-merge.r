###R script to read in demo data and clean dataset

library(haven)
library(dplyr)
library(readr)

#read in demo data
demo_data <- read_xpt("../data/original/DEMO_D.XPT")

#SELECT COLUMNS
demo_data1 <- demo_data |>
	select(SEQN, RIDAGEYR, RIDRETH1, RIAGENDR) |>
	janitor::clean_names()
glimpse(demo_data1)
#str(demo_data)

#read in bmx data and clean ver names
bmx_data <- read_csv("../data/original/BMX_D.csv") |>
	janitor::clean_names()

glimpse(bmx_data)
#str(bmx_data)


#merge datasets
bmx_demo <- bmx_data |>
	left_join(demo_data1) |>
	relocate(seqn, ridageyr, ridreth1, riagendr)
glimpse(bmx_demo)
head(bmx_demo)

