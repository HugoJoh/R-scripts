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
install.packages('excel.link')
library(excel.link)

# read the input file & add relevant dates
d1 <- read.csv("C:\\Users\\chloe\\Documents\\Hugo\\R\\data-DNbCC.csv")
d1 <- cbind(d1, Date = c('25NOV2021'))
d2 <- read.csv("C:\\Users\\chloe\\Documents\\Hugo\\R\\data-DNbCC2.csv")
d2 <- cbind(d2, Date = c('01DEC2021'))

#join data sets & renaming columns
data <- merge(d1,d2,all=TRUE)
data <- rename(data, 'Age'='ï..Classe.d.Ã.ge', 'Décès'='DÃ.cÃ.s')
age <- data[,1]
death <- data[,3]
date <- data[,4]

#plot data
# plot <- ggplot(data, aes(x=age, y=death), ylim(min, max)) + geom_point(aes(group=date, color=date)) + geom_line(aes(group=date, color=date))
plot <- ggplot(data, aes(age, death, group=date, color=date, fill=date)) + geom_col(position = "dodge") + labs(title ="Deaths = f(Age)")
print(plot)

#save the graph in an excel output file
xl.workbook.add(filename = 'Covid report')
print(plot)
plot=current.graphics()
xl[a1] = plot

