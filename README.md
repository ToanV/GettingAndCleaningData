#Getting and Cleaning Data Course Project
###June 22, 2015

##Instructions for project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
You should create one R script called run_analysis.R that does the following.
1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement.
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names.
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


##Get the data
1.Download the file and put the file in the data folder
2.Unzip the file
See the README.txt file for the detailed information on the dataset. For the purposes of this project, the files in the Inertial Signals folders are not used. The files that will be used to load data are listed as follows:
•	test/subject_test.txt
•	test/X_test.txt
•	test/y_test.txt
•	train/subject_train.txt
•	train/X_train.txt
•	train/y_train.txt

Read data from the targeted files

Read data from the files into the variables

Read the training data set
training_Features <-  read.table(file.path("./UCI HAR Dataset/", "train", "X_train.txt"), header=FALSE)
training_Subject <-  read.table(file.path("./UCI HAR Dataset/", "train", "subject_train.txt"), header=FALSE)
training_Activity <- read.table(file.path("./UCI HAR Dataset/", "train", "y_train.txt"), header=FALSE)

Read the test data set
test_Features <- read.table(file.path("./UCI HAR Dataset/", "test", "X_test.txt"), header=FALSE)
test_Subject <- read.table(file.path("./UCI HAR Dataset/", "test", "subject_test.txt"), header=FALSE)
test_Activity <- read.table(file.path("./UCI HAR Dataset/", "test", "y_test.txt"), header=FALSE)
Look at the properties of the above varibles
str(test_Activity)
 'data.frame':    2947 obs. of  1 variable:
 $ V1: int  5 5 5 5 5 5 5 5 5 5 ...
str(training_Activity)
 'data.frame':    7352 obs. of  1 variable:
  $ V1: int  5 5 5 5 5 5 5 5 5 5 ...
str(training_Subject)
 'data.frame':    7352 obs. of  1 variable:
  $ V1: int  1 1 1 1 1 1 1 1 1 1 ...
str(test_Subject)
 'data.frame':    2947 obs. of  1 variable:
  $ V1: int  2 2 2 2 2 2 2 2 2 2 ...
str(test_Features)
 'data.frame':    2947 obs. of  561 variables:

##Merges the training and the test sets to create one data set

1.Concatenate the data tables by rows
data_Features = rbind(training_Features, test_Features)
data_Subject = rbind(training_Subject, test_Subject)
data_Activity = rbind(training_Activity, test_Activity)

2.set names to variables
header_Features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)
names(data_Features) <- header_Features$V2
names(data_Subject) <- c("subject")
names(data_Activity) <- c("activity")

3.Merge columns to get the data frame Data for all data
data_All <- cbind(cbind(data_Features, data_Subject), data_Activity)

##Extracts only the measurements on the mean and standard deviation for each measurement

data_mean_std <-data_All[, grep("mean\\(\\)|std\\(\\)|subject|activity", names(data_All))]

##Uses descriptive activity names to name the activities in the data set

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)
data_mean_std[, 68] <- activity_labels[data_mean_std[, 68], 2]

> head(data_mean_std$activity)
[1] STANDING STANDING STANDING STANDING STANDING STANDING
Levels: LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS

##Appropriately labels the data set with descriptive variable names

Decided to leave it as they were.
> names(data_mean_std)
 [1] "tBodyAcc-mean-X"           "tBodyAcc-mean-Y"           "tBodyAcc-mean-Z"          
 [4] "tBodyAcc-std-X"            "tBodyAcc-std-Y"            "tBodyAcc-std-Z"           
 [7] "tGravityAcc-mean-X"        "tGravityAcc-mean-Y"        "tGravityAcc-mean-Z"       
[10] "tGravityAcc-std-X"         "tGravityAcc-std-Y"         "tGravityAcc-std-Z"        
[13] "tBodyAccJerk-mean-X"       "tBodyAccJerk-mean-Y"       "tBodyAccJerk-mean-Z"      
[16] "tBodyAccJerk-std-X"        "tBodyAccJerk-std-Y"        "tBodyAccJerk-std-Z"       
[19] "tBodyGyro-mean-X"          "tBodyGyro-mean-Y"          "tBodyGyro-mean-Z"         
[22] "tBodyGyro-std-X"           "tBodyGyro-std-Y"           "tBodyGyro-std-Z"          
[25] "tBodyGyroJerk-mean-X"      "tBodyGyroJerk-mean-Y"      "tBodyGyroJerk-mean-Z"     
[28] "tBodyGyroJerk-std-X"       "tBodyGyroJerk-std-Y"       "tBodyGyroJerk-std-Z"      
[31] "tBodyAccMag-mean"          "tBodyAccMag-std"           "tGravityAccMag-mean"      
[34] "tGravityAccMag-std"        "tBodyAccJerkMag-mean"      "tBodyAccJerkMag-std"      
[37] "tBodyGyroMag-mean"         "tBodyGyroMag-std"          "tBodyGyroJerkMag-mean"    
[40] "tBodyGyroJerkMag-std"      "fBodyAcc-mean-X"           "fBodyAcc-mean-Y"          
[43] "fBodyAcc-mean-Z"           "fBodyAcc-std-X"            "fBodyAcc-std-Y"           
[46] "fBodyAcc-std-Z"            "fBodyAccJerk-mean-X"       "fBodyAccJerk-mean-Y"      
[49] "fBodyAccJerk-mean-Z"       "fBodyAccJerk-std-X"        "fBodyAccJerk-std-Y"       
[52] "fBodyAccJerk-std-Z"        "fBodyGyro-mean-X"          "fBodyGyro-mean-Y"         
[55] "fBodyGyro-mean-Z"          "fBodyGyro-std-X"           "fBodyGyro-std-Y"          
[58] "fBodyGyro-std-Z"           "fBodyAccMag-mean"          "fBodyAccMag-std"          
[61] "fBodyBodyAccJerkMag-mean"  "fBodyBodyAccJerkMag-std"   "fBodyBodyGyroMag-mean"    
[64] "fBodyBodyGyroMag-std"      "fBodyBodyGyroJerkMag-mean" "fBodyBodyGyroJerkMag-std" 
[67] "subject"                   "activity"  

##Creates a second,independent tidy data set and ouput it

data_Averages <- aggregate(data_mean_std[,1:66], by=list(data_mean_std$subject, data_mean_std$activity) , mean)
names(data_Averages[1]) <- "subject"
names(data_Averages[2]) <- "activity"

write the output to averages.txt
write.table(data_Averages, "averages_data.txt", row.name=FALSE)

