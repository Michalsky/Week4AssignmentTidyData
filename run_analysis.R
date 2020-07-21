library('dplyr')

##Load supplementary data
#Load features 
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("feature_key", "feature_name"), header = FALSE)
#Load Activity
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activity_key", "activity_label"), header = FALSE)

##Load TEST data
#Base TEST data
test_data <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
test_act <-  read.table("UCI HAR Dataset/test/y_test.txt", col.names= c("activity_key"), header = FALSE)
#TEST data subjects
test_subject <-  read.table("UCI HAR Dataset/test/subject_test.txt", col.names= c("subject"), header = FALSE)
#Load Inertial Signal TEST Data
#The body acceleration readings XYZ
test_body_acc_x <-  read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt", header = FALSE)
test_body_acc_y <-  read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt", header = FALSE)
test_body_acc_Z <-  read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt", header = FALSE)
#The body gyroscopic readings XYZ
test_body_gyro_x <-  read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt", header = FALSE)
test_body_gyro_y <-  read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt", header = FALSE)
test_body_gyro_Z <-  read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt", header = FALSE)
#Total acceleration readings XYZ
test_total_acc_x <-  read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt", header = FALSE)
test_total_acc_y <-  read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt", header = FALSE)
test_total_acc_Z <-  read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt", header = FALSE)

##Load TRAIN data
#Base TRAIN data
train_data <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
train_act <-  read.table("UCI HAR Dataset/train/y_train.txt", col.names= c("activity_key"), header = FALSE)
#TRAIN data subjects
train_subject <-  read.table("UCI HAR Dataset/train/subject_train.txt", col.names= c("subject"), header = FALSE)
#Load Inertial Signal TRAIN Data
#The body acceleration readings XYZ
train_body_acc_x <-  read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt", header = FALSE)
train_body_acc_y <-  read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt", header = FALSE)
train_body_acc_Z <-  read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt", header = FALSE)
#The body gyroscopic readings XYZ
train_body_gyro_x <-  read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt", header = FALSE)
train_body_gyro_y <-  read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt", header = FALSE)
train_body_gyro_Z <-  read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt", header = FALSE)
#Total acceleration readings XYZ
train_total_acc_x <-  read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt", header = FALSE)
train_total_acc_y <-  read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt", header = FALSE)
train_total_acc_Z <-  read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt", header = FALSE)


#Map feature names to the TEST & TRAIN data
names(train_data) <- features$feature_name
names(test_data) <- features$feature_name


#Combine TRAIN data with activities & labels
train_complete <-cbind(train_subject,
                              merge(train_act, activity_labels, by="activity_key"),
                              train_data)

#Combine TEST data with activities & labels
test_complete <-cbind(test_subject,
                       merge(test_act, activity_labels, by="activity_key"),
                       test_data)

#Add source field to help identify source data set
train_complete$source <- "TRAIN"  #Mark in the data frame where the data came from
test_complete$source <- "TEST"

#Combine data sets & sort by subject > activity
test_and_train <- rbind(train_complete, test_complete) 

#Extract columns based on mean & std calculations
test_and_train <-test_and_train%>%select(matches('subject|activity|mean|std'))
test_and_train <-test_and_train%>%select(!matches('activity_key'))


