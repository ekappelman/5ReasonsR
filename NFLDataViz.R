library(mongolite)
library(ggplot2)
running_backs = mongo(collection = "2016RunningBacks", db = "NFLPlayers")
df <- running_backs$find(fields='{"_id":0,"Att":1,"Att/G":1,
                         "Yds":1,"Yds/G":1,"TD":1,"1st":1,"FUM":1}')
df[1:7] <- apply(df[,1:7],c(1,2),function(x){gsub(",","",x)})
df[1:7] <- apply(df[,1:7],c(1,2),as.numeric)
lmod <- lm(`Yds/G`~`FUM`,data=df)
plot(lmod)
ggplot(df,aes(x=`Yds/G`,y=`FUM`))+
  geom_point(aes(color = `1st`,size=TD))+
  geom_smooth()+
  labs(x = "Yards per Game",y ="Fumble",title = "Yards per Game and Fumbles")

