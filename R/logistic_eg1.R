mydata <- read.csv("http://www.ats.ucla.edu/stat/data/binary.csv")
## view the first few rows of the data
head(mydata)
summary(mydata)

sapply(mydata, sd)


## two-way contingency table of categorical outcome and predictors we want
## to make sure there are not 0 cells
xtabs(~admit + rank, data = mydata)


mydata$rank <- factor(mydata$rank)

mylogit <- glm(admit ~ gre + gpa + rank, data = mydata, family = "binomial")


## CIs using profiled log-likelihood
confint(mylogit)

## CIs using standard errors
confint.default(mylogit)


library(aod)

wald.test(b = coef(mylogit), Sigma = vcov(mylogit), Terms = 4:6)



## odds ratios only
exp(coef(mylogit))


## odds ratios and 95% CI
exp(cbind(OR = coef(mylogit), confint(mylogit)))

newdata1 <- with(mydata, data.frame(gre = mean(gre), gpa = mean(gpa),
    rank = factor(1:4)))
newdata1$rankP <- predict(mylogit, newdata = newdata1, type = "response")

newdata2 <- with(mydata, data.frame(gre = rep(seq(from = 200, to = 800,
    length.out = 100), 4), gpa = mean(gpa), rank = factor(rep(1:4, each = 100))))
newdata2 <- cbind(newdata2, predict(mylogit, newdata = newdata2,
    type = "response", se = TRUE))
## view first few rows of final dataset
head(newdata2)


library(ggplot2)
p <- ggplot(newdata2, aes(x = gre, y = fit, colour = rank))
p <- p + geom_ribbon(aes(ymin = fit - se.fit, ymax = fit + se.fit,
    fill = rank), alpha = 0.25, colour = NA) + geom_line()
## view
p


with(mylogit, null.deviance - deviance)

with(mylogit, df.null - df.residual)

## p-values
with(mylogit, pchisq(null.deviance - deviance, df.null - df.residual,
    lower.tail = FALSE))


logLik(mylogit)
