# LIS4370 - Assignment #11
# Debugging and Defensive Programming in R
# Benedict Lin
# 11/04/2026


# Create and display the test matrix ----
set.seed(123)
test_mat <- matrix(rnorm(50), nrow = 10)
print(test_mat)

# Create a function to identify Tukey outliers ----
tukey.outlier <- function(x) {
  q <- quantile(x, probs = c(0.25, 0.75), na.rm = TRUE)
  iqr <- q[2] - q[1]
  lower <- q[1] - 1.5 * iqr
  upper <- q[2] + 1.5 * iqr
  
  return(x < lower | x > upper)
}

# Run the original function with the incorrect operator ----
tukey_multiple <- function(x) {
  outliers <- array(TRUE, dim = dim(x))
  for (j in 1:ncol(x)) {
    outliers[, j] <- outliers[, j] && tukey.outlier(x[, j])
  }
  
  outlier.vec <- vector("logical", length = nrow(x))
  for (i in 1:nrow(x)) {
    outlier.vec[i] <- all(outliers[i, ])
  }
  
  return(outlier.vec)
}

# Run the original function and display the error ----
cat("\nOriginal Function Error:\n")
tryCatch({
  tukey_multiple(test_mat)
}, error = function(e) {
  cat(conditionMessage(e), "\n")
})

# Replace && with & to compare every element ----
corrected_tukey <- function(x) {
  outliers <- array(TRUE, dim = dim(x))
  for (j in seq_len(ncol(x))) {
    outliers[, j] <- outliers[, j] & tukey.outlier(x[, j])
  }
  
  outlier.vec <- logical(nrow(x))
  for (i in seq_len(nrow(x))) {
    outlier.vec[i] <- all(outliers[i, ])
  }
  
  return(outlier.vec)
}

# Add checks to make sure the input is valid ----
defensive_tukey <- function(x) {
  if (!is.matrix(x)) {
    stop("Error: Input must be a matrix.")
  }
  
  if (!is.numeric(x)) {
    stop("Error: Matrix must contain numeric values.")
  }
  
  if (nrow(x) == 0 || ncol(x) == 0) {
    stop("Error: Matrix must contain at least one row and column.")
  }
  
  if (anyNA(x) || any(!is.finite(x))) {
    stop("Error: Matrix cannot contain missing or non-finite values.")
  }
  
  outliers <- array(TRUE, dim = dim(x))
  for (j in seq_len(ncol(x))) {
    outliers[, j] <- outliers[, j] & tukey.outlier(x[, j])
  }
  
  outlier.vec <- logical(nrow(x))
  for (i in seq_len(nrow(x))) {
    outlier.vec[i] <- all(outliers[i, ])
  }
  
  return(outlier.vec)
}

# Run the corrected function and check the results ----
cat("\nCorrected Function Results:\n")
corrected_results <- corrected_tukey(test_mat)
print(corrected_results)

cat("\nValidation Checks:\n")
cat("Is the result logical:", is.logical(corrected_results), "\n")
cat("Number of results:", length(corrected_results), "\n")
cat("Expected number of results:", nrow(test_mat), "\n")
cat("Correct output length:", length(corrected_results) == nrow(test_mat), "\n")

# Test the defensive checks with invalid input ----
cat("\nDefensive Function Results:\n")
defensive_results <- defensive_tukey(test_mat)

print(defensive_results)
cat("\nTesting Invalid Input:\n")

tryCatch({
  defensive_tukey("not a matrix")
}, error = function(e) {
  cat(conditionMessage(e), "\n")
})

# Compare the original and corrected results ----
cat("\nOriginal Function:\n")
tryCatch({
  print(tukey_multiple(test_mat))
}, error = function(e) {
  cat("Original function failed as expected.\n")
})
cat("\nCorrected Function:\n")
print(corrected_results)
cat("\nAssignment #11 completed successfully.\n")
