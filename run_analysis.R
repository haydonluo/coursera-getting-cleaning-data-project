## load useful library(ies)
library(reshape2)
library(data.table)

## download the dataset and unzip it
filename <- "dataset.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists(filename)){
      download.file(fileURL, filename)
}
if (!file.exists("UCI HAR Dataset")) { 
      unzip(filename)
}

## load the data
subject_test = read.table("UCI HAR Dataset/test/subject_test.txt")
X_test = read.table("UCI HAR Dataset/test/X_test.txt")
Y_test = read.table("UCI HAR Dataset/test/Y_test.txt")
subject_train = read.table("UCI HAR Dataset/train/subject_train.txt")
X_train = read.table("UCI HAR Dataset/train/X_train.txt")
Y_train = read.table("UCI HAR Dataset/train/Y_train.txt")

## load lookup information
features <- read.table("UCI HAR Dataset/features.txt", col.names=c("featureId", "featureLabel"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("activityId", "activityLabel"))
activities$activityLabel <- gsub("_", "", as.character(activities$activityLabel))
includedFeatures <- grep("-mean\\(\\)|-std\\(\\)", features$featureLabel)

## merge train and test data
subject <- rbind(subject_test, subject_train)
names(subject) <- "subjectId"
X <- rbind(X_test, X_train)
X <- X[, includedFeatures]
names(X) <- gsub("\\(|\\)", "", features$featureLabel[includedFeatures])
Y <- rbind(Y_test, Y_train)
names(Y) = "activityId"
activity <- merge(Y, activities, by="activityId")$activityLabel

## further merge data frames to form one table
data <- cbind(subject, X, activity)
write.table(data, "merged_tidy_data.txt")

## create a dataset grouped by subject and activity according to calculations
data1 <- data.table(data)
data2 <- data1[, lapply(.SD, mean), by=c("subjectId", "activity")]
write.table(data2, "calculated_tidy_data.txt", row.name=FALSE)