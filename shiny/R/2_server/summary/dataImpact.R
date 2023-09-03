## Reactive impact data

## reactives in this file:
## 1. deciledata_c
## 2. age5yrsdata_c
## 3. caption_text_c

# summary data
deciledata_c <- eventReactive(input$run_b, {

  data1 <- deciledata()
  data1$Scenario <- "Scenario A"
  data2 <- deciledata_b()
  data2$Scenario <- "Scenario B"
  
  deciledata <- bind_rows(data1, data2)

  return(deciledata)
})  

age5yrsdata_c <- eventReactive(input$run_b, {

  data1 <- age5yrsdata()
  data1$Scenario <- "Scenario A"
  data2 <- age5yrsdata_b()
  data2$Scenario <- "Scenario B"
  
  age5yrsdata <- bind_rows(data1, data2)
  
  for (i in c("A", "matA", "childA", "disabA", "oldA", "B")) {
    age5yrsdata[[paste0("pov_reduction_", i)]] = (age5yrsdata[[paste0("meanpov")]] - age5yrsdata[[paste0("meanpov_", i)]])*100/age5yrsdata[[paste0("meanpov")]]
    age5yrsdata[[paste0("gap_reduction_", i)]] = (age5yrsdata[[paste0("meangap")]] - age5yrsdata[[paste0("meangap_", i)]])*100/age5yrsdata[[paste0("meangap")]]
  }
  
  return(age5yrsdata)
})

hhtypedata_c <- eventReactive(input$run_b, {
  
  data1 <- hhtypedata()
  data1$Scenario <- "Scenario A"
  data2 <- hhtypedata_b()
  data2$Scenario <- "Scenario B"
  
  hhtypedata <- bind_rows(data1, data2)
  
  return(hhtypedata)
})


caption_text_c <- reactive({
  database1 <- paste0(datasetsSurveys[[param$country]])
  database2 <- paste0(datasetsSurveys[[param_b$country]])
  if (database1==database2) {
    caption_text = paste0("<em>Notes</em>: ESCAP calculations based on ",
                          database1,
                          ".")
  } else {
    caption_text = paste0("<em>Notes</em>: ESCAP calculations based on ",
                          database1," and ", database2,
                          ".")
  }
  return(caption_text)
})
