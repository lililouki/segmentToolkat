
#################################################
output$plotHub=renderPlot({
  var=fvar()
  layout(matrix(1:ncol(var),nrow=ncol(var)))
  for(i in 1:ncol(var)){
    seg=Hubert_segmentation(var[,i],alpha=input$alpha)$locations
    plot(1:length(var[,i]),var[,i],type="l")
    ybis=model_signal(var[,i],seg)
    points(1:length(var[,i]),ybis,col="red",type="l")
  }
})

#################################################
fdatac=reactive({
  var=fvar()
  data=fdata_s()
  for (i in 1:ncol(var)){
    y=var[,i]
    quantiles=unique(quantile(y,seq(0,1,length.out=input$k+1), na.rm=T))
    k=length(unique(quantiles))-1
    fac=cut(y,
            breaks=quantiles,
            include.lowest=T,
            labels=1:k)
    data=data.frame(data,fac)
    colnames(data)[length(colnames(data))]=paste0(input$var[i],"_c")
  }
  return(data)
})

#################################################
output$plotFac=renderPlot({
  datac=fdatac()
  plotlist=vector("list",length=0)
  for (i in 1:length(input$var)){
    varname=input$var[i]
    varnamef=paste0(varname,"_c")
    p=ggplot(data=datac,aes_string(x="x",y=varname))
    p=p+geom_line()
    p=p+geom_point(aes_string(colour=varnamef))
    plotlist=append(plotlist,list(p))  
  }
  do.call(grid.arrange,plotlist)
})

#################################################
output$plotTab=renderPlot({
  datac=as.data.frame(fdatac())
  vars=paste0(input$var,"_c")
  x=1:nrow(datac)
  datatmp=data.frame(x,datac[,vars])
  tableplot(datatmp,nBins=input$nBins)
})
