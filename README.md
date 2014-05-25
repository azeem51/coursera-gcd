## Obtaining the tidy data set procedure

Please read CodeBook.md to understand what is present in the tidy data
file and the URL for obtaining the original data sources. The
procedure for obtaining the tidy data set coded in run_analysis.R is
described below.

* We download the original data set from
  http://archive.ics.uci.edu/ml/machine-learning-databases/00240/ and
  unzip the data sets folder and switch to the unzipped folder.

* We first read in all the separate data sources into data frames

* Next we combine these data sources into a single data frame. We do
  that by concatenating the test data set to the training data
  set. For each of the training/test data sets, we first combine the
  observations with the subject and the activity value. (There are a
  total of 563 columns with more than 10000 rows)

* From the features.txt file which lists all the variables of the data
  we label the columns after a quick cleaning of the variables. In
  addition, we label the subject and activity columns with a hardcoded
  statement.

* From the entire list of variables we identify those variables which
  represent the mean or std (standard deviation) of an observation.

* We subset the columns of these identified variables from the
  complete data set (there are 79 of them), plus the subject and
  activity (for a total of 81 columns).

* Next in order to obtain the mean values of the variables when
  grouped by subject and activity we use a data.table's easier
  manipulation capabilities

* Finally, the resulting data table is written to a text file.

