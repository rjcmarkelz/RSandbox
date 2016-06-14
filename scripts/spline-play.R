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

x <- c(1:24)
mu <- 10 + 5 * sin(x * pi / 24) - 2 * cos((x - 6)*4/24)
mu
set.seed(1234)
eee <- rnorm(length(mu))
eee
y <- mu + eee

x6 <- (x - 6)
x6[x6 < 0] <- 0
x12 <- (x - 12)
x12[x12 < 0 ] <- 0
x18 <- (x - 18)
x18[x18 < 0] <- 0

fit <- lm(y ~ x + x6 + x12 + x18)
fit
print(summary(fit))

fitted.mean <- predict(fit)
plot(x, y)
lines(x, mu, col = "red")
lines(x, fitted.mean, col = "blue", lwd = 2)
lines(x, fitted.mean2, col = "black", lwd = 2)
fitted.mean

x.squared <- x^2
x.cubed <- x^3

fit <- lm(y ~ x + x.squared + x.cubed)
fitted.mean2 <- predict(fit)

x6.cubed <- x6^3
x12.cubed <- x12^3
x18.cubed <- x18^3

fit <- lm(y ~ x + x.squared + x.cubed + x6.cubed + x12.cubed + x18.cubed)
fitted.mean3 <- predict(fit)
lines(x, fitted.mean3, col = "green", lwd = 2)

library(splines)
fit <- lm(y ~ ns(x, knots = c(6, 12, 18)))
fitted.mean4 <- predict(fit)
lines(x, fitted.mean4, col = "orange", lwd = 2)

?smooth.spline
#
# finish splines