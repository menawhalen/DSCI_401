#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(tidyverse)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("CTA Train Ridership"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          # selectInput(
          #   "time_select",
          #   "Select Temporal options below:",
          #   list("Day of Week" = "1A", "Season" = "1B", "Month" = "1C", "Year" = "1D")
          # ),
          # selectInput(
          #   "central_select",
          #   "Select central options below:",
          #   list("Mean" = "mean", "Median" = "1B", "Mode" = "1C")
          # ),
          checkboxGroupInput( 
            "line", 
            "Train line to Select", 
            c( 
              "Blue" = "BLUE", 
              "Red" = "RED", 
              "Pink" = "Pnk",
              "Orange" = "O",
              "Brown" = "BRN",
              "Green" = "G",
              "Purple" = "P",
              "Yellow" = "Y"
            ) 
          )
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  dat <- read_csv("cta_rides.csv")
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
      # input$time_select
      # input$central_select
      # input$line
      subset <- dat %>% 
        filter(line %in% input$line) %>% 
        group_by(line, color, daytype) %>% 
        summarise(median = median(rides))%>% 
        filter(!is.na(line))
      
      ggplot(subset,aes(daytype, median, fill =line)) +
        geom_bar(stat = "identity", position = "dodge") +
        scale_fill_manual(values = setNames(subset$color, subset$line))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
