library(FFTrees)
library(splitstackshape)
library(DMwR)
library(caret)

set.seed(12)

df <- read.csv("/Users/abhinandandeshpande/PycharmProjects/FSSproject/output.csv")
df <- data.frame(df)

df <- df[sample(nrow(df), 0.5 * nrow(df), replace = FALSE, prob = NULL),]
df$reopened <- as.factor(df$reopened)
#df <- SMOTE(reopened ~ ., k=10, df, perc.over = 1300, perc.under=100, learner=NULL)

x <- unique(df$version)
y <- list()
for(a in x){
  test <- df[df$version == a, c("product", "severity", "priority", "op_sys", "component","day", "time", "reopened")]
  train <- df[df$version != a, c("product", "severity", "priority", "op_sys", "component","day", "time", "reopened")]
  train <- SMOTE(reopened ~ ., k=10, train, perc.over = 1300, perc.under=100, learner=NULL)
  
  
  train$reopened <- ifelse(train$reopened==1,TRUE,FALSE)
  test$reopened <- ifelse(test$reopened==1,TRUE,FALSE)
  
  bugs.fft <- FFTrees(algorithm = 'max' ,
                      formula = reopened~.,
                      goal='acc' ,
                      goal.chase='sens' ,
                      data = train, data.test=test,
                      main = "Bug Re-Open Analysis", 
                      decision.labels = c("Opened", "Not Opened"),
                      do.comp=FALSE, max.levels = 6)
  
  append(y,bugs.fft)
  plot(bugs.fft, data = "test")
  plot(bugs.fft, data = "train")
}
