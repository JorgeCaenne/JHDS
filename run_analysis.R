library(dplyr)

#Direct Donload and save into the wd/" specifies saving in this dir followed by given local name
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./JHDS0404Assign.zip")
unzip("JHDS0404Assign.zip")


features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# merge Data by rows, all X, all y, all 
x_data <- rbind(x_test, x_train)
y_data <- rbind(y_test, y_train)
subject_data <- rbind(subject_test, subject_train)

# merge Data by columns with x data as last because has the most columns
Data_merged <- cbind(subject_data, y_data, x_data)
# check merged dataset
Data_merged[1:5,1:15]

#Extract those variables of the max 563 variables that contain a mean or a std 
# deviation in their colum name
mydata <- Data_merged %>% select(subject,code, contains("mean"), contains("std")) 
# check selection of merged dataset
mydata[1:5,1:15]

#rename column code that displays the recorded code for a activity
names(mydata)[2] = "activity"
# assign the text/charakter vektor for the above mentionend codes using the activities table
mydata$activity <- activities[mydata$activity, 2]

# making the abbreviations into full names one part at a time
names(mydata)<-gsub("Acc", "Accelerometer", names(mydata))
names(mydata)<-gsub("Gyro", "Gyroscope", names(mydata))
names(mydata)<-gsub("BodyBody", "Body", names(mydata))
names(mydata)<-gsub("Mag", "Magnitude", names(mydata))
names(mydata)<-gsub("^t", "Time", names(mydata))
names(mydata)<-gsub("^f", "Frequency", names(mydata))
names(mydata)<-gsub("tBody", "TimeBody", names(mydata))
names(mydata)<-gsub("-mean()", "Mean", names(mydata), ignore.case = TRUE)
names(mydata)<-gsub("-std()", "STD", names(mydata), ignore.case = TRUE)
names(mydata)<-gsub("-freq()", "Frequency", names(mydata), ignore.case = TRUE)
names(mydata)<-gsub("angle", "Angle", names(mydata))
names(mydata)<-gsub("gravity", "Gravity", names(mydata))

# check data by display of dataset structure
str(mydata)
write.table(mydata, "JHDS0304_Data_tidy.txt", row.name=FALSE)

# create new dataset with averages for all columns and save as *.txt file
avdata <- mydata %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(avdata, "JHDS0304_Data+Averages.txt", row.name=FALSE)
