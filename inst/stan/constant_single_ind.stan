//Constant Growth - Single species
functions{
  //Growth function
  real growth(real beta){
    return beta;
  }
}

// Data structure
data {
  int n_obs;
  real y_obs[n_obs];
  int obs_index[n_obs];
  real time[n_obs];
  real y_0_obs;
}

// The parameters accepted by the model.
parameters {
  //Individual level
  real<lower=0> ind_y_0;
  real<lower=0> ind_beta;

  //Global level
  real<lower=0> global_error_sigma;
}

// The model to be estimated.
model {
  real y_hat[n_obs];
  real Delta_hat[n_obs];

  for(i in 1:n_obs){
    if(obs_index[i]==1){//Fits the first size
      y_hat[i] = ind_y_0[ind_id[i]];
    }

    if(i < n_obs){ //Analytic solution
      Delta_hat[i] = growth(ind_beta[ind_id[i]]);
      y_hat[i+1] = y_hat[i] + Delta_hat[i]*(time[i+1]-time[i]);
    } else {
      Delta_hat[i] = 0;
    }
  }

  //Likelihood
  y_obs ~ normal(y_hat, global_error_sigma);

  //Priors
  //Individual level
  ind_y_0 ~ normal(y_0_obs, global_error_sigma);
  ind_beta ~ lognormal(species_beta_mu,
                    species_beta_sigma);

  //Species level
  species_beta_mu ~ normal(0.1, 1);
  species_beta_sigma ~cauchy(0.1, 1);

  //Global level
  global_error_sigma ~cauchy(0.1, 1);
}

// The output
generated quantities {
  real y_hat[n_obs];
  real Delta_hat[n_obs];

  for(i in 1:n_obs){
    if(obs_index[i]==1){//Fits the first size
      y_hat[i] = ind_y_0[ind_id[i]];
    }

    if(i < n_obs){ //Analytic solution
      Delta_hat[i] = growth(ind_beta[ind_id[i]]);
      y_hat[i+1] = y_hat[i] + Delta_hat[i]*(time[i+1]-time[i]);
    } else {
      Delta_hat[i] = 0;
    }
  }
}