library(shiny)

# Code executed once
# Creating the prediction models
myData <- ChickWeight

# Using a weight = expx(a*Time+b) model
myData$logWeight <- log(myData$weight)

# One model per Diet
mod <- list(lm(logWeight~Time, data = subset(myData, Diet=="1")),
            lm(logWeight~Time, data = subset(myData, Diet=="2")),
            lm(logWeight~Time, data = subset(myData, Diet=="3")),
            lm(logWeight~Time, data = subset(myData, Diet=="4")))

# ShinyServer code

shinyServer(
  function(input, output) {
    
    # This part is needed for 2 render* function calls
    # Use reactive to execute it only once
    pred <- reactive({
      DFtoFit <- data.frame(Time=c(as.numeric(input$id_time)))
      exp(predict( mod[[as.integer(input$id_diet)]], newdata = DFtoFit)[1])
      
    })
    
    # Display the numeric result
    output$prediction <- renderText({
        round(pred(), digits =0)
    })
    
    # Display a yellow circle, which radius is the prediction
    output$circle <- renderPlot({
      r <- pred()
      if(r > 0) {
        x <- seq(from=0, to=r, by=0.1)
        y <- sqrt(r^2 - x^2)
        x <- c( -sort(x, decreasing = TRUE), x, sort(x, decreasing = TRUE), -x)
        y <- c( sort(y), y, -sort(y), -y)
        plot(x,y, xlim = c(-400,400), ylim=c(-400,400), 
            type='n', asp = 1, ann=FALSE,
            xaxt='n', yaxt='n')
        polygon(x,y, col = 'yellow', border = NA)
      }
      
    })
  }
)