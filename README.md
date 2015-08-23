# coursera-cleaningdata
Coursework for the Coursera "Getting and Cleaning Data" class.

## How the script works

The script follows the five steps of the programming assignment.

### Merges the training and the test sets to create one data set

This part of the code utilizes the read.table function to read the various files in the data package.

In addition, some massaging is done:
* The names of the columns are replaced by the contents of the features.txt file  (this alleviates the need to do anything in Step 4)
* A "subject" column is added, grafting on the contents of the subject_test (or subject_train) file
* An "activity" column is added, grafting on the contents of the y_test (or y_train) file

Finally, the test and train data frames are combined together via the rbind command.

### Extracts only the measurements on the mean and standard deviation for each measurement.

Here we use the grep feature to find all the column names that contain "std" or "mean".  We negate this result and use it
as an index into the same data frame -- this allows us to quickly remove these columns from the data frame.

### Uses descriptive activity names to name the activities in the data set

Here we use the mutate command to create a new column, desc_activity.  This column maps the numbers in the activity
column (which were taken from y_test/y_train) to items in the activities vector (which was taken from activity_labels.txt)

After this step, since we have no need for the original numeric activity column, we remove it.

### Appropriately labels the data set with descriptive variable names.

This step was already done above in step 1.

### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

This is a three step process.

1. Melt the data frame into a long data frame (with "subject" and "desc_activity" as the primary indices)
2. Recast the melted long data frame into a wide data frame, taking the mean of each variable
3. Melt the result into a long data frame as the final output.

Finally, write the output.

## Code Book for the output

Each measurement is on one line.  It contains the following columns.

1. subject:  The numerical index of the subject performing the test.
2. desc_activity:  The descriptive name of the activity being taken (e.g. "SITTING", "STANDING")
3. variable:  The sensor variable being averaged for that subject+activity
4. value:  The average numerical result for that subject+activity+variable.

