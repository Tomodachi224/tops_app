###Server functions for Summary

#Programme names
tabfullname_c <- list(
  A = "of all programmes combined",
  matA = "of the Maternity Benefit programme",
  childA = "of the Child Benefit programme",
  disabA = "of the Disability programme",
  oldA = "of the Old Age programme",
  B = "of the Household Benefit programme"
)

# costs
source("./R/2_server/summary/dataCosts.R", local = TRUE)

# impact
source("./R/2_server/summary/dataImpact.R", local = TRUE)

## Tabs
observeEvent(input$run_b, {  
  lapply(c("A", "matA", "childA", "disabA", "oldA", "B"), function(i) {
    callModule(topTab_c, paste0(i, "_c"), tab_c = i,
               costs_data_c, 
               caption_text_c, 
               deciledata_c,
               age5yrsdata_c,
               hhtypedata_c,
               impact_data,
               impact_data_b)
  })
})

