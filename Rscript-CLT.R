install.packages('UsingR')
library(UsingR)
data(nym.2002)
data<-nym.2002

install.packages('dplyr')
library(dplyr)
Ages<-select(data,age)%>%unlist

set.seed(1)
means<-vector('numeric',1)
for(i in 1:1000){
  means[i]<-mean(sample(Ages,12))
}

vector<-c(10, 30, 50, 70, 100, 300, 500, 700, 1000)
par(mfrow=c(3,3))
for(i in vector){
  hist(means[1:i],xlab='',main = paste("Histogram for" , i))
}

mean(Ages)
sd(Ages)/sqrt(12)
