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

#merge in data about whether participant is in the sample with accel data and bmx data
sample_flag <- read_csv("../data/derived/sample.csv")
glimpse(sample_flag)
names(sample_flag)

#check flags ans create a new one called in_sample
sample_flag |> distinct(has_Accel)
sample_flag |> distinct(has_BMI)
sample_flag$in_sample <- 1
sample_flag1 <- sample_flag |>
	select(PID, in_sample) |>
	rename(seqn=PID)

#merge and clean in sample to bmx data and demo data
bmx_demo1 <- bmx_demo |>
	left_join(sample_flag1) |>
	relocate(seqn, in_sample) |>
	mutate(in_sample=coalesce(in_sample,0))
glimpse(bmx_demo1)

#export and save the dataset
write_csv(bmx_demo1, "../data/derived/bmx_demo_data.csv")
