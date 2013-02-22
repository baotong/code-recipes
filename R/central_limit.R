limit.central <- function(r=runif, distpar=c(0,1), m=.5,
                          s=1/sqrt(12), n=c(1,3,10,30), N=1000) {
  for (i in n) {
    if (length(distpar) == 2) {
      x <- matrix(r(i*N, distpar[1], distpar[2]), nc=i)
    }
    else {
      x <- matrix(r(i*N, distpar), nc=i)
    }
    x <- (apply(x, 1, sum) - i*m) / (sqrt(i)*s)
    hist(x, col='light blue', probability=T, main=paste("n=", i),
         ylim=c(0, max(.4, density(x)$y)))
    lines(density(x), col='red', lwd=3)
    curve(dnorm(x), col='blue', lwd=3, lty=3, add=T)
    if (N > 100) {
      rug(sample(x, 100))
    }
    else {
      rug(x)
    }
  }
}

## eg
## binomial

op <- par(mfrow=c(2,2))
limit.central(rbinom, distpar=c(10, 0.1), m=1, s=0.9)
par(op)
  


## poisson

op <- par(mfrow=c(2,2))
limit.central(rpois, distpar=1, m=1, s=1, n=c(3, 10, 30, 50))
par(op)



