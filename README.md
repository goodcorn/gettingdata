Getting and Cleaning Data Course Project
===========
## This repo is for the course project of Getting and Cleaning Data.
This README.md in the repo describes how the script works. The key R script is called run_analysis.R.

## The source of the project data
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Before running the run_analysis.R scripts, please download and then unzip the project data folder
Then set the project data folder as the working directory 
setwd("C:/Users/goodcorn/Desktop/For Coursera/Course#3_Getting and Cleaning Data/Course Project/rawdata")

## The script run_analysis.R is created to conduct the following main steps.
See comments on run_analysis.R for each code line's explanation. Please see the CodeBook.md for variable explanations.

Step 1. Merge the training and the test sets to create one data set.

Step 2. Extract only the measurements on the mean and standard deviation for each measurement. 

Step 3. Use descriptive activity names to name the activities in the data set.

Step 4. Appropriately label the data set with descriptive variable names. 

Step 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

==============
