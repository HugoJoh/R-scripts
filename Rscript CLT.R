install.packages('UsingR')
library(UsingR)
data<-iris

install.packages('dplyr')
library(dplyr)
PetLen<-select(data,Petal.Length)%>%unlist

set.seed(1)
means<-vector('numeric',1)
for(i in 1:100){
  means[i]<-mean(sample(PetLen,12))
}

vector<-c(1, 3, 5, 8, 15, 30, 50, 70, 100)
breaksvector<-c(seq(from=2,to=6,by=0.5))
par(mfrow=c(3,3))
for(i in vector){
  hist(means[1:i],xlab='',main = paste("Histogram of" , i),breaks=breaksvector)
}

mean(PetLen)
sd(means[1:2])/sqrt(12)

mean(means[1:5])
