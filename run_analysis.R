# Getting and Cleaning Data Course Project

## Collect raw data from web source mentioned in the project

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./data/getcleandata.zip", method="curl")
unzip("./data/getcleandata.zip")

##*************************************ANALYTICAL SCRIPT*******************************************##

## load required packages

library(tidyr)
library(dplyr)

## list files of the directory "./UCI HAR Dataset"

list.files("./UCI HAR Dataset")
list.files("./UCI HAR Dataset/test")
list.files("./UCI HAR Dataset/train")

## load data [files to read "features_info.txt", "features.txt", "activity_labels.txt",
## "train/X_train.txt","train/y_train.txt", "test/X_test.txt" and "test/y_test.txt"]

featuresinfo <- read.csv("./UCI HAR Dataset/features_info.txt", header=FALSE)
features <- read.csv("./UCI HAR Dataset/features.txt", header=FALSE, sep=" ")
activitylabels <- read.csv("./UCI HAR Dataset/activity_labels.txt", header=FALSE, sep=" ")

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")

## change the name of variables

colnames(Y_test) <- "activity"
colnames(Y_train) <- "activity"

## join the *test and *train tables(data.frame)

train <- cbind(Y_train, X_train)
test <- cbind(Y_test, X_test)

## rbind "test" and "train" as both have same number of columns and number of values in that column

test_train <- rbind(test, train)

## replace the numeric value of 'activity column' by descriptive activity lables

test_train$activity <- replace(test_train$activity, test_train$activity==1, "walking")
test_train$activity <- replace(test_train$activity, test_train$activity==2, "walking upstairs")
test_train$activity <- replace(test_train$activity, test_train$activity==3, "walking downstairs")
test_train$activity <- replace(test_train$activity, test_train$activity==4, "sitting")
test_train$activity <- replace(test_train$activity, test_train$activity==5, "standing")
test_train$activity <- replace(test_train$activity, test_train$activity==6, "laying")

## find "mean" and "std" patterns in "features" table

MeanFeature <- grep("mean()", features$V2)
StdFeature <- grep("std()", features$V2)

## select the columns containing "mean" and "standard deviation" values

featuredData <- test_train %>%
        select(activity, V1:V6, V41:V46, V81:V86, V121:V126, V161:V166, V201:V202, V214:V215, V227:V228,
               V240:V241, V253:V254, V266:V271, V294:V296, V345:V350, V373:V375, V424:V429,
               V452:V454, V503:V504, V513, V516:V517, V526, V529:V530, V539, V542:V543,
               V552)

## summarize data by average values of each variable grouped by activity

Avg_by_activity <- featuredData %>%
        select(activity, V1:V552) %>%
        group_by(activity) %>%
        mutate(V2=extract_numeric(V2), V42=extract_numeric(V42), V82=extract_numeric(V82),
               V83=extract_numeric(V83), V121=extract_numeric(V121), V201=extract_numeric(V201),
               V214=extract_numeric(V214), V296=extract_numeric(V296), V373=extract_numeric(V373),
               V452=extract_numeric(V452)) %>%
        summarize(mean(V1, na.rm=TRUE), mean(V2, na.rm=TRUE), mean(V3, na.rm=TRUE),
                  mean(V4, na.rm=TRUE), mean(V5, na.rm=TRUE), mean(V6, na.rm=TRUE),
                  mean(V41, na.rm=TRUE), mean(V42, na.rm=TRUE), mean(V43, na.rm=TRUE),
                  mean(V44, na.rm=TRUE), mean(V45, na.rm=TRUE), mean(V46, na.rm=TRUE),
                  mean(V81, na.rm=TRUE), mean(V82, na.rm=TRUE), mean(V83, na.rm=TRUE),
                  mean(V84, na.rm=TRUE), mean(V85, na.rm=TRUE), mean(V86, na.rm=TRUE),
                  mean(V121, na.rm=TRUE), mean(V122, na.rm=TRUE), mean(V123, na.rm=TRUE),
                  mean(V124, na.rm=TRUE), mean(V125, na.rm=TRUE), mean(V126, na.rm=TRUE),
                  mean(V161, na.rm=TRUE), mean(V162, na.rm=TRUE), mean(V163, na.rm=TRUE),
                  mean(V164, na.rm=TRUE), mean(V165, na.rm=TRUE), mean(V166, na.rm=TRUE),
                  mean(V201, na.rm=TRUE), mean(V202, na.rm=TRUE), mean(V214, na.rm=TRUE),
                  mean(V215, na.rm=TRUE), mean(V227, na.rm=TRUE), mean(V228, na.rm=TRUE),
                  mean(V240, na.rm=TRUE), mean(V241, na.rm=TRUE), mean(V253, na.rm=TRUE),
                  mean(V254, na.rm=TRUE), mean(V266, na.rm=TRUE), mean(V267, na.rm=TRUE),
                  mean(V268, na.rm=TRUE), mean(V269, na.rm=TRUE), mean(V270, na.rm=TRUE),
                  mean(V271, na.rm=TRUE), mean(V294, na.rm=TRUE), mean(V295, na.rm=TRUE),
                  mean(V296, na.rm=TRUE), mean(V345, na.rm=TRUE), mean(V346, na.rm=TRUE),
                  mean(V347, na.rm=TRUE), mean(V348, na.rm=TRUE), mean(V349, na.rm=TRUE),
                  mean(V350, na.rm=TRUE), mean(V373, na.rm=TRUE), mean(V374, na.rm=TRUE),
                  mean(V375, na.rm=TRUE), mean(V424, na.rm=TRUE), mean(V425, na.rm=TRUE),
                  mean(V426, na.rm=TRUE), mean(V427, na.rm=TRUE), mean(V428, na.rm=TRUE),
                  mean(V429, na.rm=TRUE), mean(V452, na.rm=TRUE), mean(V454, na.rm=TRUE),
                  mean(V453, na.rm=TRUE), mean(V503, na.rm=TRUE), mean(V504, na.rm=TRUE),
                  mean(V513, na.rm=TRUE), mean(V516, na.rm=TRUE), mean(V517, na.rm=TRUE),
                  mean(V526, na.rm=TRUE), mean(V529, na.rm=TRUE), mean(V530, na.rm=TRUE),
                  mean(V539, na.rm=TRUE), mean(V542, na.rm=TRUE),mean(V543, na.rm=TRUE),
                  mean(V552, na.rm=TRUE))
