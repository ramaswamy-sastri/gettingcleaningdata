---
title: "CodeBook: Getting and Cleaning Data using HAR dataset"
author: "ramaswamy.sastri"
date: "Sunday, June 18, 2017"
output: "html_document"
---

# README

The solution for the project includes a single script [run_analysis.R](run_analysis.R) that will analyze the [Human Activity Recognition](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) dataset and create a tidy output file [activity_subject_mean.txt](activity_subject_mean.txt) containing the average of each variable for each activity and each subject.

## Script Overview

The script does the following:
0. Downloads the HAR dataset if not already present in the working directory
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. The measurements are identified by using the feature names.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The output file created has 54 obs. of 82 variables. You can easily read the output file into a data frame using read.table(...). The file has a header with columns names. Each column value is comma-separated.

1. Columns 1 (activityid) and 2 (acitivitytype) in the output file represent individual activity and associated label for the measurements. 
2. Column 3 (subjectid) represents the subject for the measurements
3. Columns 4-82 carry the average for the mean and std measurements in the HAR dataset

