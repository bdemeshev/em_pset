library(tikzDevice)
library(azbuka) # devtoools::install_github("bdemeshev/azbuka")
library(tidyverse)
library(gridExtra) # grid.Arrange

a <- tikzsetup()

# source("tikz_setup.R")


# cars scatter ------------------------------------------------------------

p = ggplot(data = cars, aes(x = speed, y = dist)) + geom_point() +
  labs(title = "Зависимость длины тормозного пути",
       x = "Скорость, миль в час", y = "Длина пути, футов")
p

file_name <- "../R_plots/cars_scatter"
tikz_full <- paste0(file_name, ".tex")
png_full <- paste0(file_name, ".png")

ggsave(filename = png_full, device = "png", dpi = 200)

tikz(standAlone = FALSE, file = tikz_full, bareBones = TRUE)
print(p)
dev.off()


# flats scatter ------------------------------------------------------------

load("../pset_data.Rdata")

p = ggplot(flats, aes(x = totsp, y = price)) + geom_point() +
  labs(x = "Общая площадь, кв. м.",
       y = "Цена квартиры, 1000\\$", title = "Зависимость цены квартиры в Москве в 2001 году от общей площади")


p

file_name <- "../R_plots/flats_scatter"
tikz_full <- paste0(file_name, ".tex")
png_full <- paste0(file_name, ".png")

ggsave(filename = png_full, device = "png", dpi = 200)

tikz(standAlone = FALSE, file = tikz_full, bareBones = TRUE)
print(p)
dev.off()




# residual plot -----------------------------------------------------------



set.seed(777)
n <- 200
x <- rnorm(n)
z <- rnorm(n)
w <- rnorm(n)
eps <- abs(x)*rnorm(n)
y <- 2 + 3 * x - 3 * z + 1 * w + eps
model <- lm(y ~ x + z + w)
resid <- resid(model)
plot1 <- qplot(x, abs(resid),
               xlab = "Переменная $x$",
               ylab = "Модуль остатка")
plot2 <- qplot(head(resid, -1),
               tail(resid, -1),
               xlab = "Остаток $\\hat\\varepsilon_{t-1}$",
               ylab = "Остаток $\\hat\\varepsilon_{t}$")
grid.arrange(plot1, plot2, ncol = 2)


file_name <- "../R_plots/residual_plot"
tikz_full <- paste0(file_name, ".tex")
png_full <- paste0(file_name, ".png")

ggsave(filename = png_full, device = "png", dpi = 200)

tikz(standAlone = FALSE, file = tikz_full, bareBones = TRUE)
grid.arrange(plot1, plot2, ncol = 2)
dev.off()



# huron_level -------------------------------------------------------------

level <- LakeHuron
df <- tibble(level, obs = 1875:1972)
n <- nrow(df) # used later for answers
v.acf <- acf(level, plot = FALSE)$acf
v.pacf <- pacf(level, plot = FALSE)$acf
acfs.df <- tibble(lag = c(1:15, 1:15),
                  acf = c(v.acf[2:16], v.pacf[1:15]),
                  acf.type = rep(c("ACF", "PACF"), each = 15))
model <- arima(level, order = c(1, 0, 1))
resids <- model$residuals
resid.acf <- acf(resids, plot = FALSE)$acf
p = ggplot(df, aes(x = obs, y = level)) + geom_line() +
  labs(x = "Год", y = "Уровень озера (футы)", title = "Изменение высоты озера Гурон")
p

file_name <- "../R_plots/huron_level"
tikz_full <- paste0(file_name, ".tex")
png_full <- paste0(file_name, ".png")

ggsave(filename = png_full, device = "png", dpi = 200)

tikz(standAlone = FALSE, file = tikz_full, bareBones = TRUE)
print(p)
dev.off()



# huron_acf ---------------------------------------------------------------


p = ggplot(acfs.df, aes(x = lag, y = acf, fill = acf.type)) +
  geom_bar(position = "dodge", stat = "identity") +
  xlab("Лаг") + ylab("Корреляция") + labs(title = "Автокорреляционная функция для уровня воды в озере Гурон") + 
  guides(fill = guide_legend(title = NULL)) +
  geom_hline(yintercept = 1.96/sqrt(nrow(df))) +
  geom_hline(yintercept = -1.96/sqrt(nrow(df)))

p

file_name <- "../R_plots/huron_acf"
tikz_full <- paste0(file_name, ".tex")
png_full <- paste0(file_name, ".png")

ggsave(filename = png_full, device = "png", dpi = 200)

tikz(standAlone = FALSE, file = tikz_full, bareBones = TRUE)
print(p)
dev.off()


# acf_rescale -------------------------------------------------------------

