x <- 1:5
x.prob <- c(5,2,1,1,1)/10
M <- 3
N <- 200000
tmp <- matrix(0, N, M)

for (i in 1:N) {
  tmp[i,] <- sample(x, M, prob=x.prob, replace=F)
}


for (i in 1:5) {
  print(length(tmp[tmp==i]) /(M*N))
}

# inference of multiple sampling method with replacement
