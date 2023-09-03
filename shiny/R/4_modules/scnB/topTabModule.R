## Modules for top tabs

topTabUI_b <- function(id) {
  ns <- NS(id)
  
  tagList(
    h5(tags$b("Explore results by outcome type")),
    tabsetPanel(
      id = "testcss",
      type = "tabs",
      ###### IMPACTS TABS
      tabPanel(
        "Coverage",
         covImpactUI_b(ns("covOutputs"))
      ),
      tabPanel(
        "Household consumption",
        expImpactUI_b(ns("expOutputs"))        
      ),
      tabPanel(
        "Poverty and inequality",
        povImpactUI_b(ns("povOutputs"))
      ),
      ###### COSTS TAB
      tabPanel(
        "Costs",
        h3("Costs"),
        costTabUI_b(ns("costOutputs")),
        finTabUI_b(ns("finOutputs"))
        )
      )
    )
}

topTab_b <- function(input, output, session, tab_b = "A",
                                           tabfullname_b,
                                           costs_data_b, 
                                           plot_cost_prog_b, 
                                           impact_data_b, 
                                           caption_text_b, 
                                           fin_data_b,
                                           govfin_b,
                                           econ_b, 
                                           param_b,
                                           deciledata_b,
                                           age5yrsdata_b,
                                           hhtypedata_b,
                                           totaldata_b,
                                           exclusionerrors_b) {

  toptab_b <- tab_b
  
  # Coverage
  callModule(covImpact_b, "covOutputs", toptab_b, caption_text_b, param_b, deciledata_b, age5yrsdata_b, hhtypedata_b, totaldata_b, impact_data_b, exclusionerrors_b)

  # Consumption expenditure
  callModule(expImpact_b, "expOutputs", toptab_b, caption_text_b, param_b, deciledata_b, age5yrsdata_b, hhtypedata_b, totaldata_b)

  # Poverty and inequality
  callModule(povImpact_b, "povOutputs", toptab_b, impact_data_b, caption_text_b, age5yrsdata_b)
  
  # Costs
  callModule(costTab_b, "costOutputs", toptab_b, tabfullname_b, costs_data_b, fin_data_b, plot_cost_prog_b, econ_b, param_b)
  
  # Affordability
  callModule(finTab_b, "finOutputs", toptab_b, tabfullname_b, costs_data_b, fin_data_b, govfin_b, econ_b, caption_text_b, param_b)
  
}
