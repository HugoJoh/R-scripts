v <- c(unlist(data[,1]))

hist <- hist(v, breaks = seq(0.05,1.65,0.2)) # here breaks sequence is relevant to the dataset
freqs <- hist$counts/sum(hist$counts)
freqs2 <- c(freqs[1])
for(i in 1:7){
  freqs2 <- append(freqs2, freqs2[i]+freqs[i+1])
}
freqs2 <- freqs2[freqs2>0.05]
freqs2 <- freqs2[freqs2<0.95]
fithist <- lm(freqs2~hist$breaks[c(-1,-2,-9)])
plot(hist$breaks[c(-1,-2,-9)], freqs2)
meancalchist <- round((0.5-fithist$coefficients[1])/fithist$coefficients[2],2)
