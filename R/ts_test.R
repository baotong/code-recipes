## x <- read.table("~/Downloads/lab_stat41.csv", sep=";", col.names=c("date", "bucket", "cvr", "price", "click"))
#pid <- "419149_1007"
pid <- "420986_1007"

x <- read.table(paste("~/Downloads/lab_stat_", pid, ".csv", sep=""), sep=";", col.names=c("date", "bucket", "cvr", "price", "click"))
x$date <- as.Date(x$date, "%Y-%m-%d")
cvr.5 <- x[x$date >= "2012-05-01" & x$date < "2012-06-01",]
summary(cvr.5$cvr)

plot(cvr.5$date, cvr.5$cvr, type="b", col="red", xlab="date", ylab="cvr(%)", main="time series of cvr", sub=pid)


## prop test
#prop.test(18766, 938297)
