weighted.median <- function(x, w = NULL, na.rm = FALSE)
{  # change log: special cases corrected
  if (!missing(w) & length(w) != length(x))
  		stop("vectors must be of the same length")
  if (missing(w) || length(w) %in% c(1,2) || all(diff(w[!is.na(w)])==0)) {
    if (length(w) == 1) return (x[1])
    else if (length(w) == 2) return ((x[1]*w[1] + x[2]*w[2])/sum(w))
    else return(median(x, na.rm))
  }
  else {
  	if(mode(x) != "numeric" | mode(w) != "numeric")
  		stop("need numeric data")
  	x <- as.vector(x)
  	w <- as.vector(w)
  	wnas <- unique(c(which(is.na(x)),which(is.na(w))))
	  if(length(wnas)) {
	  	if(na.rm) {
	  	  x <- x[ - wnas]
          w <- w[ - wnas]
        }
		else return(NA)
  	}
    if (sum(w != 0)==1) return( x[w!=0] )
    ind <- sort.list(x)
  	cw <-sum(w)/2+0.5 ## *length(w) # mimics 1:n, but weighted
    half <- seq(along=w)[diff(cumsum(w[ind]) == cw)==-1]  ## find place where == , after which FALSE again
  	if (length(half)) {  # take the exact value
  		(x[ind])[half]
  	}
  	else {  ## take half of straddling values
  		half <- seq(along=w)[abs(diff(cumsum(w[ind]) > cw))==1] + 0:1
  		sum(x[ind][half])/2
  	}
  }
}

