---
title: "Project: Getting and Cleaning Data using HAR dataset"
author: "ramaswamy.sastri"
date: "Sunday, June 18, 2017"
output: "html_document"
---

# README

The solution for the project includes a single script [run_analysis.R] (run_analysis.R) that will analyze the [Human Activity Recognition] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) dataset and create a tidy output file [activity_subject_mean.txt] (activity_subject_mean.txt) containing the average of each variable for each activity and each subject.

See [CodeBook.md] (CodeBook.md) for the output description and steps involved in creating the output.

## Running the project

0. Prerequisite: If you have not already installed the tidyr and dplyr packages uncomment the lines at the top of the script to install these packages.

1. Download [run_analysis.R] (run_analysis.R) to your working directory. The script will download files and execute instructions relative to your working directory. You can execute the script from the console or RStudio

2. Execute the script as follows:

```{r}
source("run_analysis.R")
```

3. The script will download the HAR dataset to uci_har_dataset.zip in your working directory.

4. All the data files should get extracted to a /UCI HAR Dataset subfolder under your working directory. Under /UCI HAR Dataset folder you should see several files and folders representing the HAR dataset. See README.txt under /UCI HAR Dataset for details.

5. The script will print progress messages indicating specific processing steps to the console. In a few minutes you should see the output file activity_subject_mean.txt created in your working directory.


