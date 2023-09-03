## Modules for top tabs

topTabUI_c <- function(id) {
  ns <- NS(id)
  
  tagList(
    h5(tags$b("Select type of results")),
    tabsetPanel(
      id = "testcss",
      type = "tabs",
      ###### IMPACTS TABS
      tabPanel(
        "Coverage",
         covImpactUI_c(ns("covOutputs"))
      ),
      tabPanel(
        "Household consumption",
        expImpactUI_c(ns("expOutputs"))        
      ),
      tabPanel(
        "Poverty and inequality",
        povImpactUI_c(ns("povOutputs"))
      ),
      ###### COSTS TAB
      tabPanel(
        "Costs",
        h3("Costs"),
        costTabUI_c(ns("costOutputs"))
        )
      )
    )
}

topTab_c <- function(input, output, session, tab_c = "A",
                                           costs_data_c,
                                           caption_text_c, 
                                           deciledata_c,
                                           age5yrsdata_c,
                                           hhtypedata_c,
                                           impact_data,
                                           impact_data_b) {


  toptab_c <- tab_c
  
  # Coverage
  callModule(covImpact_c, "covOutputs", toptab_c, caption_text_c, deciledata_c, hhtypedata_c)

  # Consumption expenditure
  callModule(expImpact_c, "expOutputs", toptab_c, caption_text_c, deciledata_c, age5yrsdata_c)

  # Poverty and inequality
  callModule(povImpact_c, "povOutputs", toptab_c, caption_text_c, impact_data, impact_data_b)
  
  # # Costs
  callModule(costTab_c, "costOutputs", toptab_c, costs_data_c)

}
