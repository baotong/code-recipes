ROC <- function (x, n = 1, type = c("continuous", "discrete"), na.pad = TRUE)
{
    x < - try.xts(x, error = as.matrix)
    type <- match.arg(type)
    if (is.xts(x)) {
        if (type == "discrete") {
            roc <- x/lag(x, n, na.pad = na.pad) - 1
        }
        if (type == "continuous") {
            roc <- diff(log(x), n, na.pad = na.pad)
        }
        reclass(roc, x)
    }
    else {
        NAs <- NULL
        if (na.pad) {
            NAs <- rep(NA, n)
        }
        if (type == "discrete") {
            roc <- c(NAs, x[(n + 1):NROW(x)]/x[1:(NROW(x) - n)] -
                1)
        }
        if (type == "continuous") {
            roc <- c(NAs, diff(log(x), n))
        }
        return(roc)
    }
}
