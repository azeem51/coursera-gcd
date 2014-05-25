## read all the files that contain the training
## and test data into dataframes

trainsubject <- read.table("train/subject_train.txt")
testsubject <- read.table("test/subject_test.txt")
trainX <- read.table("train/X_train.txt")
testX <- read.table("test/X_test.txt")
trainy <- read.table("train/y_train.txt")
testy <- read.table("test/y_test.txt")

## prepapre a data frame that combines all the data sets into one
## big frame. Make sure that the subject and activity columns are at
## the end for easier labeling later
df <- data.frame()
df <- rbind(cbind(trainX, trainsubject, trainy), cbind(testX,
testsubject, testy))

## get the list of features and along with subject and acitivty
## clean up the names to avoid non-alphanumeric characters
## attach them to the data frame column after

features <- read.table("features.txt")
headers <- features$V2
headers <- as.character(headers)
headers <- c(headers, "subject", "activity")
headers <- gsub("[^[:alnum:] ]", "", headers)
colnames(df) <- headers

## find those columns that represent the mean
## or standard deviation of some measurement
colstoselect <- c(grep ("mean", headers), grep("std", headers))
colstoselect <- c(colstoselect, ncol(df)-1, ncol(df))

## select only those columns of the data frame
sdf <- df[, colstoselect]

## decode the activity variable value from an integer into
## the proper English representation in the activity column
activitytable <- read.table("activity_labels.txt")
sdf$activity <- factor(sdf$activity,
levels = activitytable$V1,
labels = as.character(activitytable$V2)
)


## extract the mean value of all the observations grouped
## by subject and the activity
library(data.table)
sdt <- data.table(sdf)
meandf <- sdt[, lapply(.SD, mean) , by=c("subject", "activity")]

## output the tidy dataset to a file
write.table(meandf, "tidytable.txt")
