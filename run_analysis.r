root <- "UCI HAR Dataset"

# move into the directory
file <- file.path(root, "features.txt")
column.names <- read.table(file) # the file

# i am also getting rid of the numbers by integrating
# them into the names
column.names <- with(column.names, paste(V1, V2))

# adding names for subject and activity
# i am also adding a new column to track
# the source of each row from the original
# datasets
column.names <- c("subject", "activity", as.character(column.names), "source")

## loading the test subjects
file <- file.path(root, "train/subject_train.txt")
subjects <- read.table(file)

## activities
file <- file.path(root, "train/y_train.txt")
activities <- read.table(file)

## data
# loading this data may be tricky, the file loads better
# with read.table. check if the number of obs fits the
# remaing variables (7352 obs x 561 vars)
file <- file.path(root, "train/X_train.txt")
data <- read.table(file)

head(subjects)
head(activities)
head(data)

# data.frame itself the handle multiple inputs,
# there is no need for rbind/cbind now
# factor() populates the last column: source
dataset <- data.frame(subjects, activities, data, factor("train"))

# put columns.names on it
names(dataset) <- column.names

head(dataset)

## loading the test subjects
file <- file.path(root, "test/subject_test.txt")
subjects <- read.table(file)

## activities
file <- file.path(root, "test/y_test.txt")
activities <- read.table(file)

## data
# loading this data may be tricky, the file loads better
# with read.table. check if the number of obs fits the
# remaing variables (2947 obs x 561 vars)
file <- file.path(root, "test/X_test.txt")
data <- read.table(file)

head(subjects)
head(activities)
head(data)

# a second dataset, with more data
dataset2 <- data.frame(subjects, activities, data, factor("test"))

# same strucutre as before
names(dataset2) <- column.names

head(dataset2)

# since they are same sized and
# with same column names
# rbind() behaves well
data <- rbind(dataset, dataset2)

# the following code clears the memory from duplications.
# it is disabled by default

#rm(activities, dataset, dataset2, subjects, tmp)

# save data
#save(data, file = "week4.project.csv")
write.table(data, file = "week4.project.txt", row.names = FALSE)

# the following regex selects only the required columns.
# the \\ are scape characters for ()
target <- grep("mean\\(\\)|std\\(\\)", column.names)

# i will also keep the first two

target <- c(1:2, target)

# with this I can easy restrict the data
selected <- data[, target]

# load the data from file
file <- file.path(root, "activity_labels.txt")
labels <- read.table(file)

# do the substitution using a anonymous function
selected$activity <- (with(data, sapply(activity,
function(item) {labels$V2[item]})
))

selected$activity <- factor(selected$activity)

## pattern 1
# check names
names(selected)

# i am using perl like regex. scapes need to be double scaped
# grouping is per parenthesis
regex <- "([0-9]+ )(t|f)([A-Za-z]+)\\-(mean|std)\\(\\)\\-(X|Y|Z)"
#groups:  1       2     3             4           -       5

# check regex
grep(regex, names(selected))

#change names
names(selected) <- gsub(regex,"\\2.\\5.\\4.\\3", names(selected))

## pattern 2
names(selected)
regex <- "([0-9]+ )(t|f)([A-Za-z]+)\\-(mean|std)\\(\\)"
# groups  1         2   3               4
grep(regex, names(selected))
names(selected) <- gsub(regex,"\\2.\\4.\\3", names(selected))

# all lower case
names(selected) <- tolower(names(selected))

# ```{r}
# to ensure a good behaviour
selected$subject <- factor(selected$subject)

factor(selected$subject)

# create a table of averages
averages <- aggregate(selected, list(selected$subject, selected$activity), mean)

# rename and remove some columns
averages$subject <- averages$Group.1
averages$activity <- averages$Group.2
averages <- averages[, 3:70]

# save data
#save(averages, file = "averages.R")
write.table(averages, file = "averages.txt", row.names = FALSE)