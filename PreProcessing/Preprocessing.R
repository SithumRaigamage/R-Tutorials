# Age vector
age <- c(25, 35, 50)

# Salary vector
salary <- c(200000, 1200000, 2000000)

# Data frame created using age and salary
df <- data.frame( "Age" = age, "Salary" = salary, stringsAsFactors = FALSE)
df

#This is equivalent to the following custom (by us!) R function

normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

dfNorm <- as.data.frame(lapply(df, normalize))
# One could also use sequence such as df[1:2]
dfNorm <- as.data.frame(lapply(df[1:2], normalize))
dfNorm

# Note df[2]
dfNorm <- as.data.frame(lapply(df[2], normalize))
#  or  df["Salary"]
dfNorm <- as.data.frame(lapply(df["Salary"], normalize))
#If we wish to use the full normalization formula, then we need to create an additional function

new_normalize <- function(x, new_max=1,new_min=0)  # see how we define the max & min values
{
  a= (((x-min(x))* (new_max-new_min))/(max(x)-min(x)))+new_min
  return(a)
}
dfNorm1 <- as.data.frame(lapply(df[1:2], new_normalize))
dfNorm1

#Z-Score Standardization

dfNormZ <- as.data.frame( scale(df[1:2] ))
dfNormZ

#The scale function performs the z_score. If we wish to create our own z-score function, we can do it easily.

z_score = function(x) {
  return((x - mean(x)) / sd(x))
}
dfNorm4 <- as.data.frame(lapply(df, z_score))
dfNorm4


