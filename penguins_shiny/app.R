
# Attach Packages

library(shiny)
library(tidyverse)
library(palmerpenguins)

# Create the user interface
ui<- fluidPage(
    titlePanel("I am adding a TITLE!"),
    sidebarLayout(
        sidebarPanel("put my widgets here",
                     radioButtons(inputId = "penguin_species",
                                  label = "Choose penguin species:",
                                  choices = c("Adelie","cool chinstraps" = "Chinstrap", "Gentoo"))
                     ),
        mainPanel("here is my graph",
                  plotOutput(outputId = "penguin_plot"))
    )
)

#create the server function
server <- function(input, output){

    penguin_select <- reactive({
        penguins %>%
            filter(species == input$penguin_species)
    })

    output$penguin_plot <- renderPlot({
        ggplot(data = penguin_select(), aes(x = flipper_length_mm, y = body_mass_g))+
            geom_point()

    })

}

# Combine these into an app
shinyApp(ui = ui, server = server)

