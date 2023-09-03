## Inequality functions

# Gini Index
gini <- function (x, weights = rep(1, length = length(x))) {
  ox <- order(x)
  x <- x[ox]
  weights <- weights[ox] / sum(weights)
  p <- cumsum(weights)
  nu <- cumsum(weights * x)
  n <- length(nu)
  nu <- nu / nu[n]
  sum(nu[-1] * p[-n]) - sum(nu[-n] * p[-1])
}

# Quintile ratio
quintileratio <-
  function (x, weights = rep(1, length = length(x))) {
    ox <- order(x)
    x <- x[ox]
    weights <- weights[ox] / sum(weights)
    p <- cumsum(weights)
    nu <- cumsum(weights * x)
    n <- length(nu)
    nu <- nu / nu[n]
    df <- data.frame(p, nu)
    quin <- (1 - min(df$nu[df$p >= 0.8])) / max(df$nu[df$p <= 0.2])
    return(quin)
  }

# Palma ratio
palmaratio <- function (x, weights = rep(1, length = length(x))) {
  ox <- order(x)
  x <- x[ox]
  weights <- weights[ox] / sum(weights)
  p <- cumsum(weights)
  nu <- cumsum(weights * x)
  n <- length(nu)
  nu <- nu / nu[n]
  df <- data.frame(p, nu)
  pal <- (1 - min(df$nu[df$p >= 0.9])) / max(df$nu[df$p <= 0.4])
  return(pal)
}