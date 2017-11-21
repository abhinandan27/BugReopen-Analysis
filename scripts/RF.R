library(randomForest)
library(caret)
library(splitstackshape)

set.seed(1)

data <- read.csv("/data/data.csv")
df <- data.frame(data)
df <- subset(df, select = c("product","severity", "priority","op_sys","time" ,"reopened") )

sample <- sample.int(n = nrow(df), size = floor(.80*nrow(df)), replace = F)
#train <- df[sample, ]
trainData <- stratified(df, c("time"), 0.2)
test  <- df[-sample, ]
#test <- stratified(df, c('reopened',"time"), 0.30)

start <- Sys.time();

n <- names(df)
f <- as.formula(paste("as.factor(reopened) ~", paste(n[!n %in% "reopened"], collapse = " + ")))

bugs.rf <- randomForest(f, data = trainData, importance = FALSE, proximity = FALSE)
summary(bugs.rf)
rf_pred <- predict(bugs.rf, test)

end <- Sys.time()

confMat <- confusionMatrix(rf_pred, test$reopened)
print(confMat)
print(end-start)
