#Testing for vb model
test_that("Model structures: vb", {
  # Single individual
  single_model <- hmde_model("vb_single_ind")
  expect_named(single_model, c("step_size", "n_obs", "y_obs",
                               "obs_index", "time", "y_0_obs",
                               "y_bar", "model"))
  expect_type(single_model, "list")
  expect_visible(single_model)

  #Multiple individuals
  multi_model <- hmde_model("vb_multi_ind")
  expect_named(multi_model, c("step_size", "n_obs", "n_ind", "y_obs",
                              "obs_index", "time", "ind_id",
                              "y_0_obs", "y_bar", "model"))
  expect_type(multi_model, "list")
  expect_visible(multi_model)
})

test_that("Execution: vb single individual", {
  model_name <- "vb"
  par_names <- c("ind_growth_rate", "ind_max_size")

  hmde_test_single_individual(model_name, par_names)
})

test_that("Execution: vb multiple individuals", {
  model_name <- "vb"

  data <- readRDS(test_path("fixtures", "vb",
                            "vb_data_multi_ind.rds"))

  #Dimension is:
  est_dim <- data$n_ind +           #Initial condition
    (data$n_pars-1) * data$n_ind +  #Individual parameters, -1 as y_bar not estimated
    (data$n_pars-1) * 2 +           #Population parameters
    1 +                             #Global error
    data$n_obs +                    #y_ij
    data$n_obs +                    #Delta y_ij
    (data$n_pars) +                 #Pars temp vector
    1 +                             #lp__
    6                               #Generated quantities

  hmde_test_multi_individual(model_name, data, est_dim)
})
