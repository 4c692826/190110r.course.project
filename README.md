# Peer-graded Assignment: Getting and Cleaning Data Course Project
hello there!
The following assingment contains the following files:

* codebook.rmd:

  a detailed description on how the procedures are applied to the raw data to convert it into tidy data. requires RStudio.
  it is also the recommended form of dealing with the data. the document is long.
  there are two outputs from it: week4.data.txt (the complete dataset) and averages.txt (only averaged dataset).

* averages.cvs:

  the final dataset with averaged values per subject and per activity (see item 5 in the assingment)

* codebook.html:

  same as codebook.rmd, but in html format for easy visualization withtou RStudio.

* week4.project.csv.zip:

  the final tidy dataset, with all variable and no conversions. compressed due to large size.

* run_analysis.r:

  the run version of codebook.rmd. it converts UCI HAR Dataset as long as they are in the same folder. prefer codebook.rmd.
  
* UCI HAR Dataset:
  
  the original dataset with rawdata. it is converted by run_analysis.

# about the variables

The variables were preserved from the raw data, so they are still normalized (non dimensional/without unit) [-1,1] interval data.

source of data:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# about the tidy data

the tidy data consists of the following:

* subject: the test subject for data collection. it is a factor with 30 levels.
* activity: the activity performed by the test subject. it is a factor with 6 levels.
* 561 columns of features from means, to standard deviation, entropy, max, min and etc. normalized as above.

There is a total of 10299 observations/rows for each subject-activity pair and 564 columns.
