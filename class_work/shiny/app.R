library(shiny)
library(tidyverse)

data("faithful")

ui <- fluidPage(
  titlePanel("Eruptions"),
  sidebarLayout(position = "left",
                sidebarPanel(
                  selectInput("n_breaks", label = "Number of Bins:",
                              choices = c("10" = "10",
                                          "20" = "20",
                                          "30" = "30")),
                  sliderInput("bw_adjust", label = "Bandwidth Adjustment:",
                              min = 0.2, 
                              max = 2, 
                              value = 1, 
                              step = 0.2)),
                mainPanel(
                  plotOutput(outputId = "histogram")
                )
  )
)

server <- function(input, output) {
  
  output$histogram <- renderPlot({
    
    faithful |>
      ggplot(aes(x = eruptions)) +
      geom_histogram(aes(y= after_stat(density)), 
                     bins = as.numeric(input$n_breaks),
                     fill = "lightgrey", color = "black") +
      geom_density(alpha = .2, color = "blue", adjust = input$bw_adjust) +
      labs(title = "Geyser eruption duration",
           x = "Duration (minutes)")
    
  }
    
  )
}

shinyApp(ui = ui, server = server)