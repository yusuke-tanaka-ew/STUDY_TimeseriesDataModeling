
data {
  int n_sample;
  int Y[n_sample];
  int N[n_sample];
}

parameters {
  real<lower=0,upper=1> p;
}

transformed parameters {
  real lambda[n_sample];
  for(i in 1:n_sample)
    lamda[i] = N[n_sample]*p;
}

model {
  for(i in 1:n_sample)
    Y[i] ~ poisson(lambda[i]);
}

