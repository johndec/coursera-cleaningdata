# run_analysis.R
# John DeCuir

require(dplyr)
require(reshape)

##############################
# 1. Merges the training and the test sets to create one data set.
##############################

setwd("c:\\temp\\project")
setwd("UCI Har Dataset")
features <- read.table("features.txt", header = FALSE, stringsAsFactors = FALSE)
activities <- read.table("activity_labels.txt", header = FALSE, stringsAsFactors = FALSE)

setwd("test")
testdata <- read.table("X_test.txt", header = FALSE)
names(testdata) <- features[,2]
subject.test <- read.table("subject_test.txt", header = FALSE)
testdata$subject <- subject.test[,1]
test.activities <- read.table("y_test.txt", header = FALSE)
testdata$activity <- test.activities[,1]

setwd("..")
setwd("train")
traindata <- read.table("X_train.txt", header = FALSE)
names(traindata) <- features[,2]
subject.train <- read.table("subject_train.txt", header = FALSE)
traindata$subject <- subject.train[,1]
train.activities <- read.table("y_train.txt", header = FALSE)
traindata$activity <- train.activities[,1]

combineddata <- rbind(traindata, testdata)

##############################
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
##############################

reduceddata <- combineddata[,-grep("std|mean", names(combineddata))]

##############################
# 3. Uses descriptive activity names to name the activities in the data set
##############################

reduceddata <- mutate(reduceddata, desc_activity = activities[activity,2])
reduceddata$activity <- NULL

##############################
# 4. Appropriately labels the data set with descriptive variable names. 
##############################

# Already done!

##############################
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##############################

melted <- melt(reduceddata, id=c("subject", "desc_activity"))
recasted <- dcast(melted, subject + desc_activity ~ variable, mean)
melted2 <- melt(recasted, id=c("subject", "desc_activity"))

########
# emit the output
########

setwd("..\\..")
write.table(melted2, file="output.txt", row.name=FALSE)

