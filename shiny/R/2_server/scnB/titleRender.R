### TITLE ####

titletext_b <- reactiveValues()
titletext_b$title <- paste0("Social Protection Simulator")

observeEvent(input$run_b, {
  titletext_b$title <- paste0("Social Protection Simulator: ", param_b$country)
})
output$title_b <- renderText({
  text <- titletext_b$title
  return(text)
})