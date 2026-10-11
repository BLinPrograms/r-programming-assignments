# LIS4370 - Assignment #7
# Exploring R’s Object-Oriented Systems (S3 &amp; S4)
# Benedict Lin
# 10/10/2026

# Data ----
data("mtcars")

head(mtcars)
str(mtcars)

print(mtcars)
summary(mtcars)

# Explore S3 vs. S4 ----
# S3
s3_obj <- list(name = "Myself", age = 29, GPA = 3.5)
class(s3_obj) <- "student_s3"

# Define S3 print method
print.student_s3 <- function(x, ...) {
  cat("S3 Student Object\n")
  cat("Name:", x$name, "\n")
  cat("Age:", x$age, "\n")
  cat("GPA:", x$GPA, "\n")
  invisible(x)
}

# Test S3
print(s3_obj)
class(s3_obj)
typeof(s3_obj)
isS4(s3_obj)

# S4
setClass("student_s4",
         slots = c(name = "character", age = "numeric", GPA = "numeric"))
s4_obj <- new("student_s4", name = "Myself", age = 29, GPA = 3.5)

# Define S4 display method
setMethod("show", "student_s4", function(object) {
            cat("S4 Student Object\n")
            cat("Name:", object@name, "\n")
            cat("Age:", object@age, "\n")
            cat("GPA:", object@GPA, "\n")
          })

# Test S4
show(s4_obj)
class(s4_obj)
typeof(s4_obj)
isS4(s4_obj)

# Inspect S4 class
getClass("student_s4")
slotNames(s4_obj)
