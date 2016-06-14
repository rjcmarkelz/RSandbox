library(ggplot2)
setwd("~/git.repos/arabidopsis_cv/data")

size <- read.csv("plant-growth.csv", header = FALSE)
names(size) <- paste(c("group","image","data"))
head(size)
size$trt <- sub("(\\w+)(Group)(\\d)(\\w+)", "\\4", size$group)
size$hour <- sub("(\\w+)(Group)(\\d)(\\w+)", "\\1", size$group)
size$date <- as.Date(sub("(\\w+)(_)(\\w+)(.jpg)", "\\1", size$image))
str(size)
qplot(data = size, y = data, x =date, color = trt)

require(graphics)

attach(cars)
plot(speed, dist, main = "data(cars)  &  smoothing splines")
cars.spl <- smooth.spline(speed, dist)
(cars.spl)
lines(cars.spl, col = "blue")
lines(smooth.spline(speed, dist, df = 10), lty = 2, col = "red")
legend(5,120,c(paste("default [C.V.] => df =",round(cars.spl$df,1)),
               "s( * , df = 10)"), col = c("blue","red"), lty = 1:2,
       bg = 'bisque')
detach()

head(size)


