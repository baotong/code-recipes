library(ggplot2)

qplot(rating, data=movies, weight=votes, geom="histogram", binwidth=1) 
