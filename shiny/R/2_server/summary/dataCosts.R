## Reactive cost and fin data

## reactives in this file:
## 1. costs_data_c
## 2. plot_cost_prog_c

costs_data_c <- eventReactive(input$run_b, {
  
  datamatA_a <- costs_data()[, c('year', 'costsmatA_gdp')]
  datamatA_a <- datamatA_a %>% rename(costs=costsmatA_gdp)
  datachildA_a <- costs_data()[, c('year', 'costschildA_gdp')]
  datachildA_a <- datachildA_a %>% rename(costs=costschildA_gdp)
  datadisabA_a <- costs_data()[, c('year', 'costsdisabA_gdp')]
  datadisabA_a <- datadisabA_a %>% rename(costs=costsdisabA_gdp)
  dataoldA_a <- costs_data()[, c('year', 'costsoldA_gdp')]
  dataoldA_a <- dataoldA_a %>% rename(costs=costsoldA_gdp)
  dataB_a <- costs_data()[, c('year', 'costsB_gdp')]
  dataB_a <- dataB_a %>% rename(costs=costsB_gdp)
  
  data_a <- bind_rows(datamatA_a, datachildA_a, datadisabA_a, dataoldA_a, dataB_a)
  data_a$prog <- rep(c("Maternity Benefit", "Child Benefit", "Disability Benefit", "Old Age Benefit", "Household Benefit"), each = 10)
  data_a$Scenario <- "Scenario A"
  data_a <- data_a[, c("year", "costs", "prog", "Scenario")]
  
  datamatA_b <- costs_data_b()[, c('year', 'costsmatA_gdp')]
  datamatA_b <- datamatA_b %>% rename(costs=costsmatA_gdp)
  datachildA_b <- costs_data_b()[, c('year', 'costschildA_gdp')]
  datachildA_b <- datachildA_b %>% rename(costs=costschildA_gdp)
  datadisabA_b <- costs_data_b()[, c('year', 'costsdisabA_gdp')]
  datadisabA_b <- datadisabA_b %>% rename(costs=costsdisabA_gdp)
  dataoldA_b <- costs_data_b()[, c('year', 'costsoldA_gdp')]
  dataoldA_b <- dataoldA_b %>% rename(costs=costsoldA_gdp)
  dataB_b <- costs_data_b()[, c('year', 'costsB_gdp')]
  dataB_b <- dataB_b %>% rename(costs=costsB_gdp)
  
  data_b <- bind_rows(datamatA_b, datachildA_b, datadisabA_b, dataoldA_b, dataB_b)
  data_b$prog <- rep(c("Maternity Benefit", "Child Benefit", "Disability Benefit", "Old Age Benefit", "Household Benefit"), each = 10)
  data_b$Scenario <- "Scenario B"
  data_b <- data_b[, c("year", "costs", "prog", "Scenario")]

  data <- bind_rows(data_a, data_b)
  
  data$prog <-
    factor(data$prog, levels = c("Maternity Benefit", "Child Benefit", "Disability Benefit", "Old Age Benefit", "Household Benefit"))
  
  data$Scenario <-
    factor(data$Scenario, levels = c("Scenario A", "Scenario B"))
  
  return(data)
})

plot_cost_prog_c <- eventReactive(input$run_b, {
  
  list <- list(
    scnA = plot_cost_prog(),
    scnB = plot_cost_prog_b()
  )
  return(list)
})
