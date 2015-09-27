## Description

Additional information about the variables, data and transformations or work that were performed to clean up the data. 

## Source Data

A full description for the data is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Attribute Information

For each record in the dataset it is provided:

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope.
* A 561-feature vector with time and frequency domain variables.
* Its activity label.
* An identifier of the subject who carried out the experiment.

## Reading, merging and cleaning up data

* *load_datasets()* function in run_analysis.R downloads the necessary files to the working directory. 
* *read_datasets()* function reads them into R. 
* *merge_datasets()* function merges the test and train datasets into 3 combined datasets (x_merged, y_merged and subject_merged). 
* *beautify_x_colnames()* function makes a set of changes to the variables in x_merged dataset in order to make them more readable and clean. 
* After that the new dataset is created from x_merged that consists of columns that contain either mean or standard deviation records. 
* *summarize_and_export()* function summarises final dataset by activity and subject using summarise_each command from dplyr package and exports it to a file "tidy_data.txt". 

