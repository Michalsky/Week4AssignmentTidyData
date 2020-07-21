# Week4AssignmentTidyData #

run_analysis.R is a R script that parses and processes the data set from samsung devices. 

Assuming the data is available in your current working directory the script do the following:

	1. Read in features file and activity label file.
	2. Read all available files from the test & train datasets (including Inertial Signals).
	3. Apply variable names (using the features file) to the test and train datasets.
	4. Map the activity and subjects to the quantitative variables measured (train and test datasets).
	5. Combine the train and test datasets.
	6. Extract only the measurements that are MEAN and STANDARD DEVIATION calculations.
	7. Apply meaningful names to all variables.
	8. Calculate the mean of each measurement per subject per activity.
	9. Write a table to the current wd called "processed_device_data.csv"