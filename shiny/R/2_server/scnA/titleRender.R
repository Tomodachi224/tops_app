### TITLE ####

titletext <- reactiveValues()
titletext$title <- paste0("Social Protection Simulator")

observeEvent(input$run, {
  titletext$title <- paste0("Social Protection Simulator: ", param$country)
})
output$title <- renderText({
  text <- titletext$title
  return(text)
})