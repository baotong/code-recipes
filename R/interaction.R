N <- 1000
x1 <- rnorm(N, 10, 1)
x2 <- rnorm(N, 30, 1)
epsilon <- rnorm(N, 0, 1)

## linear, no interaction
y <- 10 * x1 - 3 * x2 + epsilon
m1 <- lm(y ~ x1 + x2)

## noliear, no interaction
y <- 4 * x1^2 - 3* x2 + epsilon
m2 <- lm(y ~ x1 + x2)
m3 <- lm(y ~ x1*x1 + x2)

## interaction
y <- 4 * x1 - 3* x2 + 2*x1*x2 +  epsilon
m4 <- lm(y ~ x1+x2)
m5 <- lm(y ~ x1+x2 + x1:x2)

## division
y <- 4 * x1 - 3* x2 + 30000*(x1+0.1)/(x2+0.1) +  epsilon
m6 <- lm(y ~ x1+x2)
m7 <- lm(y ~ x1+x2 + x1:x2)
m8 <- lm(y ~ x1+x2 + I(x1/x2))
