## How Script Works

First we read all the six datasets - subject_train.txt, subject_test.txt, x_train.txt, 
x_test.txt, y_train.txt and y_test.txt and load the data in respective varaibles (mentioned in codebook.md) 
for processing.

We then combine the Subject datasets, activity datasets (y_train & y_test) and features dataset (x_train &x_test).
Then we re-name the columns of subject and activity.
We read the column names for features from features.txt and name the columns accordingly.

We then prepare the final data set by combining the subject, activity and features data set.

Then based on the column names we filter out the mean and std diviation columns and trim the final data.

Then we replace the activity number by activity code by factoring the activities read from activity_labels.txt.

Then we change some of the column names to make it more descriptive. The following replacement were made.
t - time
f - freaquency
Acc - Acclerometer
Gyro - Gyroscope
Mag - Magnitude
BodyBody - Body

Finally we create a tidy data set by with the average of each varible for each subject-activity combination.
