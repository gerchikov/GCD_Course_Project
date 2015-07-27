require(plyr)  # for ddply

# common:
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = F, 
                              col.names = c("id", "activity.label"))

features <- read.table("UCI HAR Dataset/features.txt", header = F,
                       col.names = c("id", "label"), as.is = T)
features.interesting <- grepl("-(mean|std)\\(\\)", features$label)

read.dataset <- function(
  name = "test")  # Must be "test" or "train" for UCI HAR Dataset
{
  subject <- read.table(paste0("UCI HAR Dataset/", name, "/subject_", name, ".txt"), 
                        header = F,
                        col.names = "id")
  
  X <- read.table(paste0("UCI HAR Dataset/", name, "/X_", name, ".txt"),
                  header = F,
                  col.names = features[, "label"], 
                  colClasses = ifelse(features.interesting, numeric(), "NULL"))
  
  y <- read.table(paste0("UCI HAR Dataset/", name, "/y_", name, ".txt"),
                  header = F,
                  col.names = "id")
  
  X$subject.id <- subject$id
  X$activity.id <- y$id
  merge(X, activity_labels, by.x = "activity.id", by.y = "id")
}

# test set:
test <- read.dataset("test")

# train set:
train <- read.dataset("train")

# combine sets:
step4 <- rbind(test, train)

# summarise:
# (OK, I hate this implementation, but I am *really* out of time, and it works...)
step5 <- ddply(step4, .(activity.label, subject.id), summarise, 
      tBodyAcc.mean...X = mean(tBodyAcc.mean...X),
      tBodyAcc.mean...Y = mean(tBodyAcc.mean...Y),
      tBodyAcc.mean...Z = mean(tBodyAcc.mean...Z),
      tBodyAcc.std...X = mean(tBodyAcc.std...X),
      tBodyAcc.std...Y = mean(tBodyAcc.std...Y),
      tBodyAcc.std...Z = mean(tBodyAcc.std...Z),
      tGravityAcc.mean...X = mean(tGravityAcc.mean...X),
      tGravityAcc.mean...Y = mean(tGravityAcc.mean...Y),
      tGravityAcc.mean...Z = mean(tGravityAcc.mean...Z),
      tGravityAcc.std...X = mean(tGravityAcc.std...X),
      tGravityAcc.std...Y = mean(tGravityAcc.std...Y),
      tGravityAcc.std...Z = mean(tGravityAcc.std...Z),
      tBodyAccJerk.mean...X = mean(tBodyAccJerk.mean...X),
      tBodyAccJerk.mean...Y = mean(tBodyAccJerk.mean...Y),
      tBodyAccJerk.mean...Z = mean(tBodyAccJerk.mean...Z),
      tBodyAccJerk.std...X = mean(tBodyAccJerk.std...X),
      tBodyAccJerk.std...Y = mean(tBodyAccJerk.std...Y),
      tBodyAccJerk.std...Z = mean(tBodyAccJerk.std...Z),
      tBodyGyro.mean...X = mean(tBodyGyro.mean...X),
      tBodyGyro.mean...Y = mean(tBodyGyro.mean...Y),
      tBodyGyro.mean...Z = mean(tBodyGyro.mean...Z),
      tBodyGyro.std...X = mean(tBodyGyro.std...X),
      tBodyGyro.std...Y = mean(tBodyGyro.std...Y),
      tBodyGyro.std...Z = mean(tBodyGyro.std...Z),
      tBodyGyroJerk.mean...X = mean(tBodyGyroJerk.mean...X),
      tBodyGyroJerk.mean...Y = mean(tBodyGyroJerk.mean...Y),
      tBodyGyroJerk.mean...Z = mean(tBodyGyroJerk.mean...Z),
      tBodyGyroJerk.std...X = mean(tBodyGyroJerk.std...X),
      tBodyGyroJerk.std...Y = mean(tBodyGyroJerk.std...Y),
      tBodyGyroJerk.std...Z = mean(tBodyGyroJerk.std...Z),
      tBodyAccMag.mean.. = mean(tBodyAccMag.mean..),
      tBodyAccMag.std.. = mean(tBodyAccMag.std..),
      tGravityAccMag.mean.. = mean(tGravityAccMag.mean..),
      tGravityAccMag.std.. = mean(tGravityAccMag.std..),
      tBodyAccJerkMag.mean.. = mean(tBodyAccJerkMag.mean..),
      tBodyAccJerkMag.std.. = mean(tBodyAccJerkMag.std..),
      tBodyGyroMag.mean.. = mean(tBodyGyroMag.mean..),
      tBodyGyroMag.std.. = mean(tBodyGyroMag.std..),
      tBodyGyroJerkMag.mean.. = mean(tBodyGyroJerkMag.mean..),
      tBodyGyroJerkMag.std.. = mean(tBodyGyroJerkMag.std..),
      fBodyAcc.mean...X = mean(fBodyAcc.mean...X),
      fBodyAcc.mean...Y = mean(fBodyAcc.mean...Y),
      fBodyAcc.mean...Z = mean(fBodyAcc.mean...Z),
      fBodyAcc.std...X = mean(fBodyAcc.std...X),
      fBodyAcc.std...Y = mean(fBodyAcc.std...Y),
      fBodyAcc.std...Z = mean(fBodyAcc.std...Z),
      fBodyAccJerk.mean...X = mean(fBodyAccJerk.mean...X),
      fBodyAccJerk.mean...Y = mean(fBodyAccJerk.mean...Y),
      fBodyAccJerk.mean...Z = mean(fBodyAccJerk.mean...Z),
      fBodyAccJerk.std...X = mean(fBodyAccJerk.std...X),
      fBodyAccJerk.std...Y = mean(fBodyAccJerk.std...Y),
      fBodyAccJerk.std...Z = mean(fBodyAccJerk.std...Z),
      fBodyGyro.mean...X = mean(fBodyGyro.mean...X),
      fBodyGyro.mean...Y = mean(fBodyGyro.mean...Y),
      fBodyGyro.mean...Z = mean(fBodyGyro.mean...Z),
      fBodyGyro.std...X = mean(fBodyGyro.std...X),
      fBodyGyro.std...Y = mean(fBodyGyro.std...Y),
      fBodyGyro.std...Z = mean(fBodyGyro.std...Z),
      fBodyAccMag.mean.. = mean(fBodyAccMag.mean..),
      fBodyAccMag.std.. = mean(fBodyAccMag.std..),
      fBodyBodyAccJerkMag.mean.. = mean(fBodyBodyAccJerkMag.mean..),
      fBodyBodyAccJerkMag.std.. = mean(fBodyBodyAccJerkMag.std..),
      fBodyBodyGyroMag.mean.. = mean(fBodyBodyGyroMag.mean..),
      fBodyBodyGyroMag.std.. = mean(fBodyBodyGyroMag.std..),
      fBodyBodyGyroJerkMag.mean.. = mean(fBodyBodyGyroJerkMag.mean..),
      fBodyBodyGyroJerkMag.std.. = mean(fBodyBodyGyroJerkMag.std..))

# write output:      
write.table(step5, "step5.txt", row.names = FALSE)
