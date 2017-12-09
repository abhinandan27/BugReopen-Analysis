library(randomForest)
library(caret)
library(splitstackshape)
library(DMwR)

set.seed(12)

df <- read.csv("/Users/abhinandandeshpande/PycharmProjects/FSSproject/output.csv")

df <- data.frame(df)

df <- df[sample(nrow(df), 0.5 * nrow(df), replace = FALSE, prob = NULL),]

df$reopened <- as.factor(df$reopened)
x <- unique(df$version)

y <- list()
for(a in x){
  if(!a == 'o'){
  test <- df[df$version == a, c("product",  "priority", "time", "reopened")]
  train <- df[df$version != a, c("product", "priority", "time", "reopened")]
  
  train <- SMOTE(reopened ~ ., k=10, train, perc.over = 1300, perc.under=100, learner=NULL)
  
  train$reopened <- ifelse(train$reopened==1,TRUE,FALSE)
  test$reopened <- ifelse(test$reopened==1,TRUE,FALSE)
  
  
  n <- names(train)
  f <- as.formula(paste("as.factor(reopened) ~", 
                  paste(n[!n %in% "reopened"], 
                  collapse = " + ")))

  bugs.rf <- randomForest(f, data = train)
  predict <- predict(bugs.rf, test)
  
  
  
  confMat <- confusionMatrix(predict, test$reopened)
  print(confMat)
  print(bugs.rf)
  }
}