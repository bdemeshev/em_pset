file_name <- "test_tikz"

library(tikzDevice)
library(azbuka) # devtoools::install_github("bdemeshev/azbuka")
a <- tikzsetup()

# source("tikz_setup.R")

# tikz_full <- paste0("auto_figures_tikz/", file_name, ".tex")
# png_full <- paste0("auto_figures_png/", file_name, ".png")

tikz_full <- paste0(file_name, ".tex")
png_full <- paste0(file_name, ".png")



library(tidyverse)

# n <- 2
# data <- expand.grid(x = 1:n, y = 1:n)
# data$chars <- intToUtf8(seq.int(187, by = 1, length.out = n * n), multiple = T)
# data$letters <- c("ы", "я", "ф", "Ю")
# 
# p <- ggplot2::ggplot(data, ggplot2::aes(x = x, y = y)) +
#   ggplot2::geom_text(ggplot2::aes(label = letters))



df <- tibble(x = c(8, 5, 6, 7, 3, 9))
df <- df %>% arrange(x)
ecdfmass <- ecdf(df$x)
df <- df %>% mutate(y = ecdfmass(x), xend = c(tail(x, -1), Inf))

p <- ggplot(data = df) + geom_segment(aes(x = x, xend = xend, y = y, yend = y), 
                                      arrow = arrow(ends = "last"))  + geom_point(aes(x = x, y = y)) + theme_bw()



ggsave(filename = png_full, device = "png", dpi = 200)

tikz(standAlone = TRUE, file = tikz_full)
print(p)
dev.off()



