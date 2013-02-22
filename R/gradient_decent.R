## From calculation, we expect that the local minimum occurs at x=9/4


f <- function(x) {
  x^4 - x^3 + 2
}

f.prime <- function(x) {
  4 * x^3 - 9 * x^2
}



x_old <- 1
x_new <- 2 # The algorithm starts at x<-6
eps <- 0.01 # step size
precision <- 0.00001

iter <- 0
while (abs(x_new - x_old) > precision) {
  x_old <- x_new
  x_new <- x_old - eps * f.prime(x_old)
  iter <- iter + 1
  print(c("iteration: ", iter, " x_new: ", x_new, " y: ", f(x_new)))
}

print(c("Local minimum occurs at ", x_new))