#Apply meaningful variable names
names(test_and_train) <- gsub("angle\\(tBodyAccJerkMean),gravityMean\\)", "ANGLE between Body Acceleration Jerk Signal (Time Domain) MEAN Vector and Gravity MEAN Vector", names(test_and_train))
names(test_and_train) <- gsub("angle\\(tBodyGyroJerkMean,gravityMean\\)", "ANGLE between Body Gyroscopic Jerk Signal (Time Domain) MEAN Vector and Gravity MEAN Vector", names(test_and_train))
names(test_and_train) <- gsub("angle\\(tBodyAccMean,gravity\\)", "ANGLE between Body Acceleration Signal (Time Domain) MEAN Vector and Gravity MEAN Vector", names(test_and_train))
names(test_and_train) <- gsub("angle\\(tBodyGyroMean,gravityMean\\)", "ANGLE between Body Gyroscopic Signal (Time Domain) MEAN Vector and Gravity MEAN Vector", names(test_and_train))
names(test_and_train) <- gsub("angle\\(X,gravityMean\\)", "ANGLE between X Vector and Gravity MEAN Vector", names(test_and_train))
names(test_and_train) <- gsub("angle\\(Y,gravityMean\\)", "ANGLE between Y Vector and Gravity MEAN Vector", names(test_and_train))
names(test_and_train) <- gsub("angle\\(Z,gravityMean\\)", "ANGLE between Z Vector and Gravity MEAN Vector", names(test_and_train)) 
names(test_and_train) <- gsub("tBodyAcc-", "Body Acceleration Signal (Time Domain)", names(test_and_train))
names(test_and_train) <- gsub("tGravityAcc-", "Gravity Acceleration Signal (Time Domain)", names(test_and_train))
names(test_and_train) <- gsub("tBodyAccJerk-", "Body Acceleration Jerk Signal (Time Domain)", names(test_and_train))
names(test_and_train) <- gsub("tBodyGyro-", "Body Gyroscopic Signal (Time Domain)", names(test_and_train))
names(test_and_train) <- gsub("tBodyGyroJerk-", "Body Gyroscopic Jerk Signal (Time Domain)", names(test_and_train))
names(test_and_train) <- gsub("tBodyAccMag-", "Body Acceleration Magnitude (Time Domain)", names(test_and_train))
names(test_and_train) <- gsub("tGravityAccMag-", "Gravity Acceleration Magnitude (Time Domain)", names(test_and_train))
names(test_and_train) <- gsub("tGravityAccJerkMag-", "Gravity Acceleration Jerk Magnitude (Time Domain)", names(test_and_train))
names(test_and_train) <- gsub("tBodyGyroMag-", "Body Gyroscopic Magnitude (Time Domain)", names(test_and_train))
names(test_and_train) <- gsub("tBodyGyroJerkMag-", "Body Gyroscopic Jerk Magnitude (Time Domain)", names(test_and_train))
names(test_and_train) <- gsub("tBodyAccJerkMag-", "Body Acceleration Jerk Magnitude (Time Domain)", names(test_and_train))
names(test_and_train) <- gsub("fBodyAcc-", "Body Acceleration Fast Fourier Transform Signal (Frequency Domain)", names(test_and_train))
names(test_and_train) <- gsub("fBodyAccJerk-", "Body Acceleration Jerk Fast Fourier Transform Signal (Frequency Domain)", names(test_and_train))
names(test_and_train) <- gsub("fBodyGyro-", "Body Gyroscopic Fast Fourier Transform Signal (Frequency Domain)", names(test_and_train))
names(test_and_train) <- gsub("fBodyAccMag-", "Body Acceleration Fast Fourier Transform Magnitude (Frequency Domain)", names(test_and_train))
names(test_and_train) <- gsub("fBodyAccJerkMag-", "Body Acceleration Jerk Fast Fourier Transform Magnitude (Frequency Domain)", names(test_and_train))
names(test_and_train) <- gsub("fBodyGyroMag-", "Body Gyroscopic Fast Fourier Transform Magnitude (Frequency Domain)", names(test_and_train))
names(test_and_train) <- gsub("fBodyGyroJerkMag-", "Body Gyroscopic Jerk Fast Fourier Transform Magnitude (Frequency Domain)", names(test_and_train))
names(test_and_train) <- gsub("fBodyBodyAccJerkMag-", "Body Acceleration Jerk Fast Fourier Transform Magnitude (Frequency Domain)", names(test_and_train))
names(test_and_train) <- gsub("fBodyBodyGyroMag-", "Body Gyroscopic Fast Fourier Transform Magnitude (Frequency Domain)", names(test_and_train))
names(test_and_train) <- gsub("fBodyBodyGyroJerkMag-", "Body Gyroscopic Jerk Fast Fourier Transform Magnitude (Frequency Domain)", names(test_and_train))
names(test_and_train) <- gsub(" \\(Time Domain\\)mean\\(\\)", " MEAN calculation (Time Domain)", names(test_and_train))
names(test_and_train) <- gsub(" \\(Time Domain\\)mean\\(\\)-X", " MEAN calculation (Time Domain)-X", names(test_and_train))
names(test_and_train) <- gsub(" \\(Time Domain\\)mean\\(\\)-Y", " MEAN calculation (Time Domain)-Y", names(test_and_train))
names(test_and_train) <- gsub(" \\(Time Domain\\)mean\\(\\)-Z", " MEAN calculation (Time Domain)-Z", names(test_and_train))
names(test_and_train) <- gsub(" \\(Time Domain\\)std\\(\\)", " STANDARD DEVIATION calculation (Time Domain)", names(test_and_train))
names(test_and_train) <- gsub(" \\(Time Domain\\)std\\(\\)-X", " STANDARD DEVIATION calculation (Time Domain)-X", names(test_and_train))
names(test_and_train) <- gsub(" \\(Time Domain\\)std\\(\\)-Y", " STANDARD DEVIATION calculation (Time Domain)-Y", names(test_and_train))
names(test_and_train) <- gsub(" \\(Time Domain\\)std\\(\\)-Z", " STANDARD DEVIATION calculation (Time Domain)-Z", names(test_and_train))
names(test_and_train) <- gsub("meanFreq\\(\\)", " FREQUENCY_MEAN calculation", names(test_and_train))
names(test_and_train) <- gsub(" \\(Time Domain\\)meanFreq\\(\\)", " FREQUENCY_MEAN calculation", names(test_and_train))
names(test_and_train) <- gsub(" \\(Frequency Domain\\)mean\\(\\)", " MEAN calculation (Frequency Domain)", names(test_and_train))
names(test_and_train) <- gsub(" \\(Frequency Domain\\)mean\\(\\)-X", " MEAN calculation (Frequency Domain)-X", names(test_and_train))
names(test_and_train) <- gsub(" \\(Frequency Domain\\)mean\\(\\)-Y", " MEAN calculation (Frequency Domain)-Y", names(test_and_train))
names(test_and_train) <- gsub(" \\(Frequency Domain\\)mean\\(\\)-Z", " MEAN calculation (Frequency Domain)-Z", names(test_and_train))
names(test_and_train) <- gsub(" \\(Frequency Domain\\)std\\(\\)", " STANDARD DEVIATION calculation (Frequency Domain)", names(test_and_train))
names(test_and_train) <- gsub(" \\(Frequency Domain\\)std\\(\\)-X", " STANDARD DEVIATION calculation (Frequency Domain)-X", names(test_and_train))
names(test_and_train) <- gsub(" \\(Frequency Domain\\)std\\(\\)-Y", " STANDARD DEVIATION calculation (Frequency Domain)-Y", names(test_and_train))
names(test_and_train) <- gsub(" \\(Frequency Domain\\)std\\(\\)-Z", " STANDARD DEVIATION calculation (Frequency Domain)-Z", names(test_and_train))



#Average per subject & activity
final<-summarize_all(group_by(test_and_train,subject,activity_label), mean)
#Write file to current working directory
write.table(final, file='train_and_test_analyzed.csv', sep=",", row.names = FALSE)


