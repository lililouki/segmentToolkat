shinyServer(function(input, output, session) {
source("scripts/server_data.R",local=TRUE)
source("scripts/server_clustering.R",local=TRUE)
source("scripts/server_info.R",local=TRUE)

output$uiWeights=renderUI({
  w=c()
  if(input$clustype=="naive"){
    w=paste0(w,
             sliderInput(paste0("w_x"),
                         "spatial constraint",
                         value=1,min=1,max=10,step=1))
  }
  vars=input$var
  for (i in 1:length(vars)){
    w=paste0(w,
             sliderInput(inputId=paste0("w_",input$var[i]),
                         label=input$var[i],
                         value=1,min=1,max=10,step=1))
  }
  HTML(w)
})


##################################################################
observe({
  fprint("in 1st oberve")
  data=fdata()
  updateSelectInput(session,"subsetvar",
                    choices=c("none",as.vector(colnames(data))),
                    selected="none") 
  updateSelectInput(session,"subsetlev",
                    choices=c(""),
                    selected="") 
  updateSelectInput(session,"var",
                    choices=colnames(data),
                    selected=colnames(data)[1])
  updateSelectInput(session,"xvar",
                    choices=c("none",colnames(data)),
                    selected="none")
})
observe({ 
  fprint("in 2nd observe")
  subsetvar=input$subsetvar
  data=isolate(fdata())
  if(subsetvar=="none"){
    updateSelectInput(session, "subsetlev",
                      choices=c(""),
                      selected="")
  }
  if(subsetvar!="none"){
    var=data[[subsetvar]]
    lev=sort(unique(as.vector(var)))
    updateSelectInput(session, "subsetlev",
                      choices=lev,
                      selected=lev[1])
  }
})

observe({
  fprint("in 3rd observe")
  subsetvar=input$subsetvar
  subsetlev=input$subsetlev
  dat=isolate(fdata())
  data_s=isolate(fdata_s())
  var=data_s[[subsetvar]]
  
  if(subsetlev!=""){
    updateSliderInput(session, "xrange",
                      value=c(1,length(which(var==subsetlev))),
                      max=length(which(var==subsetlev)))
  }
  if(subsetlev=="" & subsetvar=="none"){
    updateSliderInput(session, "xrange",
                      value=c(1,1000),
                      max=nrow(dat))
  }
})
}
)