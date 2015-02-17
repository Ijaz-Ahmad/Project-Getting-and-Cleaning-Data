# Project Getting and Cleaning Data
### The analytical script starts below this line
###**************************ANALYTICAL SCRIPT**********************************###
### The code written above the separating line downloads the raw data from the web and unzips the same into working directory.
### The packages "tidyr" and "dplyr" are loaded into RStudio.
### The files in the directory "./UCI HAR Dataset" are listed to know which files we need.
### "README.txt" tells us which files to work with.
### I have used function 'read.csv' to read "features_info.txt", "features.txt" and "activity_labels.txt" while function 'read.table' to read "X_train.txt", "X_test.txt", "Y_train.txt" and "Y_test.txt". I failed to handle all the text files with function 'read.table' beacause of constraints I could not resolve.
### The name of column/variable in files "Y_train" and "Y_test" is changed to "activity" - same descriptive name to both files having single/similar variable/column i.e. the numeric value of activity.
### The tables "Y_train" and "X_train" are merged by columns as both have same number of observations/rows and different columns/variables resulting a new table "train". Same is the case with merging of tables "Y_test" and "X_test" resulting a new table "test".
### The tables "test" and "train" are merged by rows resulting a new table "test_train" as both have same variables/columns with different number of observations/rows.
### The numeric values in column/variable "activity" of table "test_train" are replaced with respective descriptive values given in table "activitylablels".
### Data in table "test_train" is grouped by activity and then summarize by average values of each grouped variable into a new table "Avg_by_activity".
### Finally the table "Avg_by_activity" is converted into a text file "AverageByActivity.txt".
