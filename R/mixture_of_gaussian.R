# F(x) = 0.2N(1, 2) + 0.8 N(6,1)
N <- 1000
alpha <- 0.2
beta <- 0.8

x <- rnorm(N, 1, 2)
y <- rnorm(N, 6, 1)
z <- c(sample(x, alpha*N, replace=T), sample(y, beta*N, replace=T), ylim=c(0, 0.5))

hist(z, freq=F)
lines(density(z), col="red")
       
