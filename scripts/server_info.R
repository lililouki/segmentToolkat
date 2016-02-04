output$i_clustering=renderUI({
  if(input$i_clustering%%2!=0){
    wellPanel(includeHTML("i_clustering.html"))
  }
})
