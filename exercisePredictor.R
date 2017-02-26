#This script takes weightlifting excercises data and predicts the correctness of the corresponding exercise
#Mackenzie Wildman
#2/26/2017

library(caret)
library(Hmisc) #for qplot()
library(nnet) #for multinom()

#load data, convert #DIV/0 to NA values
data = read.csv("~/pml-training.csv", na.strings=c('#DIV/0!','','NA'))
inTrain <- createDataPartition(y=data$classe, p=0.8, list=FALSE)
training <- data[inTrain,]
testing <- data[-inTrain,]

validationData = read.csv("~/pml-testing.csv", na.strings=c('#DIV/0!','','NA'))

#data cleaning#####################################################################################################
#remove variables with significant number of NA values
trainingClean <- training[,colSums(is.na(training[,]))<0.5*dim(training)[1]]

#model##################################################################################################

#first step: partition data by user
#next: perform linear regression on each
partData <- as.list(rep(NA,length(names(table(trainingClean$user_name)))))
names(partData) <- names(table(trainingClean$user_name))
masterModel <- as.list(rep(NA,length(names(partData))))
names(masterModel) <- names(partData)
accuracies <- rep(0,length(names(partData)))
names(accuracies) <- names(partData)
for(name in names(partData)){
  #partition data by user_name
  partData[[name]] <- trainingClean[trainingClean$user_name==name,]
  masterModel[[name]] <- multinom(as.factor(classe) ~ . -X -cvtd_timestamp -raw_timestamp_part_1 
                               -raw_timestamp_part_2 -new_window, 
                               method="glm", data=partData[[name]], preProc="pca")
  accuracies[name] <- confusionMatrix(partData[[name]]$classe,predict(masterModel[[name]],partData[[name]]))$overall[1]
}

#test on testing data set################################################################################################

#take only columns that are included in trainingClean data set
testingClean <- testing[,colnames(testing) %in% names(trainingClean)]

#make list of predictions
pred <- factor(rep(1, dim(testingClean)[1]), levels=c("A","B","C","D","E"))
for(i in 1:(dim(testingClean)[1])){
  name <- testingClean$user_name[i]
  pred[i] <- predict(masterModel[[name]],testingClean[i,])
}

#confusionMatrix on testing data
confusionMatrix(testingClean$classe,pred)