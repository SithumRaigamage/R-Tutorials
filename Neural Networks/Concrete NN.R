concrete <- read.csv("~/Git hub projects/ML R Tutorials/concrete.csv")  #use your own folder
str(concrete)

summary(concrete)      

# or you can check the summary of a specific variable, like the strength (which is our output variable). See below:
summary(concrete$strength)

library(ggplot2)
library(reshape2)
library(gridExtra)

normalize <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}
# later on we’ll apply the reverse of normalization to the network output

#Let’s apply to every column in the concrete data frame using the lapply() function and verify.

concrete_norm <- as.data.frame(lapply(concrete, normalize))
summary(concrete_norm)   
# Check the summary for all normalized variables vs the previous summary

summary(concrete_norm$strength)   # summary of a specific normalized variable - strength

#We will partition the data into a training set with the first 75% of the examples and a testing set with the remaining 25%.
concrete_train <- concrete_norm[1:773, ]
concrete_test <- concrete_norm[774:1030, ]

library(neuralnet)

## Loading required package: grid
## Loading required package: MASS
library(grid)
library(MASS)
        
concrete_model <- neuralnet(strength ~ cement + slag + ash + water + superplastic + coarseagg + fineagg + age, hidden = 12, data = concrete_train, linear.output=TRUE)

#Here we have one hidden layer with 12 neurons, and the output layer is linear. We can also have a nonlinear output as well. Check how many, in total, weights we have (incl. bias weights).
plot(concrete_model)

model_results <- compute(concrete_model, concrete_test[1:8])   #use only the testing input variables

# obtain predicted strength values
predicted_strength <- model_results$net.result     

#If we use the predict() function instead of conpute, then we have the alterative codes
#         model_results1 <- predict(concrete_model, concrete_test[1:8])
####   predicted_strength1 <- model_results1

# extract first of all, the original (not normalized) training and testing desired output (i.e. strength)
concrete_train_original_strength <- concrete[1:773,"strength"]  # the first 773 rows
concrete_test_original_strength <- concrete[774:1030,"strength"] # the remaining rows

# and find its maximum & minimum value
strength_min <- min(concrete_train_original_strength)
strength_max <- max(concrete_train_original_strength)

# display its contents
head(concrete_train_original_strength)

## [1] 29.89 23.51 29.22 45.85 18.29 21.86
#Create the reverse of normalised function – de-normalized

unnormalize <- function(x, min, max) { 
  return( (max - min)*x + min )
}
#Now lets us de-normalize the normalised NN’s output

strength_pred <- unnormalize(predicted_strength, strength_min, strength_max)
head(strength_pred)  # this is NN’s output denormalized to original ranges

#define RMSE function
rmse1 <- function(error)
{
  sqrt(mean(error^2))
}
error <- (concrete_test_original_strength - strength_pred)
pred_RMSE <- rmse1(error)  #customised function
pred_RMSE
# 11.8402

library(Metrics)   #built in function
rmse(concrete_test_original_strength, strength_pred)
#[1] 11.8402

library(MLmetrics) #built in function – different package
RMSE(concrete_test_original_strength, strength_pred)
#[1] 11.8402

par(mfrow=c(1,1))
plot(concrete_test_original_strength, strength_pred ,col='red',main='Real vs predicted NN',pch=18,cex=0.7)

abline(a=0, b=1, h=90, v=90)

x = 1:length(concrete_test_original_strength)
plot(x, concrete_test_original_strength, col = "red", type = "l", lwd=2,
     main = "concrete strength prediction")
lines(x, strength_pred, col = "blue", lwd=2)
legend("topright",  legend = c("original-strength", "predicted-strength"), 
       fill = c("red", "blue"), col = 2:3,  adj = c(0, 0.6))
grid() 

cleanoutput <- cbind(concrete_test_original_strength, strength_pred)
head(cleanoutput)






