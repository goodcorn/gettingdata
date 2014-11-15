########################## run_analysis.R #############################

## Before running the following scripts, please download and then unzip the project data folder
## Then set your project data folder as the working directory 
## setwd("C:/Users/goodcorn/Desktop/For Coursera/Course#3_Getting and Cleaning Data/Course Project/rawdata")

#################################################

## Step 1: Merge the training and the test sets to create one data set.

##Read in all the training related tables
x_train <- read.table("./train/X_train.txt")
View(x_train) # Take a look at the table
dim(x_train) # Result: [1] 7352  561

y_train <- read.table("./train/y_train.txt")
View(y_train) # Take a look at the table
dim(y_train) # Result: [1] 7352    1

subject_train<- read.table("./train/subject_train.txt")
View(subject_train) # Take a look at the table
dim(subject_train) # Result: [1] 7352    1

##Read in all the testing related tables
x_test <- read.table("./test/X_test.txt")
View(x_test) # Take a look at the table
dim(x_test) # Result: [1] 2947  561 (same column numbers as the table x_train)

y_test <- read.table("./test/y_test.txt")
View(y_test) # Take a look at the table
dim(y_test) # Result: [1] 2947    1

subject_test <- read.table("./test/subject_test.txt")
View(subject_test) # Take a look at the table
dim(subject_test) # Result: [1] 2947    1

## Combine the training and testing data sets
join_x<-rbind(x_train, x_test) #noted that the x_train and the x_test tables have same columns, thus combining the rows
dim(join_x) #Result: [1] 10299   561 Noted that 10299=7352+2947

join_y<-rbind(y_train, y_test)
dim(join_y) #Result: [1] 10299     1

join_sbj<-rbind(subject_train, subject_test)
dim(join_sbj) #Result: [1] 10299     1

#############################################

## Step 2: Extract only the measurements on the mean and standard deviation for each measurement.

##Read in the table features.txt
features <- read.table("./features.txt")
dim(features)  # Result: [1] 561   2
View(features) # Noted some example values in the 2nd column, "tBodyAcc-mean()-X", "tBodyGyroJerk-mean()-Z"

##Based on the example values, identify the mean and standard deviation for each measurement

MeanSTD <- grep("mean\\(\\)|std\\(\\)", features[, 2])
View(MeanSTD) #Result: showed the which one is mean or standard deviation related; 66 items identified

join_x1 <- join_x[, MeanSTD] #pull the 66 columns related information from the table join_x
View(join_x1) # take a look at the result - we should expect 10299 rows with only 66 columns
dim(join_x1) # Result: [1] 10299    66

##Now we need to show the headers (or: column names)
##Noted that the real name of each measurement is listed in the 2nd column of the table features
names(join_x1)<-features[MeanSTD,2]
head(join_x1) #Noted that the headers are not in a good format, for example, it has "()".
names(join_x1)<-gsub("\\(\\)", "", names(join_x1)) # We use this to remove "()"
View(join_x1) #Take a look at the table, now the headers are good to understand, e.g. "tBodyAcc-mean-Z".

#######################################################################


## Step 3: Use descriptive activity names to name the activities in the data set.

## Read in the activity table

activity_lables <- read.table("./activity_labels.txt")
View(activity_lables) #Take a look at the values in the tables

##Update the table activity_lables to reflect descriptive names

activity_lables[, 2] <- gsub("_", " ", activity_lables[, 2]) #Replace "-" by a space in the 2nd column of the table
View(activity_lables) #Take a look at the values in the tables now, e.g. "WALKING UPSTAIRS"

##Reflect the activitity in the table join_y

lables<- activity_lables[join_y[, 1], 2] ##For example, in the table join_y, the value is 3
##Then, in the tabl activity_lables, it means "WALKING DOWNSTAIRS"
## The key is that we cannot change the row order in the table join_y, thus we have to keep the same order and then merge

join_y[, 1] <- lables
View(join_y) # Result: now the row order is the same, but the number value is replaced by activity description

names(join_y) <- "activity" #Add the header name
View(join_y)

#######################################################

## Step 4: Appropriately label the data set with descriptive variable names.

names(join_sbj) <- "subject" #Give the header "subject"
View(join_sbj)

join_final<-cbind(join_sbj, join_y, join_x1) 
#Combined all the columns from the table join_sbj which means subject, 
## the table join_y which means activity,
## and the updated table join_x1 which means the Mean and the Standard Deviations.

View(join_final) #Take a look at the table. 
dim(join_final) #Result: [1] 10299    68

##Write out the dataset from the table join_final

write.table(join_final, "goodcorn_join_final.txt", row.name=FALSE) # The dataset generated at the end of Step 4
## I put "goodcorn" into the file name to show that the dataset was from me not from the raw data. 


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
