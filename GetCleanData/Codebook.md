# Human Activity Recognition Using Smartphones Data Set - Tidy Data Set Codebook
##### author: A. Thoens
##### date: 16 October 2016

### Source
The original raw data represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site:
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

### Data Set Information
The data set represents the average of mean and standard deviation for each measurement for each activity and each test subject. It consists of 4 variables with 11880 observations each. 

### Variables
| variable name | format     | description |
|-----------|------------|-------------------------------|
| testsubject   | integer <br> in range from 1 to 30 | an identifier of the subject who carried out the experiment |
| activity      | factor <br> 6 levels: <br> WALKING <br> WALKING_UPSTAIRS <br> WALKING_DOWNSTAIRS <br> SITTING <br>  STANDING <br> LAYING | performed activity name  |
| feature       | character | name of a varible used in the data set   |
| value         | numeric   | value of a featureed varible   |

### Obtaining a tidy data set
The following manupilations on the original raw data set were performed:

* The training and the test sets were merged to create one data set.
* The activity labels were substituted by descriptive activity names (`factor` class) to name the activities in the data set.
* List of all features from `features.txt` file was used to appropriately label the data set with descriptive variable names.
* Only the measurements on the mean and standard deviation for each measurement were extracted. _Note_: the choise of mean values is limited by mean values of the measured variables excluding averaged signals in `angle()` variable and a mean frequency `meanFreq()`.
* From the data set of the mean and standard deviation an independent data set was created with the average of each variable for each activity and each subject (30x6 entries for each variable).
* The later data set was melted into a tidy tall data set of 4 variables. This is the long form as mentioned in the rubric as either long or wide form is acceptable

### Feature Selection
In the following the details on the features names from the original data set are presented.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals `tAcc-XYZ` and `tGyro-XYZ`. These time domain signals (prefix *t* to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (`tBodyAcc-XYZ` and `tGravityAcc-XYZ`) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (`tBodyAccJerk-XYZ` and `tBodyGyroJerk-XYZ`). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (`tBodyAccMag`, `tGravityAccMag`, `tBodyAccJerkMag`, `tBodyGyroMag`, `tBodyGyroJerkMag`). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing `fBodyAcc-XYZ`, `fBodyAccJerk-XYZ`, `fBodyGyro-XYZ`, `fBodyAccJerkMag`, `fBodyGyroMag`, `fBodyGyroJerkMag`. (Note the *f* to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
`-XYZ` is used to denote 3-axial signals in the X, Y and Z directions.
```
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag
```
The set of variables that were estimated from these signals are: 

`mean()`: Mean value <br>
`std()`: Standard deviation <br>
`mad()`: Median absolute deviation <br>
`max()`: Largest value in array <br>
`min()`: Smallest value in array <br>
`sma()`: Signal magnitude area <br>
`energy()`: Energy measure. Sum of the squares divided by the number of values. <br>
`iqr()`: Interquartile range <br>
`entropy()`: Signal entropy <br>
`arCoeff()`: Autorregresion coefficients with Burg order equal to 4 <br>
`correlation()`: correlation coefficient between two signals <br>
`maxInds()`: index of the frequency component with largest magnitude <br>
`meanFreq()`: Weighted average of the frequency components to obtain a mean frequency <br>
`skewness()`: skewness of the frequency domain signal <br>
`kurtosis()`: kurtosis of the frequency domain signal <br>
`bandsEnergy()`: Energy of a frequency interval within the 64 bins of the FFT of each window. <br>
`angle()`: Angle between to vectors. 

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the `angle()` variable:
```
gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean
```

