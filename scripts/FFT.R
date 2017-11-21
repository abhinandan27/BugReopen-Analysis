library(FFTrees)
library(splitstackshape)

data <- read.csv("/Users/abhinandandeshpande/PycharmProjects/FSSproject/output.csv")
df <- data.frame(data)
df <- subset(df, select = c("product", "severity", "priority", "op_sys","time","reopened") )

train <- stratified(df, c('time'), 0.25)

start <- Sys.time();

bugs.fft <- FFTrees(formula = reopened~., data = train, train.p = 0.8, main = "Bug Re-Open Analysis", decision.labels = c("Not Opened", "Opened"), do.comp = FALSE)

end <- Sys.time()

summary(bugs.fft)
plot(bugs.fft, tree=1)
plot(bugs.fft, tree=2)
plot(bugs.fft, tree=3)
plot(bugs.fft, tree=4)
plot(bugs.fft, tree=5)
plot(bugs.fft, tree=6)
plot(bugs.fft, tree=7)
print(end-start)
