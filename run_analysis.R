## Set the working directory for the project and check all the data files

setwd("C://Coursera/Getting and Cleaning Data/")
list.files("./UCI HAR Dataset/")

###################################################################
## PART 1 - Merge the training and test sets to create one data set
###################################################################

## Read the training data set
training_Features <-  read.table(file.path("./UCI HAR Dataset/", "train", "X_train.txt"), header=FALSE)
training_Subject <-  read.table(file.path("./UCI HAR Dataset/", "train", "subject_train.txt"), header=FALSE)
training_Activity <- read.table(file.path("./UCI HAR Dataset/", "train", "y_train.txt"), header=FALSE)

## Read the test data set
test_Features <- read.table(file.path("./UCI HAR Dataset/", "test", "X_test.txt"), header=FALSE)
test_Subject <- read.table(file.path("./UCI HAR Dataset/", "test", "subject_test.txt"), header=FALSE)
test_Activity <- read.table(file.path("./UCI HAR Dataset/", "test", "y_test.txt"), header=FALSE)

## Merge training and test sets into one data set with headers
data_Features = rbind(training_Features, test_Features)
data_Subject = rbind(training_Subject, test_Subject)
data_Activity = rbind(training_Activity, test_Activity)

header_Features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)
names(data_Features) <- header_Features$V2
names(data_Subject) <- c("subject")
names(data_Activity) <- c("activity")

data_All <- cbind(cbind(data_Features, data_Subject), data_Activity)

###################################################################
## PART 2 - Extract only measurements on the mean and standard
##          deviation for each measurements
###################################################################

data_mean_std <-data_All[, grep("mean\\(\\)|std\\(\\)|subject|activity", names(data_All))]



###################################################################
## PART 3 - Uses descriptive activity names to name the activities
##          in the data set
###################################################################

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)
data_mean_std[, 68] <- activity_labels[data_mean_std[, 68], 2]



###################################################################
## PART 4 - Appropriately label the data set with descriptive 
##          variable names
###################################################################

## Decide to leave the column names as they were from the features label as they are 
## quite descriptive.


###################################################################
## PART 5 - Create a second, independent tidy data set with the 
##          average of each variable for each activity and each
##          subject
###################################################################

data_Averages <- aggregate(data_mean_std[,1:66], by=list(data_mean_std$subject, data_mean_std$activity) , mean)
names(data_Averages[1]) <- "subject"
names(data_Averages[2]) <- "activity"

## write the output to averages.txt
write.table(data_Averages, "averages_data.txt", row.name=FALSE)Enter file contents here
