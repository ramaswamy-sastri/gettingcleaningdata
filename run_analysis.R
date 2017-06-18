# Script implementing the getting and cleaning data project assignment using Human Activity Recognition datasets
# The script does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# to install packages uncomment the lines below.
# install.packages("dplyr")
# install.packages("tidyr")


# load required packages
library(dplyr)
library(tidyr)

# Download and unzip the dataset to a subfolder /UCI HAR Dataset if not already present
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfilename <- "uci_har_dataset.zip"
if(!file.exists(destfilename)) {
        download.file(fileUrl, destfile = destfilename, method = "curl")
        unzip(destfilename)
        message("dataset downloaded and unzipped")
}

message("processing downloaded dataset")

message("loading reference data: activity labels, features...")
datarootfolder <- "./UCI HAR Dataset/"
activitylabels <- paste0(datarootfolder,"activity_labels.txt")
activitylabels.df <- read.table(activitylabels, header = FALSE, colClasses = c("numeric", "factor"))
colnames(activitylabels.df) <- c("activityid", "activitytype")

features <- paste0(datarootfolder,"features.txt")
features.df <- read.table(features, header = FALSE)
colnames(features.df) <- c("id", "feature")

message("loading test set: data, labels, subject")
testfolder <- paste0(datarootfolder,"test/")
test.data.file <- paste0(testfolder, "X_test.txt")
test.labels.file <- paste0(testfolder, "y_test.txt")
test.subject.file <- paste0(testfolder, "subject_test.txt")

test.data.df <- read.table(test.data.file, header = FALSE, colClasses = "numeric")
test.labels.df <- read.table(test.labels.file, header = FALSE, colClasses = "numeric")
test.subject.df <- read.table(test.subject.file, header = FALSE, colClasses = "integer")

message("loading train set: data, labels, subject")
trainfolder <- paste0(datarootfolder,"train/")
train.data.file <- paste0(trainfolder, "X_train.txt")
train.labels.file <- paste0(trainfolder, "y_train.txt")
train.subject.file <- paste0(trainfolder, "subject_train.txt")

train.data.df <- read.table(train.data.file, header = FALSE, colClasses = "numeric")
train.labels.df <- read.table(train.labels.file, header = FALSE, colClasses = "numeric")
train.subject.df <- read.table(train.subject.file, header = FALSE, colClasses = "integer")

message("combining training and test data")
m.data.df <- rbind(test.data.df, train.data.df)
m.labels.df <- rbind(test.labels.df, train.labels.df)
m.subject.df <- rbind(test.subject.df, train.subject.df)

message("adding descriptive column labels")
colnames(m.data.df) <- features.df$feature
colnames(m.labels.df) <- c("activityid")
colnames(m.subject.df) <- c("subjectid")

message("subsetting data for mean and std measurements")
mean.std.columns <- grep('mean|std', names(m.data.df))
m.data.mean.std.df <- m.data.df[, mean.std.columns]

message("merging datasets: subject, labels, data")
m.all <- cbind(m.subject.df, m.labels.df,m.data.mean.std.df)
m.all <- left_join(m.all, activitylabels.df, by = c("activityid" = "activityid"))

message("calculating average of each variable for each activity and each subject")
m.all.mean.df <- 
        m.all %>%
        group_by(activityid, activitytype, subjectid) %>%
        select(activityid, activitytype, subjectid, everything()) %>%
        summarise_each(funs(mean))

message(paste("generating tidy data set, writing rows...", nrow(m.all.mean.df)))
out.file <- "./activity_subject_mean.txt"
write.table(m.all.mean.df, file = out.file, sep=",", row.names = FALSE)

message("Done.")