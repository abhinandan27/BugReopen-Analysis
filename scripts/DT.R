
library(randomForest)
library(caret)
library(splitstackshape)
library(DMwR)
library(rpart)
library(party)

set.seed(12)

df <- read.csv("/Users/abhinandandeshpande/PycharmProjects/FSSproject/output.csv")

df <- data.frame(df)

df <- df[sample(nrow(df), 0.5 * nrow(df), replace = FALSE, prob = NULL),]

df$reopened <- as.factor(df$reopened)
x <- unique(df$version)

y <- list()
for(a in x){
  if(!a == 'o'){
  test <- df[df$version == a, c("product", "severity", "priority", "op_sys","day", "time", "reopened")]
  train <- df[df$version != a, c("product", "severity", "priority", "op_sys","day", "time", "reopened")]
  
  train <- SMOTE(reopened ~ ., k=10, train, 
                 perc.over = 1300, 
                 perc.under=100)
  
  fit <- ctree(formula = reopened ~ product+
                 severity+priority+
                 op_sys+day+time, 
               data = train)
  dt_pred <- predict(fit, test)
  
  
  
  dt_pred <- ifelse(dt_pred >= 0.5, 1, 0)
  dt_pred = as.logical(dt_pred)
  confMat <- confusionMatrix(dt_pred, test$reopened)
  print(confMat)
  print(head(dt_pred))
  }
}