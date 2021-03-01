# Representative value
dat <- BJsales

# 標本期待値
sample_mean <- sum(dat)/length(dat)
# 標本分散
sample_variance <- sum((dat-sample_mean)^2)/length(dat)
# 標本自己共分散
get_autocov_k <- function(x,k){
  if(k+1>length(x)){
    print('Please input k : k +1 < length(x)')
  }else{
    sm <- sum(x)/length(x)
    sample_autocovariance <- sum((x[1:(length(x)-k)]-sm)*(x[(k+1):length(x)]-sm)/(length(x)-k))
    return(sample_autocovariance)
  }
}
## 標本1次自己分散
autocovariance_1 <- get_autocov_k(dat,1)
## 標本2次自己分散
autocovariance_2 <- get_autocov_k(dat,2)

# 標本自己相関
autocorrelation_coefficient_1 <- autocovariance_1/sample_variance
autocorrelation_coefficient_2 <- autocovariance_2/sample_variance

# コレログラム
acc <- c()
for(i in 1:20){
  acc <- append(acc,get_autocov_k(dat,i)/sample_variance)
}
barplot(acc)

