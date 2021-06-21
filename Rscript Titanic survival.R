install.packages('tidyverse')
install.packages('titanic')
options(digits = 3)    # report 3 significant digits
library(tidyverse)
library(titanic)
library(ggplot2)

titanic <- titanic_train %>% select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare) %>% mutate(Survived = factor(Survived),Pclass = factor(Pclass),Sex = factor(Sex))

#1 First look at the data
?titanic_train
head(titanic_train)

#2 Demographics of Titanic Passengers
titanic %>% group_by('Sex') %>% ggplot(aes(Age,..count..,color=Sex)) + geom_density()

#3 QQ-plot of Age Distribution
params <- titanic %>% filter(!is.na(Age)) %>% summarize(mean = mean(Age), sd = sd(Age))
titanic %>% ggplot(aes(sample=Age)) + geom_qq(dparams=params) + geom_abline()

#4 Survival by Sex
titanic %>% ggplot(aes(Survived,fill=Sex)) + geom_bar(position = position_dodge())

#5 Survival by Age
titanic %>% ggplot(aes(Age,..count..,fill=Survived,alpha=0.2)) + geom_density()

#6 Survival by Fare
titanic %>% filter(Fare!=0) %>% group_by(Survived) %>% ggplot(aes(Survived,Fare)) + geom_boxplot() + scale_y_continuous(trans='log2') + geom_jitter(alpha=0.2)

#7 Survival by Passenger Class
titanic %>% ggplot(aes(Pclass,fill=Survived)) + geom_bar(position = position_dodge())
titanic %>% ggplot(aes(Pclass,fill=Survived)) + geom_bar(position = position_fill())
titanic %>% ggplot(aes(Survived,fill=Pclass)) + geom_bar(position = position_fill())

#8 Survival by Age, Sex and Passenger Class
titanic %>% ggplot(aes(Age,..count..,fill=Survived)) + geom_density() + facet_grid(rows=vars(Sex),cols=vars(Pclass))
