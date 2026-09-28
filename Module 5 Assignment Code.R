# LIS4370 - Assignment #5
# Matrix Algebra in R
# Benedict Lin
# 9/28/2026

# Creating Matrices ----
A <- matrix(1:100, nrow = 10)
B <- matrix(1:1000, nrow = 10)

# Display Matrices
A
B

# Inspecting Dimensions ----
dim(A)  # should be 10 × 10
dim(B)  # 10 × 100 — not square

# Check whether matrices are square
nrow(A) == ncol(A)
nrow(B) == ncol(B)

# Compute Inverse & Determinant ----
# For A
invA <- tryCatch(solve(A), error = function(e) e)
detA <- tryCatch(det(A),   error = function(e) e)

# Display Results
invA
detA

# For B, use tryCatch to capture errors
invB <- tryCatch(solve(B), error = function(e) e)
detB <- tryCatch(det(B),   error = function(e) e)

# Display Results
invB
detB