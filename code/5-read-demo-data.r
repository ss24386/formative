###R script to read in demo data and clean dataset

library(haven)
library(dplyr)

#read in data
demo_data <- read_xpt("../data/original/DEMO_D.XPT")

#SELECT COLUMNS
demo_data1 <- demo_data |>
	select(SEQN, RIDAGEYR, RIDRETH1, RIAGENDR) |>
	janitor::clean_names()
glimpse(demo_data1)
