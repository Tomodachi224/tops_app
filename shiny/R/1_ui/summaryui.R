tagList(
  h2("Summary of the results"),
  p("This tab compares the results between Scenarios A and B. It highlights the main impacts for the programmes selected in each scenario built, and then it compares the costs. The results will only be shown if programmes in Scenario B are selected and 'GO' is pressed."),
  ######## TABS
  div(id = "tabsetpanel_c",
      h5(tags$b("Select set of results")),
  tabsetPanel(
    id = "navbar_c",
    type = "tabs",
    
    ###### Combined
    tabPanel(
      title = "Combined",
      value = "combined_tab_c",
      br(),
      column(
        12,
        p("Below in separate tabs are the estimated annual costs and simulated impacts of all programmes combined across both scenarios."),
        br()
      )
      ,
      topTabUI_c("A_c")
    ),
    
    ###### Maternity benefit
    tabPanel(
      title = "Maternity Benefit",
      value = "matbenefit_tab_c",
      br(),
      column(
        12,
        p("Below in separate tabs are the estimated annual costs and simulated impacts of the Maternity Benefit programme across both scenarios."),
        br()
      ),
      topTabUI_c("matA_c")
    ),
    
    ###### Child benefit
    tabPanel(
      title = "Child Benefit",
      value = "childbenefit_tab_c",
      br(),
      column(
        12,
        p("Below in separate tabs are the estimated annual costs and simulated impacts of the Child Benefit programme across both scenarios."),
        br()
      ),
      topTabUI_c("childA_c")
    ),
    
    ###### Disability benefit
    tabPanel(
      title = "Disability Benefit",
      value = "disabilitybenefit_tab_c",
      br(),
      column(
        12,
        p("Below in separate tabs are the estimated annual costs and simulated impacts of the Disability Benefit programme across both scenarios."),
        br()
      ),
      topTabUI_c("disabA_c")
    ),
    
    ###### Old age benefit
    tabPanel(
      title = "Old Age Benefit",
      value = "oldagebenefit_tab_c",
      br(),
      column(
        12,
        p("Below in separate tabs are the estimated annual costs and simulated impacts of the Old Age Benefit programme across both scenarios."),
        br()
      ),
      topTabUI_c("oldA_c")
    ),
    
    ###### Household benefit
    tabPanel(
      title = "Household Benefit",
      value = "hhbenefit_tab_c",
      br(),
      column(
        12,
        p("Below in separate tabs are the estimated annual costs and simulated impacts of the Household Benefit programme across both scenarios."),
        br()
      ),
      topTabUI_c("B_c")
    )
  )) %>% shinyjs::hidden(),
  
  conditionalPanel(
    condition = "input.run_b != 0",
  div(
    id = "footer_main",
    extendShinyjs("www/app-shinyjs.js", functions = c("return")),
    p(
      "For more information on calculations see documentation ",
      actionLink("link_to_about_c", "here."), 
      "Return to the top", 
      actionLink("return_c", "here.")
    )
  )
  )
)