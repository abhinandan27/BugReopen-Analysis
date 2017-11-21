library(rpart)
library(caret)
library(splitstackshape)

set.seed(10)

data <- read.csv("/Users/abhinandandeshpande/PycharmProjects/FSSproject/output.csv")
df <- data.frame(data)
df <- subset(df, select = c("product", "severity", "priority", "op_sys","time","reopened") )

sample <- sample.int(n = nrow(df), size = floor(.80*nrow(df)), replace = F)
#train <- df[sample, ]
train <- stratified(df, c("time"), 0.6)
test  <- df[-sample, ]
#test <- stratified(df, c('reopened',"time"), 0.30)

start <- Sys.time();

bugs.dt <- rpart(formula = reopened~., data = train, method = "class")
dt_pred <- predict(bugs.dt, test, type="class")

end <- Sys.time()

confMat <- confusionMatrix(dt_pred, test$reopened)
print(confMat)
print(end-start)
