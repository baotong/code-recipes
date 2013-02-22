ricker <- function(nzero, r, K=1, time=100, from=0, to=time) {
  N <- numeric(time + 1)
  N[1] <- nzero
  for (i in 1:time) N[i+1] <- N[i] * exp(r * (1 - N[i] / K))
  Time <- 0:time
  plot(Time, N, type='l', xlim=c(from, to))
}
