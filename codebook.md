
Download the dataset, unzipped it as folder "UCI HAR Dataset" with several subfolders

Assign each data to variables (using the correct path in the subfolder)
features <- features.txt : 561 rows, 2 columns
features from the accelerometer and 3-axial gyroscope which result in 3 dimensions i.e. tAcc-XYZ or tGyro-XYZ.
activities <- activity_labels.txt : 6 rows, 2 columns
activities performed in codes and labels (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
subject_test <- test/subject_test.txt : 2947 rows, 1 column
base data portion used for testing, subjects only
x_test <- test/X_test.txt : 2947 rows, 561 columns
base data portion used for testing, features only
y_test <- test/y_test.txt : 2947 rows, 1 columns
base data portion used for testing, activies in codes only
subject_train <- test/subject_train.txt : 7352 rows, 1 column
base data portion used for training, subjects only
x_train <- test/X_train.txt : 7352 rows, 561 columns
base data portion used for training, features only
y_train <- test/y_train.txt : 7352 rows, 1 columns
base data portion used for training, activies in code only

Merges the training and the test sets to create one data set
X (10299 rows, 561 columns) is created by adding the rows of x_train and x_test 
Y (10299 rows, 1 column) is created by adding the rows of y_train and y_test 
Subject (10299 rows, 1 column) is created by adding the rows of subject_train and subject_test
-> All data (rows) are 10299 in total - now, for a complete dataset all columns need to be brought together
Data_merged (10299 rows, 563 column) displays subject, acivtiy and features in using cbind()

Extracts only the measurements on the mean and standard deviation for each measurement
mydata (10299 rows, 88 columns) is created by selecting only columns of Data_merged: only features with the mean ("mean") and standard deviation ("std") for each column
-> only 88 of before 563 colums rest in the new dataset

Uses descriptive activity names to name the activities in the data set
Changing the name to activity and the replace the acitviy code by its character match of the activities table

Appropriately labels the data set with descriptive variable names - the follwing changer were applied on all column names
Acc becomes Accelerometer
Gyro becomes Gyroscope
BodyBody becomes  Body
Mag becomes by Magnitude
start character "f" becomes Frequency
start character "t" becomes  Time
Note: it might be readible but still long, so display in graphics output is not pretty yet

mydata is saved as *.txt after a quick check with head() and str()

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
taking the means of each variable for each activity and each subject, after groupped by subject and activity creates avdata (180 rows, 88 columns) which the is saved as *.txt
