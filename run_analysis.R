
# 1. Merges the training and the test sets to create one data set.

# read the data in variables
data_subject_train <- read.table("subject_train.txt")
data_subject_test <- read.table("subject_test.txt")
data_x_train <- read.table("X_train.txt")
data_x_test <- read.table("X_test.txt")
data_y_train <- read.table("y_train.txt")
data_y_test <- read.table("y_test.txt")

# combining the subject, activity and features for training and test
data_subject <- rbind(data_subject_train, data_subject_test)
data_activity <- rbind(data_y_train, data_y_test)
data_features <- rbind(data_x_train, data_x_test)

# reading the features file into variable
data_features_names <- read.table("features.txt")

#naming the columns for subject, activity and features
names(data_subject) <- c("Subject")
names(data_activity) <- c("Activity")
names(data_features) <- data_features_names$V2

# combining the training and test data sets

final_data <- cbind(data_subject, data_activity, data_features)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

req_feature <- grep("mean\\(\\)|std\\(\\)",data_features_names$V2,value=TRUE)
new_col_names <- c("Subject", "Activity", as.character(req_feature))
final_data<-subset(final_data,select=new_col_names)

# 3. Uses descriptive activity names to name the activities in the data set

activity_labels <- read.table("activity_labels.txt")
final_data$Activity <- factor(final_data$Activity, labels=activity_labels$V2)

# 4. Appropriately labels the data set with descriptive variable names.

names(final_data)<-gsub("^t", "time", names(final_data))
names(final_data)<-gsub("^f", "frequency", names(final_data))
names(final_data)<-gsub("Acc", "Accelerometer", names(final_data))
names(final_data)<-gsub("Gyro", "Gyroscope", names(final_data))
names(final_data)<-gsub("Mag", "Magnitude", names(final_data))
names(final_data)<-gsub("BodyBody", "Body", names(final_data))

# 5. From the data set in step 4, creates a second, independent 
#  tidy data set with the average of each variable 
#  for each activity and each subject.

library(plyr)
final_data_second <- aggregate(. ~Subject + Activity, final_data, mean)
final_data_second<- final_data_second[order(final_data_second$Subject,final_data_second$Activity),]
write.table(final_data_second, file = "tidydata.txt",row.name=FALSE)