acf.df <- data.frame(lag = 1:10, acf = c(11, 5, 3, 1, -2, 2, 1, 2, 0, 1))
p = ggplot(acf.df, aes(x = lag, y = acf)) +
  geom_bar(stat = "identity") +
  xlab("Лаг") + ylab("ACF") +
  guides(fill = guide_legend(title = NULL))
p


file_name <- "../R_plots/acf_rescale"
tikz_full <- paste0(file_name, ".tex")
png_full <- paste0(file_name, ".png")

ggsave(filename = png_full, device = "png", dpi = 200)

tikz(standAlone = FALSE, file = tikz_full, bareBones = TRUE)
print(p)
dev.off()


# armada ------------------------------------------------------------------

set.seed(777)
n_obs <- 2000
svm_df <- tibble(x = runif(n_obs, min = -20, max = 20), y = runif(n_obs, min = -20, max = 20))
svm_df <- dplyr::filter(svm_df, (y > x + 10) | (y < x - 10))
svm_df <- mutate(svm_df, type = ifelse(y > x + 10, 1, 0))
more_points <- tibble(x = c(0, 5, 5), y = c(0, 5, 0), type = c(1, 1, 0))
svm_df <- bind_rows(svm_df, more_points)

p = ggplot(data = svm_df, aes(x = x, y = y)) +
  geom_point(aes(shape = factor(type))) + theme_bw() + guides(shape = guide_legend(title = "Type"))
p

file_name <- "../R_plots/armada"
tikz_full <- paste0(file_name, ".tex")
png_full <- paste0(file_name, ".png")

ggsave(filename = png_full, device = "png", dpi = 200)

tikz(standAlone = FALSE, file = tikz_full, bareBones = TRUE)
print(p)
dev.off()


# tree scatter data -------------------------------------------------------

set.seed(42)
df <- tibble(x = runif(400), z = runif(400))
df$y <- factor(ifelse(df$x > 0.25 & df$z > 0.5, "yes", "no"))
p = qplot(data = df, x = x, y = z, col = y, shape = y) +
  geom_vline(xintercept = 0.25) + geom_hline(yintercept = 0.5)
p

file_name <- "../R_plots/tree_scatter_data"
tikz_full <- paste0(file_name, ".tex")
png_full <- paste0(file_name, ".png")

ggsave(filename = png_full, device = "png", dpi = 200)

tikz(standAlone = FALSE, file = tikz_full, bareBones = TRUE)
print(p)
dev.off()


# aggregate_regression ----------------------------------------------------

file_name <- "../R_plots/aggregate_regression"
tikz_full <- paste0(file_name, ".tex")
png_full <- paste0(file_name, ".png")

# ggsave(filename = png_full, device = "png", dpi = 200)

tikz(standAlone = FALSE, file = tikz_full, bareBones = TRUE)


n <- 100;
s <- rep(c(0, 4), c(n/2, n/2));
x <- c(1 + runif(n/2), runif(n/2));
y <- 2 * x + s + rnorm(n, sd = 0.15)


plot(x, y, type = "n", frame = "FALSE")
points(x[1:(n/2)], y[1:(n/2)], pch = 21,
       col = "black", bg = "ForestGreen", cex = 2)
points(x[(n/2 + 1):n], y[(n/2 + 1):n],
       pch = 21, col = "black", bg = "SkyBlue", cex = 2)

modelV1 <- lm(y ~ x + s)
# модели по 1:100 и 101:200 в отдельности
abline(coef(modelV1)[1], coef(modelV1)[2], lwd = 3)
abline(coef(modelV1)[1] + 4 * coef(modelV1)[3],
       coef(modelV1)[2], lwd = 3)
modelV2 <- lm(y ~ x)
# общая модель
abline(modelV2, lwd = 2, col = "red")

dev.off()


# aggregate_regression_b --------------------------------------------------



file_name <- "../R_plots/aggregate_regression_b"
tikz_full <- paste0(file_name, ".tex")
png_full <- paste0(file_name, ".png")

# ggsave(filename = png_full, device = "png", dpi = 200)

tikz(standAlone = FALSE, file = tikz_full, bareBones = TRUE)

n <- 100;
s <- rep(c(0, 4), c(n/2, n/2));
x <- c(runif(n/2), 1 + runif(n/2));
y <- -2 * x + s + rnorm(n, sd = 0.15)

plot(x, y, type = "n", frame = FALSE)
points(x[1:(n/2)], y[1:(n/2)], pch = 21,
       col = "black", bg = "ForestGreen", cex = 2)
points(x[(n/2 + 1):n], y[(n/2 + 1):n], pch = 21,
       col = "black", bg = "SkyBlue", cex = 2)

