## ----"uniform_errors"----------------------------------------------------
tikz("../R_plots/uniform_errors.tikz", standAlone = FALSE, bareBones = TRUE)

n <- 100 # количество наблюдений
m <- 100 # можно менять количество прогонов
         # и радоваться!
x <- rnorm(n, 5, 1)

b1 <- rep(0, m)
b2 <- rep(0, m)
sHatSquared <- rep(0, m)
varB1 <- rep(0, m)
varB2 <- rep(0, m)
Cov <- rep(0, m)

for(i in 1:m) {
  y <- 1 + 2 * x + runif(n, -1, 1)       # остатки распределены как надо
  b1[i] <- coef(lm(y ~ x))[[1]]
  b2[i] <- coef(lm(y ~ x))[[2]]
  sHatSquared[i] <- sum((summary(lm(y ~ x))$resid)^2) / (n - 2)
  varB1[i] <- vcov(lm(y ~ x))[1, 1]
  varB2[i] <- vcov(lm(y ~ x))[2, 2]
  Cov[i] <- vcov(lm(y ~ x))[1, 2]
}

palette(c("ForestGreen", "olivedrab", "SkyBlue", "tomato3", "navy", "brown"))
par(mfrow = c(2, 3))

toPlot <- data.frame(b1 = b1, b2 = b2, sHatSquared = sHatSquared,
                     varB1 = varB1, varB2 = varB2, Cov = Cov)

for(i in 1:ncol(toPlot))           # построим все одним махом
{
  hist(toPlot[, i], prob = TRUE, main = "",
       xlab = colnames(toPlot)[i], ylim = c(0, max(density(toPlot[, i])$y)) )
  lines(density(toPlot[, i]), col = i, lwd = 4)
}

invisible(dev.off())

## ----"problem_2_4_part_1"------------------------------------------------
t_crit <- qt(1 - 0.05/2, df = 5 - 2)
t_crit

## ----"problem_2_4_part_2"------------------------------------------------
t_obs <- 0.6
abs(t_obs) < t_crit

## ----"problem_2_4_part_3"------------------------------------------------
p_value <- 2 * (1 - pt(t_obs, df = 3))
p_value

## ----"problem_2_4_part_4"------------------------------------------------
t_crit <- qt(1 - 0.05/2, df = 5 - 2)
t_crit

## ----"problem_2_4_part_5"------------------------------------------------
t_obs <- 5.692
abs(t_obs) < t_crit

## ----"problem_2_4_part_6"------------------------------------------------
p_value <- 2 * (1 - pt(t_obs, df = 3))
p_value

## ----"problem_2_5"-------------------------------------------------------
f_crit <- qf(p = 0.95, df1 = 1, df2 = 3)
f_crit < 12.3

## ----"problem_2_9"-------------------------------------------------------
qt(0.025, df = 98)

## ----"problem_2_10"------------------------------------------------------
p_value <- 2 * pt(-6, df = 98)
p_value

p_value > 0.05 # если TRUE, то гипотеза не отвергается

## ----"problem_2_11"------------------------------------------------------
qt(0.005, df = 43)

## ----"problem_2_26"------------------------------------------------------
pchisq(30, 20) - pchisq(10, 20)

## ----"problem_2_27_part_1"-----------------------------------------------
pt(1, df = 10) - pt(-1, df = 10)

## ----"problem_2_27_part_2"-----------------------------------------------
1 - pt(1, df = 10)

## ----"problem_2_27_part_3"-----------------------------------------------
pt(1, df = 10)

## ----"problem_2_27_part_4"-----------------------------------------------
1 - pchisq(10, df = 10)

## ----"problem_2_27_part_5"-----------------------------------------------
1 - pchisq(40, df = 10)

## ----"small_r2_big_t"----------------------------------------------------
set.seed(777) # на удачу!
x <- rnorm(100000, mean = 0, sd = 1)
eps <- rnorm(100000, mean = 0, sd = 10)
y <- 0 + 1 * x + eps
model <- lm(y ~ x)
report <- summary(model)
report$r.squared

## ----"problem_2_38_part_1"-----------------------------------------------
1 - pchisq(q = 2, df = 2)

## ----"problem_2_38_part_2"-----------------------------------------------
1 - pt(q = 2 * sqrt(2), df = 2)

## ----"problem_2_38_part_3"-----------------------------------------------
1 - pt(q = 5 / 4, df = 3)

## ----"problem_2_38_part_4"-----------------------------------------------
pt(q = 9 / 2 * sqrt(3) / sqrt(5), df = 3)

## ----"problem_2_38_part_5"-----------------------------------------------
pt(q = -sqrt(34), df = 2) + (1 - pt(q = sqrt(34), df = 2))

## ----"problem_2_40", results="asis"--------------------------------------
df1 <- data.frame(x = c(1, 2, 3, 4), y = c(5, 3, 3, 4) )
df2 <- data.frame(y = rep(df1$y, 10), x = rep(df1$x, 10))
m1 <- lm(data=df1, y ~ x)
m2 <- lm(data=df2, y ~ x)
mt <- mtable(m1, m2, summary.stats = c("N",
    "Deviance", "R-squared", "sigma", "F", "p"))
write.mtable(mt, forLaTeX = TRUE)

## ----"two_points_zero_slope", echo=FALSE---------------------------------
tikz("../R_plots/two_points_zero_slope.tikz", standAlone = FALSE, bareBones = TRUE)
data_2d <- data_frame(
  x = c(10, 20),
  y = c(7, 7))

qplot(data = data_2d, x = x, y = y) + theme_bw() +
  xlab("$x_i$") + ylab("$y_i$") +
  scale_y_continuous(limits = c(0, 15)) +
  scale_x_continuous(limits = c(0, 30))
invisible(dev.off())

## ----"two_points_positive_slope", echo=FALSE-----------------------------
tikz("../R_plots/two_points_positive_slope.tikz", standAlone = FALSE, bareBones = TRUE)
data_2d <- data_frame(
  x = c(10, 20),
  y = c(7, 12))

qplot(data = data_2d, x = x, y = y) + theme_bw() +
  xlab("$x_i$") + ylab("$y_i$") +
  scale_y_continuous(limits = c(0, 20)) +
  scale_x_continuous(limits = c(0, 30))
invisible(dev.off())

## ----"regression_on_plot", echo=FALSE------------------------------------
tikz("../R_plots/regression_on_plot.tikz", standAlone = FALSE, bareBones = TRUE)
set.seed(94)
n_obs <- 20
data_2d <- data_frame(
  x = -20 + rbinom(n_obs, size = 50, prob = 0.5),
  y = 5 + 3 * x + rbinom(n_obs, size = 160, prob = 0.5))

x_bar <- mean(data_2d$x)

qplot(data = data_2d, x = x, y = y) + theme_bw() +
  scale_x_continuous(breaks = c(0, data_2d$x[20], x_bar),
                     labels = c("$0$", "$x_{20}$", "$\\bar x$")) +
  stat_smooth(method = "lm", se = FALSE, col = I("gray")) +
  xlab("") + ylab("$y_i$")
invisible(dev.off())

## ----"4_observations", echo=FALSE----------------------------------------
tikz("../R_plots/4_observations.tikz", standAlone = FALSE, bareBones = TRUE)
data_2d <- data_frame(
  x = c(1, 2, 2, 2),
  y = c(3, 1, 2, 3))

qplot(data = data_2d, x = x, y = y) + theme_bw() +
  scale_x_continuous(breaks = c(0, 1, 2),
  labels = c("$0$", "$1$", "$2$")) +
  xlab("$x_i$") + ylab("$y_i$")
invisible(dev.off())

