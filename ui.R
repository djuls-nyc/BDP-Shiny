library(shiny)

shinyUI(
  
  fluidPage(
  
  
    # Application Title
    titlePanel("Chick Weight Prediction"),
    
    # How to use / Description
    fluidRow(
        mainPanel(
            h4("Description / Documentation:"),
            br("This shiny app is using the ChickWeight R dataset
                which results from an experiment on the effect of
                  different diets on early growth of chicks."),
            br("We have used machine learning algorithms to predict
                the weight of chicks with respect to age and diet."),
            br("You can select below the type of diet and the age in
                days. Predicted weight will be displayed on the right."),
            br("The size of the yellow circle is linked to the predicted
                weight and is there for fun - check the play button on
                  the slidebar !"),
            br()
        )
    ),
    
    # Sidebar with Buttons and slider inputs
    sidebarPanel(
      h4("Parameters selection :"),
      br(),br(),
      radioButtons("id_diet", "Experimental diet",
                       c("Diet 1" = "1",
                         "Diet 2" = "2",
                         "Diet 3" = "3",
                         "Diet 4" = "4"),
                       selected = "1"),
      br(),br(),
      sliderInput("id_time", "Age in days",value = 0, min = 0, max = 21, step = 1,
                animate=animationOptions(interval=300, loop=F))
    ),
    
    # main panel that displays results
    mainPanel(
      h4("Predicted weight in grams:"), 
      verbatimTextOutput("prediction"),
      plotOutput("circle")
    )
  )
)

