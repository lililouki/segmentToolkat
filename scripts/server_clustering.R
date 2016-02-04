
#################################################
ftree=reactive({
  fprint("in ftree")
  data_sr=fdata_sr()
  input=reactiveValuesToList(input)
  var=data_sr[,input$var]
  var=as.data.frame(var)
  colnames(var)=input$var
  dats=var
  # weighting
  dat=scale(dats,center=T)
  for (i in 1:ncol(dat)){
    name=colnames(dat)[i]
    name_w=paste0("w_",name)
    if(is.null(input[[name_w]])) weight=1 else weight=input[[name_w]]
    dat[,i]=dat[,i]*weight
  }
  
  if(input$clustype=="naive"){
    dat=data.frame(x=1:nrow(dat)*input[["w_x"]],dat)
    mydist=dist(dat)
    mytree=hclust(mydist)
  }
  if(input$clustype!="naive"){
    mydist=dist(dat)
    mytree=chclust(mydist,method=input$clustype)
  }
  return(mytree)
})

##############################################
plot_tree=function(){
  mytree=ftree()
  plot(mytree)
  h=mytree$height[length(mytree$height)-input$nclust+1:2]
  abline(h=mean(h), col="red")
}
output$plotTree=renderPlot({
  plot_tree()
},
height=function(x){input$height},
width=function(x){input$width}
)

##############################################
tab_clust=function(){
  mytree=ftree()
  fac=as.factor(cutree(mytree,k=input$nclust))
  datatmp=data.frame(fdata_sr(),fac)
  return(datatmp)
}

##############################################
plot_clust=function(){
  datatmp=tab_clust()
  plotlist=vector("list",length=0)
  for (i in 1:length(input$var)){
    varname=input$var[i]
    p=ggplot(data=datatmp,aes_string(x="x",y=varname))
    p=p+geom_line()
    p=p+geom_point(aes(colour=fac))
    plotlist=append(plotlist,list(p))  
  }
  do.call(grid.arrange,plotlist)
}

##############################################
output$plotClust=renderPlot({
  plot_clust()
},
height=function(x){input$height},
width=function(x){input$width}
)
