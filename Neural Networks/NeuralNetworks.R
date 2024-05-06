library(neuralnet)  

#enerate 50 random numbers uniformly distributed between 0 and 100, and store them as a dataframe

traininginput <-  as.data.frame(runif(50, min=0, max=100))
#create desired output
trainingoutput <- sqrt(traininginput) 

#training dataset
trainingdata <- cbind(traininginput,trainingoutput)            
colnames(trainingdata) <- c("Input","Output")

#Here is the neural network code/training for this problem
net.sqrt <- neuralnet(Output ~ Input, data = trainingdata, hidden = 6, act.fct = 'logistic', err.fct = 'sse', linear.output = T)
# look at the parameters inside the above code
net.sqrt

#Plot the neural network
plot(net.sqrt)

testdata <- as.data.frame((1:10)^2) #Generate some squared numbers (i.e. testing dataset)
net.results <- compute(net.sqrt, testdata) #Run them through the neural network

#lets create the related desired output
testdata.result <- sqrt(testdata)
testdata.result
final_results <- cbind(testdata.result, net.results$net.result)
colnames(final_results) <- c("test", "NN_Result")
final_results

#  there are various packages the offer these metrics
library(MLmetrics)                    
RMSE(final_results$test, final_results$NN_Result)

library(Metrics)
rmse(final_results$test, final_results$NN_Result)

cleanoutput <- cbind(testdata,sqrt(testdata), net.results$net.result)
colnames(cleanoutput) <- c("Input","Expected Output","Neural Net Output")

cleanoutput