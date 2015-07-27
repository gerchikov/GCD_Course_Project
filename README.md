The following files must be present in the current working directory:

* ./UCI HAR Dataset/activity_labels.txt
* ./UCI HAR Dataset/features.txt
* ./UCI HAR Dataset/test/subject_test.txt
* ./UCI HAR Dataset/test/X_test.txt
* ./UCI HAR Dataset/test/y_test.txt
* ./UCI HAR Dataset/train/subject_train.txt
* ./UCI HAR Dataset/train/X_train.txt
* ./UCI HAR Dataset/train/y_train.txt

Run as `source("run_analysis.R")`

Steps:

1. Read data files common to both test and train sets:
  * activity_labels.txt
  * features.txt
Prepare a logical vector that flags mean and standard deviation values for every variable.
2. Define a function to read in the test or train dataset. Within it:
  * read `subject`, `X` and `y` files (only the "interesting" columns of X); assign meaningful column names
  * add subject ids and activity ids to X data frame
  * merge (and return) the resulting X data frame with human-readable activity labels
3. Using defined function, read in test and train sets
4. Combine the two sets
5. Summarise the combined set, computing group means of every data column, grouping by activity label and subject id
6. Write output of step 5 to `step5.txt`
