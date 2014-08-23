
# Set path to the directory containing the raw data (UCI HAR Dataset)
#path="."
setwd(path)

# read all measures labels
features <- read.table('features.txt', header=FALSE, sep=" ", 
                       col.names=c("featureID","feature"), colClasses=c("integer","character"))

# prepare column names (substituting parentheses with undercore) for the measures tables
colNames <- features$feature
colNames2 <- gsub("()","_",colNames, fixed=TRUE)  

# read measures
Xtest <- read.table('test\\X_test.txt',header=FALSE, col.names=colNames2)
Xtrain <- read.table('train\\X_train.txt',header=FALSE, col.names=colNames2)

# extract only measures which have 'mean' or 'std' in their column names
Xtest2 <- subset(Xtest,select=grep("mean|std",colNames2))
Xtrain2 <- subset(Xtrain,select=grep("mean|std",colNames2))

# read activities codes related to the measures
Ytest <- read.table('test\\Y_test.txt',header=FALSE, col.names="ActivityID")
Ytrain <- read.table('train\\Y_train.txt',header=FALSE, col.names="ActivityID")

# read subjects related to the measures
SubjectTest <- read.table('test\\subject_test.txt',header=FALSE, col.names="SubjectID")
SubjectTrain <- read.table('train\\subject_train.txt',header=FALSE, col.names="SubjectID")

# put Subject and Activity together with the measures
Test <- cbind(SubjectTest,Ytest,Xtest2)
Train <- cbind(SubjectTrain,Ytrain,Xtrain2)

#put together testing and training data
TestTrain <- rbind(Test, Train)

# read the activity labels 
activityLabels <- read.table('activity_labels.txt', header=FALSE, sep=" ", 
                             col.names=c("ActivityID","Activity"))
# add activity labels to the whole file
TestTrain2 <- merge(TestTrain,activityLabels,by=c("ActivityID","ActivityID"))

#library(plyr)
library(reshape2)
# reshapes the data, separate id variables from measure variables
melted <- melt(TestTrain2, id.vars = c("SubjectID","ActivityID","Activity"))

# Average all columns (except SubjectID,ActivityID,Activity)
tidy <- dcast(melted, SubjectID+ActivityID+Activity~...,mean)

# output the tidy (hopefully...) file
write.table(tidy, file="tidy.txt", row.names=FALSE)
