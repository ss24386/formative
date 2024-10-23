##analyse data from BMX, accel and demo datasets in r

library(readr)
library(dplyr)

#read in data created in previous script
bmx_demo <- read_csv("../data/derived/bmx_demo_data.csv")
head(bmx_demo)

#create a new obese flag
bmx_demo1 <- bmx_demo |>
	mutate(obese= ifelse(bmxbmi>=30, 1, 0)) 

##summarise data
# of people with activity data, by obese flag
bmx_demo1 |>
	group_by(obese) |>
	summarise(
		n=n(),
		has_accel_sum=sum(in_sample),
		has_accel_prop=has_accel_sum/n,
		test=mean(in_sample)
		)

bmx_demo1 |>
	group_by(riagendr) |>
	summarise(
		has_accel=mean(in_sample))

 
bmx_demo1 |>
	filter(ridageyr < 16) |>
	summarise(
		maxht=max(bmxht, na.rm=TRUE))

write_csv(bmx_demo1, "../data/derived/body_measurements.csv")