## set the despcriptive names of columns/variables (as defined in 'features' file)

cnames <- c("activity", "tBodyAcc.mean.X", "tBodyAcc.mean.Y", "tBodyAcc.mean.Z", "tBodyAcc.std.X",
            "tBodyAcc.std.Y", "tBodyAcc.std.Z", "tGravityAcc.mean.X", "tGravityAcc.mean.Y",
            "tGravityAcc.mean.Z", "tGravityAcc.std.X", "tGravityAcc.std.Y", "tGravityAcc.std.Z",
            "tBodyAccJerk.mean.X", "tBodyAccJerk.mean.Y", "tBodyAccJerk.mean.Z", "tBodyAccJerk.std.X",
            "tBodyAccJerk.std.Y", "tBodyAccJerk.std.Z", "tBodyGyro.mean.X", "tBodyGyro.mean.Y",
            "tBodyGyro.mean.Z", "tBodyGyro.std.X", "tBodyGyro.std.Y", "tBodyGyro.std.Z",
            "tBodyGyroJerk.mean.X", "tBodyGyroJerk.mean.Y", "tBodyGyroJerk.mean.Z",
            "tBodyGyroJerk.std.X", "tBodyGyroJerk.std.Y", "tBodyGyroJerk.std.Z", "tBodyAccMag.mean",
            "tBodyAccMag.std", "tGravityAccMag.mean", "tGravityAccMag.std", "tBodyAccJerkMag.mean",
            "tBodyAccJerkMag.std", "tBodyGyroMag.mean", "tBodyGyroMag.std", "tBodyGyroJerkMag.mean",
            "tBodyGyroJerkMag.std", "fBodyAcc.mean.X", "fBodyAcc.mean.Y", "fBodyAcc.mean.Z",
            "fBodyAcc.std.X", "fBodyAcc.std.Y", "fBodyAcc.std.Z", "fBodyAcc.meanFreq.X",
            "fBodyAcc.meanFreq.Y", "fBodyAcc.meanFreq.Z", "fBodyAccJerk.mean.X", "fBodyAccJerk.mean.Y",
            "fBodyAccJerk.mean.Z", "fBodyAccJerk.std.X", "fBodyAccJerk.std.Y", "fBodyAccJerk.std.Z",
            "fBodyAccJerk.meanFreq.X", "fBodyAccJerk.meanFreq.Y", "fBodyAccJerk.meanFreq.Z",
            "fBodyGyro.mean.X", "fBodyGyro.mean.Y", "fBodyGyro.mean.Z", "fBodyGyro.std.X",
            "fBodyGyro.std.Y", "fBodyGyro.std.Z", "fBodyGyro.meanFreq.X", "fBodyGyro.meanFreq.Y",
            "fBodyGyro.meanFreq.Z", "fBodyAccMag.mean", "fBodyAccMag.std", "fBodyAccMag.meanFreq",
            "fBodyBodyAccJerkMag.mean", "fBodyBodyAccJerkMag.std", "fBodyBodyAccJerkMag.meanFreq",
            "fBodyBodyGyroMag.mean", "fBodyBodyGyroMag.std", "fBodyBodyGyroMag.meanFreq",
            "fBodyBodyGyroJerkMag.mean", "fBodyBodyGyroJerkMag.std", "fBodyBodyGyroJerkMag.meanFreq")
colnames(Avg_by_activity) <- cnames

## convert the data.frame into a text file

write.table(Avg_by_activity, "AverageByActivity.txt", row.name=FALSE)
