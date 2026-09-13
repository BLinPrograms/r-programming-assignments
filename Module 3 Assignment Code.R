# LIS4370 - Assignment #3
# Analyzing 2016 "Poll" Data
# Benedict Lin
# 9/13/2026

# Load ggplot2
library(ggplot2)

# Create vectors
Name <- c("Jeb", "Donald", "Ted", "Marco", "Carly", "Hillary", "Bernie")

ABC_poll <- c(4, 62, 51, 21, 2, 14, 15)
CBS_poll <- c(12, 75, 43, 19, 1, 21, 19)

# Create data frame
df_polls <- data.frame(Name, ABC_poll, CBS_poll)

# Inspect the data
str(df_polls)
head(df_polls)

# Summary statistics
mean(df_polls$ABC_poll)
median(df_polls$CBS_poll)
range(df_polls[, c("ABC_poll", "CBS_poll")])

# Calculate difference between CBS and ABC
df_polls$Diff <- df_polls$CBS_poll - df_polls$ABC_poll

# View updated data frame
df_polls

# Create bar chart
ggplot(df_polls, aes(x = Name, y = Diff)) + geom_col() + 
  labs(
    title = "Difference Between CBS and ABC Poll Results",
    x = "Candidate",
    y = "CBS Poll - ABC Poll"
  ) +
  theme_minimal()
