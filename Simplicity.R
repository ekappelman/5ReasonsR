library(ggplot2)

ydata <- sample(c(1:100),10000,replace=T)
xdata <- sample(c("Erik","Cooper","Stewart"),10000,replace = T)
zdata <- sample(c("Red","Blue","Green","Yellow","Orange"),10000,replace = T,
                prob=c(0.4,0.2,0.25,0.1,0.05))
df <- data.frame(Marbles=ydata,Person=xdata,Color=zdata)

ggplot(df,aes(x=Person,fill=Color))+
  geom_bar(position="dodge")
