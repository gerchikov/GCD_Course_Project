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
  X <- merge(X, activity_labels, by.x = "activity.id", by.y = "id")
  X$activity.id <- NULL  # won't need this anymore -- have labels instead
  return(X)
}

# test set:
test <- read.dataset("test")

# train set:
train <- read.dataset("train")

# combine sets:
step4 <- rbind(test, train)

# summarise:
step5 <- aggregate(. ~ activity.label + subject.id, step4, mean)

# write output:      
write.table(step5, "step5.txt", row.names = FALSE)
