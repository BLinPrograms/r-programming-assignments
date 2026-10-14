
# LIS4370 - Assignment #8
# Input/Output, String Manipulation, and the plyr Package
# Benedict Lin
# 10/14/2026

# Step 1: Import Assignment 6 Data ----
student6 <- read.table(file.choose(), header = TRUE, sep = ",",stringsAsFactors = FALSE)

# Calculate the mean of Grade by Sex
# install.packages("plyr")
library(plyr)

gender_mean <- ddply(
  student6,
  "Sex",
  summarise,
  GradeAverage = mean(Grade, na.rm = TRUE)
)

# Display the results
print(gender_mean)

# Write the results to a text file
write.table(
  gender_mean,
  file = "gender_mean.txt",
  sep = "\t",
  row.names = FALSE
)

# Step 2: Filter Names Containing “i” ----
i_students <- subset(
  student6,
  grepl("i", Name, ignore.case = TRUE)
)

# Display the filtered dataset
print(i_students)

# Write the names to a CSV file
write.csv(
  i_students$Name,
  file = "i_students.csv",
  row.names = FALSE,
  quote = FALSE
)

# Step 4: Export Filtered Dataset ----
write.csv(
  i_students,
  file = "i_students_full.csv",
  row.names = FALSE
)

# Confirm the files
getwd()

file.exists("gender_mean.txt")
file.exists("i_students.csv")
file.exists("i_students_full.csv")


