% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rmot_run.R
\name{rmot_run}
\alias{rmot_run}
\title{Run a linear model in Stan}
\usage{
rmot_run(model_template, ...)
}
\arguments{
\item{model_template}{model template generated by rmot_model and updated by rmot_assign_data}

\item{...}{additional arguments passed to rstan::sampling}
}
\value{
Stanfit model output
}
\description{
Run a linear model in Stan
}
\examples{
rmot_model("linear") |>
  rmot_assign_data(X = Loblolly$age,
                   Y = Loblolly$height,
                   N = nrow(Loblolly)) |>
  rmot_run()
}
