fdata=reactive({
  fprint("in fdata")
  datapath=input$file$datapath
  if(!is.null(datapath)){
    data=read.csv(file, 
                  header=input$header,
                  sep=input$sep, 
                  dec=input$dec,
                  na.strings=input$na.strings)
  }
  if(is.null(datapath)){
    data(RLGH)
    data=RLGH$spec
    print(head(data))
  }
  data=as.data.frame(data)
}
)
fsubsetvar=reactive({
  print(input$subsetvar)
  return(input$subsetvar)
})
fsubsetlev=reactive({
  print(input$subsetlev)
  return(input$subsetlev)
})
#################################################
fdata_s=reactive({
  fprint("in fdata_s")
  data=fdata()
  gsubsetvar=input$subsetvar  
  gsubsetlev=input$subsetlev
  ## subset
  ind=1:nrow(data)
  if(gsubsetvar!="none" & gsubsetlev!=""){
    ind=which(data[[gsubsetvar]]==gsubsetlev)
  }
  dat=as.data.frame(data[ind,1:ncol(data)])
  colnames(dat)=colnames(data)
  data=dat
  return(data)
})
fdata_sr=reactive({
  "in fdata_sr"
  data=isolate(fdata_s())
  xrange=input$xrange
  xvar=input$xvar
  ## range
  ind=xrange[1]:xrange[2]
  dat=as.data.frame(data[ind,1:ncol(data)])
  colnames(dat)=colnames(data)
  data=dat
  ## xvar
  if(xvar=="none") x=1:length(ind) else x=data[[xvar]]
  data=data.frame(x=x,data)
  data=data[order(x),]
  return(data)
})

#################################################
fvar=reactive({
  fprint("in fvar")
  data_s=fdata_s()
  var=data_s[,input$var]
  var=as.data.frame(var)
  colnames(var)=input$var
  return(var)
})
