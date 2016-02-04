tabPanel("Data",
         fluidRow(
           column(width=2,
                  h3("Load data")
           ),
           column(width=2,
                  fileInput('file', 'in CSV File')
           ),
           column(width=1,
                  checkboxInput(inputId="header",
                                label = "Header",
                                value=TRUE)
           ),
           column(width=2,
                  textInput(inputId="na.strings",
                            label = "Missing data",
                            value="NA")
           ),
           column(width=2,
                  selectInput(inputId="sep",
                              label = "Column separator",
                              choices =c(";",".","tab",","), 
                              selected = ",")
           ),
           column(width=2,
                  selectInput(inputId="dec",
                              label = "Decimal separator",
                              choices =c(".",","), 
                              selected = ".")
           )
         ),#fluidRow
         fluidRow(
           column(width=2,
                  h3("Select subset")
           ),
           column(width=3,
                  selectInput("subsetvar","subset based on variable:",
                              choices=c("none",colnames(data)),
                              selected="none")
           ),#column
           column(width=3,
                  selectInput("subsetlev","subset individuals with value",
                              choices=c(""),
                              selected=c(""))
           )#column
         ),#fluidRow
         fluidRow(
           column(width=2,
                  h3("X variable")
           ),
           column(width=3,
                  selectInput("xvar","x coordinate",
                              choices=c("none"),
                              multiple=FALSE,
                              selected="none")
           ),
           column(width=3,
                  sliderInput("xrange","x-range",
                              min=1,max=1000,value=c(1,1000),step=1)
           )
         ),#fluidRow
         fluidRow(
           column(width=2,
                  h3("Descriptors")),
           column(width=5,
                  selectInput("var","descriptors",
                              choices=c(""),
                              multiple=TRUE,
                              selected="")
           )
         )#fluidRow
)#tabPanel