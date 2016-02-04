require(ggplot2)
require(gridExtra)
require(tabplot)
require(rioja)
#source("pack_Hubert.R")
iterprint=0
fprint<<-function(x){
  iterprint<<-iterprint+1
  print(paste0(iterprint,") ",x))
}