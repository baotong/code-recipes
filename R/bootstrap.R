# generate random values
n <- 1000
B <- 500
x <- rnorm(n)
y <- rep(0, B)


for (i in 1:B) {
  x.sub <- sample(x, n, replace=T)
  y[i] <- mean(x.sub)
}


var(y)

# binomial distribution
p <- 0.3
x <- rbinom(10000, 1, p)
n <- 9000
y <- rep(0, n)

for (i in 1:n) {
  x.sub <- sample(x, n, replace=T)
  y[i] = mean(x.sub)
}


## boot package
library(boot)

hsb2 <- read.table("http://www.ats.ucla.edu/stat/R/notes/hsb2.csv", sep=",", header=T)
c <- function(d, i){
	d2 <- d[i,]
	return(cor(d2$write, d2$math))
}

bootcorr <- boot(hsb2, c, R=500)
mean(bootcorr$t) - bootcorr$t0

sd(bootcorr$t)
## Using the boot.ci command, you can generate several types of confidence intervals from your bootstrap samples. 

boot.ci(bootcorr, type = "all")

plot(bootcorr)

