
data {
  int n_sample;
  int Y[n_sample];
  int N[n_sample];
}

parameters {
  real mu_zero;
  real mu[n_sample];
  real<lower=0> sigma;
}

transformed parameters  {
  real lambda[n_sample];
  real perc[n_sample];
  
  for(i in 1:n_sample)
    perc[i]=1/(1+exp(-mu[i]));
    lambda[i]=N[i]*perc[i]; 
  
}

model {
  mu[1] ~ normal(mu_zero,sigma);
  
  for(i in 2:n_sample)
    mu[i] ~ normal(mu[i-1],sigma);
  
    
  for(i in 1:n_sample)
    Y[i] ~ poisson(lambda[i]);
  
}

