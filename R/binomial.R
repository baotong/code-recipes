## sample size of binomial samples
## wiki: http://en.wikipedia.org/wiki/Binomial_proportion_confidence_interval
sample.size <- function(p, err, conf.level=0.95) {
  alpha <- (1 - conf.level) / 2
  qnorm(1- alpha)^2 * (1-p) / (p * err^2)
}

## 输入ctr 和 pv
## 输出相对误差
b.err1 <- function(x, n, p=x/n, conf.level=0.95) {
  alpha <- (1 - conf.level) / 2
  qnorm(1 - alpha) * sqrt(p*(1-p)/n) / p
}

## b.err2(132, 119155, p=0.001108)
## 利用 binomial test 计算相对误差
b.err2 <- function(x, n, p=x/n, conf.level=0.95) {
  b <- binom.test(x, n, p, conf.level=conf.level)
  (b$conf.int[2] - p) / p
}

## 利用 binomial test 计算标准差
b.err3 <- function(x, n, p=x/n, conf.level=0.95) {
  b <- binom.test(x, n, p, conf.level=conf.level)
  (b$conf.int[2] - p)
}

## hypothesis test of two samples


## for (i in 1:200) {
##   ctr <- i/10000;
##   write(c(format(ctr, digits=6),as.integer(view.sample(ctr, 0.20))), "", ncolumns=2, sep=",")
## }
