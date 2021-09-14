#install relevant packages
install.packages("ggplot2")
library(ggplot2)
install.packages("stats")
library("stats")
install.packages("readxl")
library("readxl")
install.packages("dplyr")
library("dplyr")
install.packages('lhs')
library(lhs)
install.packages("writexl")
library("writexl")

#Read the input file
data<-read_excel("S:\\Hugo\\Perso\\HugoR\\Wine data for MC.xlsx")
vX<-unlist(data[1])
vY<-unlist(data[2])

#Checking that the predictor is normally distributed
mX <- mean(vX)
sdX <- sd(vX)
range(vX)
par(mfrow=c(1,2))
hist(vX, xlab="Sr", freq=FALSE)
curve(dnorm(x,mean=mX,sd=sdX), add=TRUE, col="red")
hist(vY)

#create the LR model
LR = lm(Aroma~Sr, data = data)
summary(LR)

#Do the MC simulations for the predictors and use the linear regression model to generate y data and plot the results
runs <- 100
Sr <- rnorm(runs,mean=mX,sd=sdX)
ggplot(data.frame(Sr), aes(Sr)) + geom_histogram()
Aroma <- append(vY, (Sr*LR$coefficients[2]+LR$coefficients[1]))
Sr <- append(vX, rnorm(runs,mean=mX,sd=sdX))
df<-data.frame(Sr, Aroma)
LRafterMC = lm(Aroma~Sr, data = df)
summary(LRafterMC)
RatioAdjR2<-summary(LRafterMC)$adj.r.squared/summary(LR)$adj.r.squared
print(RatioAdjR2)

#Do the LHS simulations for the predictors and use the linear regression model to generate y data and plot the results
runs <- 100
Sr <- randomLHS(runs,1)
ggplot(data.frame(Sr), aes(Sr)) + geom_histogram()
Aroma <- append(vY, (Sr*LR$coefficients[2]+LR$coefficients[1]))
Sr <- append(vX, randomLHS(runs,1))
df<-data.frame(Sr, Aroma)
LRafterMC = lm(Aroma~Sr, data = df)
summary(LRafterMC)
RatioAdjR2<-summary(LRafterMC)$adj.r.squared/summary(LR)$adj.r.squared
print(RatioAdjR2)

#Save the output file for MC
install.packages("writexl")
library("writexl")
print(df)
write_xlsx(df,"S:\\Hugo\\Perso\\HugoR\\Wine data after 100MCsim.xlsx")

#Save the output file for LHS
print(df)
write_xlsx(df,"S:\\Hugo\\Perso\\HugoR\\Wine data after 100LHSsim.xlsx")
