#This is the Code Book for the course project.
This CodeBook.md indicate all the variables and summaries what I calculated, along with units, and any other relevant information.

The source of the project data:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
=====================

##The steps and variables created in the run_analysis.R program:

####Step 1: Merge the training and the test sets to create one data set.
==
Read in all the training related tables and store them in x_train, y_train, and subject_train.
=
Read in all the testing related tables and store them in x_test, y_test, and subject_test.
=
Combine the training and testing data sets and store the joined tables in join_x, join_y and join_sbj.
=

#### Step 2: Extract only the measurements on the mean and standard deviation for each measurement.
==
Read in the table features.txt and store it in features.
Based on the example values, identify the mean and standard deviation for each measurement, store it in MeanSTD.
Pull the mean and standard deviation columns related information from join_x into join_x1.
Add header names to join_x1.

#### Step 3: Use descriptive activity names to name the activities in the data set.
==
Read in the activity table and store it in activity_lables.
Update the table activity_lables to reflect descriptive names, replacing "-" by a space.
Reflect the activity description in the join_y by creating lables variable to store the related information.
Put the information from lables variable into the tabl join_y.

#### Step 4: Appropriately label the data set with descriptive variable names.
==
Give the header names to the table join_sbj.
Combined all the columns from the table join_sbj which means subject, the table join_y which means activity, and the updated table join_x1 which means the Mean and the Standard Deviations. Store the joined results into join_final.
Write out the dataset from the table join_final and stored the file as "goodcorn_join_final.txt". This is the dataset generated at the end of Step 4.
I put "goodcorn" into the file name to show that the dataset was from me not from the raw data. 

#### Step 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
==
Store the amount of values of table join_sbj into the variable sbj. 
Store the amount of activities into the variable act.
Store the amount of columns of join_final into the variable col.
We need to create table to hold the results, i.e. average values by subject and activities. Thus, there will be sbj X act rows for the col amount of columns. 
Create a data frame named a to list related rows and columns. 
The colum names of a are the same as join_final's.
Now we need to start to calculate the averages by subject and by activity by using "for" funtion to loop. 
Write out the final results a into the file named "goodcorn_final_average.txt". This is the 2nd dataset created. This is the end result of Step5
