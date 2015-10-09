
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#


#-------------------------------------------------------------------------------------#
#   Consumption Graph                                                                 #
#-------------------------------------------------------------------------------------#

library(shiny)
library(dplyr)
library(tidyr)
library(ggvis)


#==========================================================================================#
#   Section 3: Visulizations with ggvis                                                    #
#==========================================================================================#

#-----------------------------------------------------------------------------------------#
#   Country grouping for checkbox                                                         #
#-----------------------------------------------------------------------------------------#
country_select <- c("United States of America", "European Union","China")

#---------------------------------------------------------------------------------------#
#    Consumption data                                                                   #
#---------------------------------------------------------------------------------------#
consumption <- read.csv("consumption.csv")
consumption$year <- as.character(consumption$year)


#===========================================================================================#
#   Section 2:  Build analysis data sets for the top producers: China, EU, USA              #
#===========================================================================================#


function(input, output, session) {
  consumption_graph <-reactive(filter(consumption,country %in% input$country))
  
  consumption_graph  %>%  group_by(country) %>% ggvis(~year, ~kg, stroke = ~factor(country)) %>%  
      scale_ordinal("stroke", range = c("#c785a5", "#ffd86e", "#83c4d4"), domain = country_select) %>%
      layer_paths(strokeWidth := 5)  %>% 
      add_axis("x",subdivide=4, values = seq(1960, 2013, by = 5), title = 'Year') %>%
      add_axis("y", title = 'Consumption (kg/capita)', title_offset = 50)  %>%
      add_legend(scales="stroke",title="")  %>%
      bind_shiny("plot", "plot_ui")
}

