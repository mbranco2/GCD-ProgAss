GCD-ProgAss
===========

**Program Assignment for the Coursera course "Getting and Cleaning Data"**

This repo contains files for the program assignment of the Getting and
Cleaning Data course (from John Hopkins Blomberg School of Public Health).

The files requested for the assignment are:
* run_analysis.R , which produces the file tidy.txt required
* codebook.txt , which describes the contents of the file tidy.txt

The web page with the specifications of the assignments is at: 
   https://class.coursera.org/getdata-006/human_grading/index

For reproducibility purposes (in case the web page in future will not
be available), you can find:
* in the folder "specs" : the content of the web page above specified
* in the folder "data" : a .zip file with the input data for run_analysis.R
 
In the folder "docs" a zip file with several documentation I found on the
web about the arguments of this course (and general related to R): 
feel free to grab it, if you're interested.

# NOTES abour run_analysis.R 

##CONFIGURATION

The script was written with RStudio 0.98.977, on a Windows PC.
In order to be executed, it requires:
* the package "reshape2"
* the working directory in R must contain:
	+ the files features.txt and activity_labels.txt
	+ the subfolder "test", with the files X\_test.txt, Y\_test.txt, subject_test.txt
	+ the subfolder "train", with the files X\_train.txt, Y\_train.txt, subject_train.txt

Also, to work on non-windows machines, I suppose that for the filepaths "\\" must be
changed with "/".

## LOGIC
This picture is woth than 1000 words...  (Thanks to David Hood!)   :-)
![alt text](https://coursera-forum-screenshots.s3.amazonaws.com/ab/a2776024af11e4a69d5576f8bc8459/Slide2.png )

##OPERATION

The program does the following (in this order) :

1. read file features.txt (it contains the measure labels)
2. prepare column names (substituting parentheses with undercore) for the measures tables
3. read the two measures tables (X\_test.txt and X_train.txt), using column names prepared with step 2.
4. extract only measures which have 'mean' or 'std' in their column names
5. read activities codes (Y\_test.txt and Y_train.txt) related to the measures
6. read subjects (subject\_test.txt and subject_train.txt related to the measures
7. put Subject and Activity together with the measures
8. put together testing and training data
9. read activity labels (activity_labels.txt) and add them to the measures
10. compute the average for all columns (respect to the "heading" columns:
  SubjectID,ActivityID,Activity)
11. output the result in the file tidy.txt (in the current working directory)

You can easily look at the file tidy.txt with any ascii editor (NOT Notepad on Windows),
or (using R) with the statement: 
 `     yourvar <- read.table("tidy.txt", header=TRUE)`



>  This URL helped me a lot in doing this markdown file:
>   https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet  

