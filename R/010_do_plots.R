# 010

# ---- aggregate_regression ----
tikz("../R_plots/aggregate_regression.tikz", standAlone = FALSE, bareBones = TRUE)
n <- 100;
s <- rep(c(0, 4), c(n/2, n/2));
x <- c(1 + runif(n/2), runif(n/2));
y <- 2 * x + s + rnorm(n, sd = 0.15)


plot(x, y, type = "n", frame = "FALSE")
points(x[1 : (n/2)], y[1 : (n/2)], pch = 21,
       col = "black", bg = "ForestGreen", cex = 2)
points(x[(n/2 + 1) : n], y[(n/2 + 1) : n],
       pch = 21, col = "black", bg = "SkyBlue", cex = 2)

modelV1 <- lm(y ~ x + s)
# модели по 1:100 и 101:200 в отдельности
abline(coef(modelV1)[1], coef(modelV1)[2], lwd = 3)
abline(coef(modelV1)[1] + 4 * coef(modelV1)[3],
       coef(modelV1)[2], lwd = 3)
modelV2 <- lm(y ~ x)
# общая модель
abline(modelV2, lwd = 2, col = "red")
invisible(dev.off())


# ---- aggregate_regression_b ----
tikz("../R_plots/aggregate_regression_b.tikz", standAlone = FALSE, bareBones = TRUE)
n <- 100;
s <- rep(c(0, 4), c(n/2, n/2));
x <- c(runif(n/2), 1 + runif(n/2));
y <- -2 * x + s + rnorm(n, sd = 0.15)

plot(x, y, type = "n", frame = FALSE)
points(x[1 : (n/2)], y[1 : (n/2)], pch = 21,
       col = "black", bg = "ForestGreen", cex = 2)
points(x[(n/2 + 1) : n], y[(n/2 + 1) : n], pch = 21,
       col = "black", bg = "SkyBlue", cex = 2)

modelV1 <- lm(y ~ x + s)
# модели по 1:100 и 101:200 в отдельности
abline(coef(modelV1)[1], coef(modelV1)[2], lwd = 3)
abline(coef(modelV1)[1] + 4 * coef(modelV1)[3], coef(modelV1)[2], lwd = 3)
modelV2 <- lm(y ~ x)
# общая модель
abline(modelV2, lwd = 2, col = "red")
invisible(dev.off())


# ---- with_and_without_c ----
tikz("../R_plots/with_and_without_c.tikz", standAlone = FALSE, bareBones = TRUE)
x <- c(rnorm(n, mean = 4, sd = 2))
y <- x - 7 + runif(n, min = -1, max = 1)

plot(x,y, pch = 21, bg = "ForestGreen",
     col = "black", xlim = c(0,10), ylim = c(-5,3))
abline(coef(lm(y ~ x))[1], coef(lm(y ~ x))[2], lwd = 2)
abline(0, coef(lm(y ~ 0 + x))[1] , lwd = 2)
labels <- c("With intercept", "Without intercept")
text(c(7.5, 1.5), c(2, 0.4), labels)
coef(lm(y ~ x))
coef(lm(y ~ 0 + x))
invisible(dev.off())


# ---- sign_change_example ----
y <- 1:50
z <- y + rnorm(length(y), 0, 0.01)
x <- y + rnorm(length(y), 0, 1)
coef(lm(y ~ x))
coef(lm(y ~ x + z))
