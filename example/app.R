#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("CTA Ridership"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          selectInput("lines", label = h3("Select Train Line"), 
                      choices = list("Blue Line" = "BLUE", 
                                     "Red Line" = "RED", 
                                     "Pink Line" = "Pnk",
                                     "Orange Line" = "O",
                                     "Brown Line" = "BRN",
                                     "Green Line" = "G",
                                     "Purple Line" = "P",
                                     "Yellow Line" = "Y"), 
                      selected = "RED"),
          dateRangeInput("dates", label = h3("Date range"), 
                         start = ymd("2002-09-19"), end = ymd("2016-10-30"))
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  cta_rides <- read_csv("cta_rides.csv")
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
       subset <-  cta_rides %>% 
        filter(line %in% input$lines) %>% 
         mutate(date = mdy(date)) %>% 
         filter(date > input$dates[1] & date < input$dates[2])
       
       
        ggplot(subset, aes(daytype, rides, fill = line)) +
        geom_boxplot() +
        scale_fill_manual(values = setNames(subset$color, subset$line))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
