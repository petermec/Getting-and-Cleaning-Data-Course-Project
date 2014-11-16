# run_analysis.R for Getting and Cleaning Data Course Project

# the unzipped files (4 text files and two folder) downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# should be in the working directory of R, to determine root folder uncomment next line
# getwd()
# to set  working directory of R, uncomment and modify next line
# setwd("C:\\Users\\XXX\\data") #Windows
# setwd("/Users/XXX/data/") #Linux

# We will be using melt_ to write the final data so you need to install package Kmisc (http://cran.r-project.org/web/packages/Kmisc/Kmisc.pdf)

library(Kmisc)
library(reshape2)
library(Hmisc)

# read activity labels & features & transform column names

activityLabls = read.table("activity_labels.txt",sep=" ",header=FALSE)
featurs = read.table("features.txt",header=FALSE)

actL<-gsub("_","",activityLabls[,2])
featureLs<-gsub("\\(|\\)|\\-","",featurs[,2])

actL<-tolower(actL)
featureLs<-tolower(featureLs)

# read test & training data & transform column names

xTestDF= read.table("test/X_test.txt",col.names=featureLs)
yTestDF= read.table("test/y_test.txt",col.names="activityid")
zTestDF= read.table("test/subject_test.txt",col.names="subject")

xTrainDF= read.table("train/X_train.txt",col.names=featureLs)
yTrainDF= read.table("train/y_train.txt",col.names="activityid")
zTrainDF= read.table("train/subject_train.txt",col.names="subject")

# replace activity code --> activity names
# add the other columns to the final tranining & testing dataset

activityFinal<-actL[yTrainDF[,1]]
trainingFinalDF<-cbind(zTrainDF,activityFinal,xTrainDF)
activityFinal<-actL[yTestDF[,1]]
testFinalDF<-cbind(zTestDF,activityFinal,xTestDF)

# STEP 1 of ASSIGNMENT - Merges the training and the test sets to create one data set

totalFinalDF<-rbind(testFinalDF,trainingFinalDF)

# STEP 2 TO 4 of ASSIGNMENT - Extracts only the measurements on the mean and standard deviation for each measurement, Uses descriptive activity names to name the activities in the data set, Appropriately labels the data set with descriptive variable names. 

# select only column names containing mean, Mean & std

selectieDF<-grepl("Mean|std|mean",featureLs)

# add subject & activity columns

selectieDF<-c(TRUE,TRUE,selectieDF)
selectieTempDF<-totalFinalDF[,selectieDF]
selectieFinalDF<-melt_(selectieTempDF,id=c("subject","activityFinal"))

# STEP 5 of ASSIGNMENT - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

AverageDF<-dcast(selectieFinalDF,subject+activityFinal ~variable, fun.aggregate=mean, na.rm=TRUE)
write.table(AverageDF,"AverageDF.txt", row.name=FALSE)

# 3th part of ASSIGNMENT, codebook: 
print(str(AverageDF))
