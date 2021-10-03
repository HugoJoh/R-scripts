#install relevant packages
install.packages("ggplot2")
library(ggplot2)
install.packages("stats")
library("stats")
install.packages("readxl")
library("readxl")
install.packages("dplyr")
library("dplyr")
install.packages("writexl")
library("writexl")

# read the input file
data <- read_excel("File path\\File name.xlsx")
data <- data.matrix(data, rownames.force = NA)
is.data.frame(data)

# compute sds and means of the df
means <- colMeans(data, na.rm = TRUE)
sds <- apply(data, 2, sd, na.rm = TRUE)

# auto-scale data
ASdata <- matrix(NA, nrow = 10, ncol = 3)
for (j in 1:3){
  for (i in 1:10){
    ASdata[i,j] <- (data[i,j]-means[j])/sds[j]
  }
}

# reshaping data
X1mean <- mean(replace(means, c(1), NA), na.rm = TRUE)
X1sd <- sd(replace(sds, c(1), NA), na.rm = TRUE)
print(X1mean)
print(X1sd)

X2mean <- mean(replace(means, c(2), NA), na.rm = TRUE)
X2sd <- mean(replace(sds, c(2), NA), na.rm = TRUE)
print(X2mean)
print(X2sd)

X3mean <- mean(replace(means, c(3), NA), na.rm = TRUE)
X3sd <- mean(replace(sds, c(3), NA), na.rm = TRUE)
print(X3mean)
print(X3sd)

NX1sd <- s1
NX1mean <- m1 

NX2sd <- s2
NX2mean <- m2

NX3sd <- s3
NX3mean <- m3

NEWdata <- matrix(NA, nrow = 10, ncol = 3)
for (j in 1:1){
  for (i in 1:10){
    NEWdata[i,j] <- ASdata[i,j]*NX1sd+NX1mean
  }
}

for (j in 1:2){
  for (i in 1:10){
    NEWdata[i,j] <- ASdata[i,j]*NX2sd+NX2mean
  }
}

for (j in 1:3){
  for (i in 1:10){
    NEWdata[i,j] <- ASdata[i,j]*NX3sd+NX3mean
  }
}

#Save the output file
NEWdata <- data.frame(NEWdata)
write_xlsx(NEWdata,"File path\\File name.xlsx")
