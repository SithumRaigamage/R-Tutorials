wine<-read.csv("~/Git hub projects/ML R Tutorials/winedata.csv")  # use your own folder 
head(wine)
str(wine)

# create a vector
v <- 1:178  # as we have 178 samples
# Randomize the order of the vector
v <- sample(v)
# Randomize the order of the data frame. Guess why we randomize the dataset!
wine_random <- wine[sample(1:nrow(wine)), ]

head(wine_random)
#Let's see the structure of wine data set
str(wine_random)
#detailed view of the data set
summary(wine_random)

normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}
norm_wine <- as.data.frame(lapply(wine_random[1:14], normalize))  # normalize every variable column, included the 1st column that contains the desired class-output

summary(norm_wine)
summary(norm_wine$Alcohol)

#Training and Test Data    (all normalised)
trainset <- norm_wine[1:100, ]
testset <- norm_wine[101:178, ]

library(neuralnet)

nn <- neuralnet(Type ~ Alcohol + Malic + Ash + Alcalinity + Magnesium + Phenols + Flavanoids + Nonflavanoids + Proanthocyanins + Color + Hue + Dilution + Proline, 
                data=trainset, hidden=c(8,4), linear.output=FALSE)

nn$result.matrix

plot(nn)

#Testing the Accuracy of the Model/Classifier

temp_test <- subset(testset, select=c("Alcohol", "Malic", "Ash", "Alcalinity", "Magnesium", "Phenols", "Flavanoids", "Nonflavanoids", "Proanthocyanins", "Color", "Hue", "Dilution", "Proline"))

# we have removed the column which is related to the desired output

head(temp_test)

# now we create our predicted results from our trained model

model_results <- compute(nn, temp_test)
predicted_type <- model_results$net.result

# this predicted_type is the NN output, however it is normalized , so we apply again the de-normalisation procedure

wine_train_original_Type <- wine_random[1:100,"Type"]  # this is the desired output of the training dataset

wine_test_original_Type <- wine_random[101:178,"Type"]  # this is the desired output of the testing dataset

# and find its maximum & minimum value

Type_min <- min(wine_train_original_Type)
Type_max <- max(wine_train_original_Type)

unnormalize <- function(x, min, max) { 
  return( (max - min)*x + min )
}

type_pred <- unnormalize(predicted_type, Type_min, Type_max)
type_pred   # this is NN's output denormalized to original ranges

round_pred<-sapply(type_pred,round,digits=0)  # check the usage of round function

final_result <- cbind(wine_test_original_Type, round_pred)
final_result

#and finally our confusion matrix
table(wine_test_original_Type, round_pred)

library(caret)
desired <-as.factor(wine_test_original_Type)   #check why we convert them as factor types
predicted <-as.factor(round_pred)
confusionMatrix(desired, predicted)


library(dplyr)             #install first the package before calling it via the library command
tm_series <- c(1:15)  # a time series with 15 data as an example
str(tm_series)
# see here how we can create 4 columns in this I/O matrix. Check the time-delayed variables!
time_lagged_data <- bind_cols(G_previous2 = lag(tm_series,3),
                              G_previous = lag(tm_series,2),
                              G_current = lag(tm_series,1),
                              G_pred = tm_series)          
# see here the existence of NA values due to that shifting
time_lagged_data 
# see here the use of complete.cases function to remove those rows with NA
time_lagged_data <- time_lagged_data[complete.cases(time_lagged_data),]
# see this time-delayed I/O configuration from these rows
head (time_lagged_data)

str(time_lagged_data)
# see here the length of this I/O matrix. It is l-m (i.e. m: number of input variables)
time_lagged_data
time_lagged_data$G_previous

