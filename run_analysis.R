# sourcing dlpyr package that's needed in the end to be able to use the summarise_each function
library("dplyr")

# downloading and extracting files to the working directory
load_dataset <- function() {
  fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileurl, destfile="UCI_HAR_Dataset.zip")
  unzip("UCI_HAR_Dataset.zip", overwrite = TRUE)
}

# reading downloaded files into R 
read_datasets <- function(){
  x_test <- read.table("UCI HAR Dataset/test/X_test.txt", comment.char="")
  x_train <- read.table("UCI HAR Dataset/train/X_train.txt", comment.char="")
  y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
  y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
  subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
  subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
  activities <- read.table("UCI HAR Dataset/activity_labels.txt")
}

# merging created datasets into 3 (test and train data)
merge_datasets <- function(){
  x_merged <- rbind(x_test, x_train)
  y_merged <- rbind(y_test, y_train)
  subject_merged <- rbind(subject_test, subject_train)
}

# adding missing column names for the data
colnames(subject_merged) <- "SubjectId"
colnames(activities) <- c("ActivityId", "ActivityType")

# renaming variables so they are more descriptive for the x_merged dataset
beautify_x_colnames <- function(){
  varname <- read.table("UCI HAR Dataset/features.txt", col.names=c("FeatureId", "FeatureName"))$FeatureName
  varname <- gsub("()", "", varname, fixed = TRUE)
  varname <- gsub("-", "_", varname, fixed = TRUE)
  varname <- gsub(",", "_", varname, fixed = TRUE)
  varname <- gsub("(", "_", varname, fixed = TRUE)
  varname <- gsub(")$", "", varname)
  varname <- gsub(")", "", varname)
  varname <- gsub("__", "_", varname, fixed = TRUE)
  varname <- gsub("^t", "Time", varname)
  varname <- gsub("^angle_t", "angle_Time", varname)
  varname <- gsub("^f", "Frequency", varname)
  varname <- gsub("BodyBody", "Body", varname)
  varname <- gsub("Acc", "Accelerometer", varname)
  varname <- gsub("Gyro", "Gyroscope", varname)
  varname <- gsub("Mag", "Magnitude", varname)
  names(x_merged) <- varname
}

# extracting only columns with mean and standard deviation from the x_merged dataset
filtered_x_merged <- x_merged[, grep("mean|std", names(x_merged), ignore.case=TRUE)]

# renaming activities in y_merged dataset to have more descriptive names in resulting data set
y_merged[, 1] = activities[y_merged[, 1], 2]
names(y_merged) <- "Activity"

# merging all the things together
data <- cbind(subject_merged, y_merged, filtered_x_merged)

# summarizing final dataset by activity and subject using summarise_each command from dplyr package and 
# exporting it to a file 
values <- summarise_each(group_by(data, SubjectId, Activity), funs(mean))
write.table(values, file="tidy_data.txt", row.name=FALSE)
