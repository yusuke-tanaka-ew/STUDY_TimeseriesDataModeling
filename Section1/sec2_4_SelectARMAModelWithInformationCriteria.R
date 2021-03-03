# Use Nile dataset
# 0. Check autocoefficient & partical autocoefficient
# 1. List up ARMA(p,q) model
# 2. Culculate AIC,BIC & Pick up model
# 3. Check residual with Portomanteu test

# Library
#install.packages('forecast')
library(forecast)

# 0.1 Check autocoefficient
acf(Nile)

# 0.2 Check parti autocoefficient
acf(Nile,type = 'p')

# 0.3 About autocoefficient & partical coefficient
## 自己相関は減衰している様に見受けられる
## 偏自己相関は2次以降が0となっている様に見受けられる
### 無理やり見れば、自己相関は4次以降が0になっている様にも見える

# 1.0 List up ARMA(p,q) model
# 自己相関、偏自己相関を見る限り、AR(1)が最有力
# あえて、偏自己相関が減衰していると見て、MA(3)
# あえて自己相関、偏自己相関共に減衰していると見て、ARMA(1,1),ARMA(1,2),ARMA(2,1),ARMA(2,2)

# 1.1 AR(1)
ar_1 <- Arima(Nile,order = c(1,0,0))
# 1.2 MA(3)
ma_1 <- Arima(Nile,order = c(0,0,3))
# 1.3 ARMA(1,1)
arma_1_1 <- Arima(Nile,order = c(1,0,1))
# 1.4 ARMA(1,2)
arma_1_2 <- Arima(Nile,order = c(1,0,2))
# 1.5 ARMA(2,1)
arma_2_1 <- Arima(Nile,order = c(2,0,1))
# 1.6 ARMA(2,2)
arma_2_2 <- Arima(Nile,order = c(2,0,2))

# 2.0 SUMMARY of model with AIC/BIC
result <- data.frame(
  mod_name = c('AR(1)','MA(3)','ARMA(1,1)','ARMA(1,2)','ARMA(2,1)','ARMA(2,2)'),
  AIC = c(ar_1$aicc,ma_1$aicc,arma_1_1$aicc,arma_1_2$aicc,arma_2_1$aicc,arma_2_2$aicc),
  BIC = c(ar_1$bic,ma_1$bic,arma_1_1$bic,arma_1_2$bic,arma_2_1$bic,arma_2_2$bic)
)

result
# 2.1 About information criteria(AIC,BIC)
## With AIC, ARMA(1,1) is best model
## With BIC AR(1) is best model

# 3.0 Check residuals with Portmanteu test
# AR(1)
acf(ar_1$residuals)
acf(ar_1$residuals,type = 'p')
Box.test(ar_1$residuals)
# ARMA(1,1)
acf(arma_1_1$residuals)
acf(arma_1_1$residuals,type = 'p')
Box.test(arma_1_1$residuals)

# 3.1 About Portmanteu test of residual
# AR(1),ARMA(1,1) models are not rejected.

