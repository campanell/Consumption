
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(ggvis)

fluidPage(sidebarLayout(
  sidebarPanel(
    checkboxGroupInput("country", "Select Country:",c("United States of America", "European Union","China"),selected="United States of America"),
    uiOutput("plot_ui")
  ),
  mainPanel(
    ggvisOutput("plot")
  )
))



