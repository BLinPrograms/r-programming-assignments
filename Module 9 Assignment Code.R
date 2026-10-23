# LIS4370 - Assignment #9
# Input/Output, String Manipulation, and the plyr Package
# Benedict Lin
# 10/22/2026

# Load libraries ----
library(lattice)
library(ggplot2)

# Import Data set ----
# Data set: insurance Data	"dataOhlsson"	Motorcycle Insurance	64548	9	1	0	1	0	8
dataOhlsson <- read.csv("dataOhlsson.csv")

# Inspect the data
head(dataOhlsson)
str(dataOhlsson)
summary(dataOhlsson)

# Convert grouping variables to factors
dataOhlsson$bonuskl <- factor(dataOhlsson$bonuskl)
dataOhlsson$kon <- factor(dataOhlsson$kon)

# Create a dataset containing policies with positive claim costs
claims <- subset(dataOhlsson, skadkost > 0)

# Step 1: Base R Graphics ----
# Histogram of the number of claims
png("base_claims_histogram.png", width = 800, height = 600)

hist(dataOhlsson$antskad,
     main = "Base R: Distribution of Insurance Claims",
     xlab = "Number of Claims",
     ylab = "Number of Policies",
     col = "lightblue",
     border = "white",
     breaks = seq(-0.5, max(dataOhlsson$antskad) + 0.5, by = 1))

dev.off()

# Box plot of claims by bonus class
png("base_bonus_boxplot.png", width = 800, height = 600)

boxplot(antskad ~ bonuskl,
        data = dataOhlsson,
        main = "Base R: Claims by Bonus Class",
        xlab = "Bonus Class",
        ylab = "Number of Claims",
        col = "lightblue")

dev.off()

# Step 2: Lattice Graphics ----
# Compare claims by age and gender
png("lattice_age_gender.png", width = 900, height = 600)

print(
  xyplot(antskad ~ agarald | kon,
         data = dataOhlsson,
         main = "Lattice: Claims by Age and Gender",
         xlab = "Age",
         ylab = "Number of Claims",
         layout = c(2, 1),
         pch = 16,
         cex = 0.5)
)

dev.off()

# Compare claim counts across bonus classes
png("lattice_bonus_boxplot.png", width = 800, height = 600)

print(
  bwplot(antskad ~ bonuskl,
         data = dataOhlsson,
         main = "Lattice: Claims by Bonus Class",
         xlab = "Bonus Class",
         ylab = "Number of Claims")
)

dev.off()

# Step 3: ggplot2 ----
# Claim costs among policies with positive claim costs
ggplot(claims, aes(x = skadkost)) +
  geom_histogram(bins = 40,
                 fill = "steelblue",
                 color = "white") +
  scale_x_log10() +
  labs(title = "ggplot2: Distribution of Positive Claim Costs",
       subtitle = "Logarithmic scale for claim cost",
       x = "Claim Cost (log10 scale)",
       y = "Number of Observations") +
  theme_minimal()

ggsave("ggplot_claim_costs.png", width = 8, height = 6)

# Compare the number of claims across bonus classes
ggplot(dataOhlsson,
       aes(x = bonuskl, y = antskad)) +
  geom_boxplot(fill = "steelblue") +
  labs(title = "ggplot2: Claims by Bonus Class",
       x = "Bonus Class",
       y = "Number of Claims") +
  theme_minimal()

ggsave("ggplot_bonus_claims.png", width = 8, height = 6)

# Step 4: Check Results ----
# Number of observations and variables
dim(dataOhlsson)

# Number of policies with positive claim costs
sum(dataOhlsson$skadkost > 0, na.rm = TRUE)

# Average number of claims by bonus class
aggregate(antskad ~ bonuskl,
          data = dataOhlsson,
          FUN = mean)





