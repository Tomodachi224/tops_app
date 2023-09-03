## Modules for top tabs

topTabUI <- function(id) {
  ns <- NS(id)
  
  tagList(
    h5(tags$b("Explore results by outcome type")),
    tabsetPanel(
      id = "testcss",
      type = "tabs",
      ###### IMPACTS TABS
      tabPanel(
        "Coverage",
         covImpactUI(ns("covOutputs"))
      ),
      tabPanel(
        "Household consumption",
        expImpactUI(ns("expOutputs"))        
      ),
      tabPanel(
        "Poverty and inequality",
        povImpactUI(ns("povOutputs"))
      ),
      ###### COSTS TAB
      tabPanel(
        "Costs",
        h3("Costs"),
        costTabUI(ns("costOutputs")),
        finTabUI(ns("finOutputs"))
        )
      )
    )
}

topTab <- function(input, output, session, tab = "A",
                                           tabfullname,
                                           costs_data, 
                                           plot_cost_prog, 
                                           impact_data, 
                                           caption_text, 
                                           fin_data,
                                           govfin,
                                           econ, 
                                           param,
                                           deciledata,
                                           age5yrsdata,
                                           hhtypedata,
                                           totaldata, 
                                           exclusionerrors) {

  toptab <- tab 
  
  # Coverage
  callModule(covImpact, "covOutputs", toptab, caption_text, param, deciledata, age5yrsdata, hhtypedata, totaldata, impact_data, exclusionerrors)

  # Consumption expenditure
  callModule(expImpact, "expOutputs", toptab, caption_text, param, deciledata, age5yrsdata, hhtypedata, totaldata)

  # Poverty and inequality
  callModule(povImpact, "povOutputs", toptab, impact_data, caption_text, age5yrsdata)
  
  # Costs
  callModule(costTab, "costOutputs", toptab, tabfullname, costs_data, fin_data, plot_cost_prog, econ, param)
  
  # Affordability
  callModule(finTab, "finOutputs", toptab, tabfullname, costs_data, fin_data, govfin, econ, caption_text, param)
  
}
