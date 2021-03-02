# Library
library(rlist)

# Use nile data

# AR(1) with rdinary least squares
# AR(1) Model
# y_t = c + phi*y_{t-1} + error_term
get_param_ar_1 <- function(x,initial_value){
  x_add_iv <- append(initial_value,x)[1:length(x)]
  sm_t <- sum(x)/length(x)
  sm_t_m1 <- sum(x_add_iv)/length(x)
  phi <- sum((x-sm_t)*(x_add_iv-sm_t_m1))/sum((x-sm_t_m1)^2)
  c <- sm_t - phi*sm_t_m1
  estimated_y <- c+phi*x_add_iv
  return(list(c=c,phi=phi,estimated_y=estimated_y))
}


# Case1. Use Nile[1] as initial value
res_case1 <- get_param_ar_1(Nile,Nile[1])
plot(as.ts(res_case1$estimated_y),lty=2)
par(new=T)
plot(Nile,lty=1)

# Case2. Use 0 as initial value
res_case2 <- get_param_ar_1(Nile,0)
plot(as.ts(res_case2$estimated_y),lty=2)
par(new=T)
plot(Nile,lty=1)

# Case3. Use sample mean as initial value
res_case3 <- get_param_ar_1(Nile,sum(Nile)/length(Nile))
plot(as.ts(res_case3$estimated_y),lty=2)
par(new=T)
plot(Nile,lty=1)

