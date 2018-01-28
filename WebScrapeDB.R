library(httr)
library(xml2)
library(mongolite)
resp <- GET('http://www.nfl.com/stats/categorystats?tabSeq=1&statisticPositionCategory=RUNNING_BACK&season=2016&seasonType=REG')
nfltext <- content(resp,as="text")
rad <- read_html(nfltext)
trs <- xml_find_all(rad, ".//tr")
colNames <- xml_text(xml_children(trs[1]),trim = T)
mat <- matrix(nrow = length(trs) - 1,ncol = length(colNames))
for(i in 2:length(trs)){
  child <- xml_children(trs[i])
  mat[i-1,]<- xml_text(child,trim=T)
}
df <- data.frame(mat)
colnames(df) <- colNames
running_backs = mongo(collection = "2016RunningBacks", db = "NFLPlayers")
running_backs$insert(df)
running_backs$count()
running_backs$iterate()$one()
