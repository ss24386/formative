print("Read in accel Id data")
accel_IDs <- read.csv('../data/derived/accel_PIDs.csv')
accel_IDs$has_Accel <- 1
head(accel_IDs)

print("Read in BMX data")
BMXdata <- read.csv('../data/original/BMX_D.csv')
head(BMXdata)
##has BMI data?

BMI_data <- BMXdata[,c("SEQN","BMXBMI")]
head(BMI_data)
summary(BMI_data)

##join datasets
print("Merge datasets together")
data_comb <- merge(x=accel_IDs, y=BMI_data, by.x="PID", by.y="SEQN", all=TRUE)
data_comb$has_BMI <- ifelse (!is.na(data_comb$BMXBMI), 1, 0)
data_comb$has_Accel <- ifelse (!is.na(data_comb$has_Accel), 1, 0)
head(data_comb)
summary(data_comb)

print("Rows in each dataset, accel, BMI, comb")
nrow(accel_IDs)
nrow(BMI_data)
nrow(data_comb)

print("summary of freq with and without required data")
table(data_comb$has_Accel, data_comb$has_BMI)

outdata <- data_comb[data_comb$has_Accel==1 & data_comb$has_BMI==1,]
paste("dimensions of dataset outputted into csv")
dim(outdata)

write.csv(outdata, "../data/derived/sample.csv")

