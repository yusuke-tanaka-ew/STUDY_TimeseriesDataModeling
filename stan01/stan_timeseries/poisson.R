# LIBRARY
library(rstan)

# MAKE DATA
set.seed(456)
n_sample <- 100
AR_sm <- list(order = c(1, 0, 0), ar = 0.1)
AR_sm <- arima.sim(n = n_sample, model = AR_sm, sd = 0.1)
P_sm <- 1/(1+exp(-AR_sm))
N_sm <- sample(25:50,n_sample,replace = TRUE)
lambda_sm <- N_sm*P_sm
Y_sm <- rpois(n_sample,lambda_sm)

# USE STAN : BASE MODEL
dat <- list(
  n_sample = n_sample,
  Y = Y_sm,
  N = N_sm
)
res <- function(){
  fit <- stan(file='./poisson.stan',data=dat)
  return(fit)
}

ft <- res()

# PLOT
plot(P_sm)
abline(a=summary(ft)$summary[1,1],b=0)



