library(animation)
par(mar=c(3, 3, 1, 1.5), mgp=c(1.5, 0.5, 0), bg = "white")
cent <- 1.5 * c(1, 1, -1, -1, 1, -1, 1, -1)

x <- NULL

for (i in 1:8) {
  x <- c(x, rnorm(25, mean = cent[i]))
}

x <- matrix(x, ncol = 2)
colnames(x) = c("X1", "X2")
kmeans.ani(x, centers = 4, pch = 1:4, col = 1:4)
