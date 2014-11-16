Getting-and-Cleaning-Data-Course-Project
========================================

Solution to the Course Project Assignment, contains the run_analysis.R script


Download and unzip the data from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

The unzipped files (4 text files and two folder) should be in the working directory of R.
We will be using melt_ to write the final data so you need to install package Kmisc (http://cran.r-project.org/web/packages/Kmisc/Kmisc.pdf)

The script: 
- reads activity labels & features & transforms column names 
- reads test & training data & transforms column names
- replaces activity code --> activity names
- adds the other columns to the final tranining & testing dataset
- merges the test and training files
- selects only the mean and standard deviation measurements
- uses melt_ to create a table +of activity,subject,measurements...
- uses dcast to compute the mean for each activity and each subject
- creates a independent tidy dataframe
