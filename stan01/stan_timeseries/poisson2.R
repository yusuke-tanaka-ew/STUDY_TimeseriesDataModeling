library(rstan)

res2 <- function(){
  fit <- stan(file='./poisson2.stan',data=dat)
  return(fit)
}

ft2 <- res2()

# PLOT
plot(P_sm)
abline(a=summary(ft)$summary[1,1],b=0)