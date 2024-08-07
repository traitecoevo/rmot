% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hmde_run.R
\name{hmde_run}
\alias{hmde_run}
\title{Run chosen pre-built model in Stan}
\usage{
hmde_run(model_template, ...)
}
\arguments{
\item{model_template}{model template generated by hmde_model and updated by hmde_assign_data}

\item{...}{additional arguments passed to rstan::sampling}
}
\value{
Stanfit model output
}
\description{
Run chosen pre-built model in Stan
}
