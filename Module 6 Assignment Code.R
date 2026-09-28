# LIS4370 - Assignment #6
# Matrix Operations and Construction
# Benedict Lin
# 9/28/2026

# Creating Matrices ----
A <- matrix(c(2, 0, 1, 3), ncol = 2)
B <- matrix(c(5, 2, 4, -1), ncol = 2)

# Display Matrices
A + B
A - B

# Create a Diagonal Matrices ----
D <- diag(c(4, 1, 2, 3))

# Display Matrices
D

# Construct a Custom 5 × 5 Matrix ----
M <- matrix(c(
  3, 2, 2, 2, 2,
  1, 3, 0, 0, 0,
  1, 0, 3, 0, 0,
  1, 0, 0, 3, 0,
  1, 0, 0, 0, 3
), nrow = 5, byrow = FALSE)

# Display Results
M



