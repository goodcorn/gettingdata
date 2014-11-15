#This is the Code Book for the course project.
This CodeBook.md indicate all the variables and summaries what I calculated, along with units, and any other relevant information.

###The source of the project data
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

###The steps and variables created in the run_analysis.R program
####Step 1: Merge the training and the test sets to create one data set.
Read in all the training related tables and store them in x_train, y_train, and subject_train.
Read in all the testing related tables and store them in x_test, y_test, and subject_test.
Combine the training and testing data sets and store the joined tables in join_x, join_y and join_sbj.

#### Step 2: Extract only the measurements on the mean and standard deviation for each measurement.
Read in the table features.txt and store it in features.
Based on the example values, identify the mean and standard deviation for each measurement, store it in MeanSTD.
Pull the mean and standard deviation columns related information from join_x into join_x1.
Add header names to join_x1.

#### Step 3: Use descriptive activity names to name the activities in the data set.
Read in the activity table and store it in activity_lables.
Update the table activity_lables to reflect descriptive names, replacing "-" by a space
Reflect the activity description in the join_y by creating lables variable to store the related information
Put the information from lables variable into the tabl join_y

#### Step 4: Appropriately label the data set with descriptive variable names.
Give the header names to the table join_sbj
Combined all the columns from the table join_sbj which means subject, the table join_y which means activity, and the updated table join_x1 which means the Mean and the Standard Deviations. Store the joined results into join_final.
Write out the dataset from the table join_final and stored the file as "goodcorn_join_final.txt". This is the dataset generated at the end of Step 4
I put "goodcorn" into the file name to show that the dataset was from me not from the raw data. 


############################################################

## Step 5. From the data set in step 4, create a second, 
## independent tidy data set with the average of each variable for each activity and each subject.

sbj<- length(table(join_sbj)) # Result: there are 30 values. 
act<- dim(activity_lables)[1] # Result: there are 6 activity lables
col<- dim(join_final)[2] #Result: there are 68 columns in the table join_final

##We need to create table to hold the results, i.e. average values by subject and activities. 
##Thus, there will be sbjXact rows for the col amount of columns
a <- as.data.frame(matrix(NA, nrow=sbj*act, ncol=col) )
colnames(a) <- colnames(join_final)
dim(a) #Result: [1] 180  68

##Now we need to start to calculate the averages by subject and by activity

n <- 1
for(i in 1:sbj) {
  for(j in 1:act) {
    a[n, 1] <- sort(unique(join_sbj)[, 1])[i]
    a[n, 2] <- activity_lables[j, 2]
    col1 <- i == join_final$subject # set condition #1 for column 1
    #the condition is when the 1st column of the table join_final (i.e. subject) value equals to the value i
    
    col2 <- activity_lables[j, 2] == join_final$activity # set condiction #2 for column 2
    #the condition is when the 2nd column of the table join_final (i.e. activity) value 
    #equals to the value listed in the activity_lable table related cell (row j, column2)
    
    a[n, 3:col] <- colMeans(join_final[col1&col2, 3:col]) # when both condition 1 and 2 are met, show the average
    n <- n + 1
  }
}

View(a) ##Take a look at the average results

write.table(a, "goodcorn_final_average.txt", row.name=FALSE) # write out the 2nd dataset which is the end result of Step5
##According to the project requirement, "a txt file created with write.table() using row.name=FALSE".

############################# End ###########################################
############################# run_analysis.R ################################
