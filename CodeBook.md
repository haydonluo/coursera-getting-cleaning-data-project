# Code Book
This code book discribes how the raw data is transformed into clean data.

## The R Script
The script `run_analysis.R` performs the 5 steps as follows:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Variables
* `X_train`, `Y_train`, `X_test`, `Y_test`, `subject_train` and `subject_test`: loaded from files dowloaded.
* `features` and `activities`: contains the correct names.
* `subject`: merged from `subject_train` and `subject_test`.
* `X`: merged from `X_train` and `X_test`.
* `Y`: merged from `Y_train` and `Y_test`.
* `data`: merged from `X`, `Y` and `subject`.
* `data2`: containing final data. `lapply`is used to calculate the `mean` and `SD`. Final result is writen into `calculated_tidy_data.txt`.
