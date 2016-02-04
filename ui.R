fluidPage(
  h3("The Segment ToolKat"),
  h6("L.Vaudor, ISIG, UMR 5600"),
  tabsetPanel(
    source("scripts/ui_data.R")$value,
    source("scripts/ui_clustering.R")$value,
    source("scripts/ui_graphic_options.R")$value
  )#tabsetPanel
)