modelV1 <- lm(y ~ x + s)
# модели по 1:100 и 101:200 в отдельности
abline(coef(modelV1)[1], coef(modelV1)[2], lwd = 3)
abline(coef(modelV1)[1] + 4 * coef(modelV1)[3], coef(modelV1)[2], lwd = 3)
modelV2 <- lm(y ~ x)
# общая модель
abline(modelV2, lwd = 2, col = "red")


dev.off()




# with_and_without_c ------------------------------------------------------

file_name <- "../R_plots/with_and_without_c"
tikz_full <- paste0(file_name, ".tex")
png_full <- paste0(file_name, ".png")

# ggsave(filename = png_full, device = "png", dpi = 200)

tikz(standAlone = FALSE, file = tikz_full, bareBones = TRUE)



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


dev.off()



# uniform_errors ----------------------------------------------------------


file_name <- "../R_plots/uniform_errors"
tikz_full <- paste0(file_name, ".tex")
png_full <- paste0(file_name, ".png")

# ggsave(filename = png_full, device = "png", dpi = 200)

tikz(standAlone = FALSE, file = tikz_full, bareBones = TRUE)


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

for (i in 1:m) {
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

for (i in 1:ncol(toPlot))           # построим все одним махом
{
  hist(toPlot[, i], prob = TRUE, main = "",
       xlab = colnames(toPlot)[i], ylim = c(0, max(density(toPlot[, i])$y)) )
  lines(density(toPlot[, i]), col = i, lwd = 4)
}

dev.off()



# two_points_zero_slope ---------------------------------------------------

data_2d <- tibble(
  x = c(10, 20),
  y = c(7, 7))

p = qplot(data = data_2d, x = x, y = y) + theme_bw() +
  xlab("$x_i$") + ylab("$y_i$") +
  scale_y_continuous(limits = c(0, 15)) +
  scale_x_continuous(limits = c(0, 30))
p


file_name <- "../R_plots/two_points_zero_slope"
tikz_full <- paste0(file_name, ".tex")
png_full <- paste0(file_name, ".png")

ggsave(filename = png_full, device = "png", dpi = 200)

tikz(standAlone = FALSE, file = tikz_full, bareBones = TRUE)
print(p)
dev.off()


# two_points_positive_slope ---------------------------------------------------

data_2d <- tibble(
  x = c(10, 20),
  y = c(7, 12))

p = qplot(data = data_2d, x = x, y = y) + theme_bw() +
  xlab("$x_i$") + ylab("$y_i$") +
  scale_y_continuous(limits = c(0, 20)) +
  scale_x_continuous(limits = c(0, 30))
p


file_name <- "../R_plots/two_points_positive_slope"
tikz_full <- paste0(file_name, ".tex")
png_full <- paste0(file_name, ".png")

ggsave(filename = png_full, device = "png", dpi = 200)

tikz(standAlone = FALSE, file = tikz_full, bareBones = TRUE)
print(p)
dev.off()



# regression_on_plot ------------------------------------------------------


set.seed(94)
n_obs <- 20
data_2d <- tibble(
  x = -20 + rbinom(n_obs, size = 50, prob = 0.5),
  y = 5 + 3 * x + rbinom(n_obs, size = 160, prob = 0.5))

x_bar <- mean(data_2d$x)

p = qplot(data = data_2d, x = x, y = y) + theme_bw() +
  scale_x_continuous(breaks = c(0, data_2d$x[20], x_bar),
                     labels = c("$0$", "$x_{20}$", "$\\bar x$")) +
  stat_smooth(method = "lm", se = FALSE, col = I("gray")) +
  xlab("") + ylab("$y_i$")
p

file_name <- "../R_plots/regression_on_plot"
tikz_full <- paste0(file_name, ".tex")
png_full <- paste0(file_name, ".png")

ggsave(filename = png_full, device = "png", dpi = 200)

tikz(standAlone = FALSE, file = tikz_full, bareBones = TRUE)
print(p)
dev.off()


# 4_observations ----------------------------------------------------------

data_2d <- tibble(
  x = c(1, 2, 2, 2),
  y = c(3, 1, 2, 3))

p = qplot(data = data_2d, x = x, y = y) + theme_bw() +
  scale_x_continuous(breaks = c(0, 1, 2),
                     labels = c("$0$", "$1$", "$2$")) +
  xlab("$x_i$") + ylab("$y_i$")
p


file_name <- "../R_plots/4_observations"
tikz_full <- paste0(file_name, ".tex")
png_full <- paste0(file_name, ".png")

ggsave(filename = png_full, device = "png", dpi = 200)

tikz(standAlone = FALSE, file = tikz_full, bareBones = TRUE)
print(p)
dev.off()
