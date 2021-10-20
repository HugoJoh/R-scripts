#install relevant packages
install.packages('ShellChron')
library(ShellChron)
install.packages('ggplot2')
library(ggplot2)
install.packages("writexl")
library("writexl")
install.packages('ellipse')
library(ellipse)

# create the data for var1 and var2
#var1
VariableT <- seq(from = 1, to = 100, by = 1)
Ys1 <- sin((2 * pi * (seq(1, 100, 1) - 3 + 2 / 2)) / 8)
sinlist1 <- sinreg(VariableT, Ys1, plot = FALSE) # Run the function
fittedYs1 <- sinlist1[[2]]
data1 <- data.frame(VariableT, Ys1, fittedYs1)

graph1 <- ggplot(data, aes(x = VariableT, y = Ys1)) + geom_point() + geom_line(aes(x = VariableT, y = fittedYs1))
graph1

#var2
VariableT2 <- seq(from = 1, to = 100, by = 1)
Ys2 <- -2*Ys1+23
sinlist2 <- sinreg(VariableT2, Ys2, plot = FALSE) # Run the function
fittedYs2 <- sinlist2[[2]]
data2 <- data.frame(VariableT2, Ys2, fittedYs2)

graph2 <- ggplot(data, aes(x = VariableT2, y = Ys2)) + geom_point() + geom_line(aes(x = VariableT2, y = fittedYs2))
graph2

#Save the output file for var1 & var2 data
df <- data.frame(VariableT, Ys1, Ys2)
print(df)
write_xlsx(df,"File path")

# do the pca in r
pca <- prcomp(df, scale=TRUE)
pca_sum <- summary(pca_sum)

# Plot individuals
plot(pca$x[,1], pca$x[,2], xlab=paste("PCA 1 (", round(s$importance[2]*100, 1), "%)", sep = ""), ylab=paste("PCA 2 (", round(s$importance[5]*100, 1), "%)", sep = ""), xlim=c(-5,5), ylim=c(-5,5))

# Add grid lines
abline(v=0, lty=2, col="grey40")
abline(h=0, lty=2, col="grey40")

# Get loadings and multiply by 10
l.x <- pca$rotation[,1]*10
l.y <- pca$rotation[,2]*10

# Draw arrows
arrows(x0=0, x1=l.x, y0=0, y1=l.y, col="grey40", length=0.15, lwd=1.5)

# Get individuals as a matrix
mmatrix <- matrix(c(pca$x[,1], pca$x[,2]), ncol=2)
# Calculate correlations
c1 <- cor(matrix)

# Plot ellipse
polygon(ellipse(c1*(max(abs(pca$rotation))*1), centre=colMeans(tab), level=0.95), col=adjustcolor("grey40", alpha.f=0.25), border="grey40")

