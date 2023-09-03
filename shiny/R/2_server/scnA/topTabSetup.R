######## TABS
output$TopTabSetup <- renderUI({
  if (mparam$mat==TRUE && cparam$child==FALSE && dparam$disab == FALSE && oparam$old == FALSE && param$hh ==FALSE){
    ui <- tagList(
      tabsetPanel(
        id = "navbar",
        type = "tabs",
        
        ###### Maternity benefit
        tabPanel(
          title = "Maternity Benefit",
          value = "matbenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Maternity Benefit programme."),
            br()
          ),
          topTabUI("matA")
        ),
        
        ###### Child benefit
        tabPanel(
          title = "Child Benefit",
          value = "childbenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Child Benefit programme."),
            br()
          ),
          topTabUI("childA")
        ),
        
        ###### Disability benefit
        tabPanel(
          title = "Disability Benefit",
          value = "disabilitybenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Disability Benefit programme."),
            br()
          ),
          topTabUI("disabA")
        ),
        
        ###### Old age benefit
        tabPanel(
          title = "Old Age Benefit",
          value = "oldagebenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Old Age Benefit programme."),
            br()
          ),
          topTabUI("oldA")
        ),
        
        ###### Household benefit
        tabPanel(
          title = "Household Benefit",
          value = "hhbenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Household Benefit programme"),
            br()
          ),
          topTabUI("B")
        ),
        ###### Combined
        tabPanel(
          title = "Combined",
          value = "combined_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of all programmes combined."),
            br()
          ),
          topTabUI("A")
        )
      )
    )
    
    
    
    
    
    
    
    
  } 
  else if (mparam$mat==FALSE && cparam$child==TRUE && dparam$disab == FALSE && oparam$old == FALSE && param$hh ==FALSE){
    ui <- tagList(
      tabsetPanel(
        id = "navbar",
        type = "tabs",
        
        ###### Child benefit
        tabPanel(
          title = "Child Benefit",
          value = "childbenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Child Benefit programme."),
            br()
          ),
          topTabUI("childA")
        ),
        
        ###### Maternity benefit
        tabPanel(
          title = "Maternity Benefit",
          value = "matbenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Maternity Benefit programme."),
            br()
          ),
          topTabUI("matA")
        ),
        
        ###### Disability benefit
        tabPanel(
          title = "Disability Benefit",
          value = "disabilitybenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Disability Benefit programme."),
            br()
          ),
          topTabUI("disabA")
        ),
        
        ###### Old age benefit
        tabPanel(
          title = "Old Age Benefit",
          value = "oldagebenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Old Age Benefit programme."),
            br()
          ),
          topTabUI("oldA")
        ),
        
        ###### Household benefit
        tabPanel(
          title = "Household Benefit",
          value = "hhbenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Household Benefit programme"),
            br()
          ),
          topTabUI("B")
        ),
        ###### Combined
        tabPanel(
          title = "Combined",
          value = "combined_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of all programmes combined."),
            br()
          ),
          topTabUI("A")
        )
      )
    )
    
    
    
    
    
    
    
    
  } 
  else if (mparam$mat==FALSE && cparam$child==FALSE && dparam$disab == TRUE && oparam$old == FALSE && param$hh ==FALSE) {
    ui <- tagList(
      tabsetPanel(
        id = "navbar",
        type = "tabs",
        
        ###### Disability benefit
        tabPanel(
          title = "Disability Benefit",
          value = "disabilitybenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Disability Benefit programme."),
            br()
          ),
          topTabUI("disabA")
        ),
        
        ###### Maternity benefit
        tabPanel(
          title = "Maternity Benefit",
          value = "matbenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Maternity Benefit programme."),
            br()
          ),
          topTabUI("matA")
        ),
        
        ###### Child benefit
        tabPanel(
          title = "Child Benefit",
          value = "childbenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Child Benefit programme."),
            br()
          ),
          topTabUI("childA")
        ),
        
        ###### Old age benefit
        tabPanel(
          title = "Old Age Benefit",
          value = "oldagebenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Old Age Benefit programme."),
            br()
          ),
          topTabUI("oldA")
        ),
        
        ###### Household benefit
        tabPanel(
          title = "Household Benefit",
          value = "hhbenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Household Benefit programme"),
            br()
          ),
          topTabUI("B")
        ),
        ###### Combined
        tabPanel(
          title = "Combined",
          value = "combined_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of all programmes combined."),
            br()
          ),
          topTabUI("A")
        )
      )
    )
    
    
    
    
    
  } 
  else if (mparam$mat==FALSE && cparam$child==FALSE && dparam$disab == FALSE && oparam$old == TRUE && param$hh ==FALSE) {
    ui <- tagList(
      tabsetPanel(
        id = "navbar",
        type = "tabs",
        
        ###### Old age benefit
        tabPanel(
          title = "Old Age Benefit",
          value = "oldagebenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Old Age Benefit programme."),
            br()
          ),
          topTabUI("oldA")
        ),
        
        ###### Maternity benefit
        tabPanel(
          title = "Maternity Benefit",
          value = "matbenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Maternity Benefit programme."),
            br()
          ),
          topTabUI("matA")
        ),
        
        ###### Child benefit
        tabPanel(
          title = "Child Benefit",
          value = "childbenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Child Benefit programme."),
            br()
          ),
          topTabUI("childA")
        ),
        
        ###### Disability benefit
        tabPanel(
          title = "Disability Benefit",
          value = "disabilitybenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Disability Benefit programme."),
            br()
          ),
          topTabUI("disabA")
        ),
        ###### Household benefit
        tabPanel(
          title = "Household Benefit",
          value = "hhbenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Household Benefit programme"),
            br()
          ),
          topTabUI("B")
        ),
        ###### Combined
        tabPanel(
          title = "Combined",
          value = "combined_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of all programmes combined."),
            br()
          ),
          topTabUI("A")
        )
      )
    )
    
    
    
    
    
  } 
  else if (mparam$mat==FALSE && cparam$child==FALSE && dparam$disab == FALSE && oparam$old == FALSE && param$hh ==TRUE) {
    ui <- tagList(
      tabsetPanel(
        id = "navbar",
        type = "tabs",
        ###### Household benefit
        tabPanel(
          title = "Household Benefit",
          value = "hhbenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Household Benefit programme"),
            br()
          ),
          topTabUI("B")
        ),
        
        
        ###### Maternity benefit
        tabPanel(
          title = "Maternity Benefit",
          value = "matbenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Maternity Benefit programme."),
            br()
          ),
          topTabUI("matA")
        ),
        
        ###### Child benefit
        tabPanel(
          title = "Child Benefit",
          value = "childbenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Child Benefit programme."),
            br()
          ),
          topTabUI("childA")
        ),
        
        ###### Disability benefit
        tabPanel(
          title = "Disability Benefit",
          value = "disabilitybenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Disability Benefit programme."),
            br()
          ),
          topTabUI("disabA")
        ),
        
        ###### Old age benefit
        tabPanel(
          title = "Old Age Benefit",
          value = "oldagebenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Old Age Benefit programme."),
            br()
          ),
          topTabUI("oldA")
        ),
        
        ###### Combined
        tabPanel(
          title = "Combined",
          value = "combined_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of all programmes combined."),
            br()
          ),
          topTabUI("A")
        )
      )
    )
    
    
    
    
  } 
  else {
    ui <- tagList(
      tabsetPanel(
        id = "navbar",
        type = "tabs",
        ###### Combined
        tabPanel(
          title = "Combined",
          value = "combined_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of all programmes combined."),
            br()
          ),
          topTabUI("A")
        ),
        
        ###### Maternity benefit
        tabPanel(
          title = "Maternity Benefit",
          value = "matbenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Maternity Benefit programme."),
            br()
          ),
          topTabUI("matA")
        ),
        
        ###### Child benefit
        tabPanel(
          title = "Child Benefit",
          value = "childbenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Child Benefit programme."),
            br()
          ),
          topTabUI("childA")
        ),
        
        ###### Disability benefit
        tabPanel(
          title = "Disability Benefit",
          value = "disabilitybenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Disability Benefit programme."),
            br()
          ),
          topTabUI("disabA")
        ),
        
        ###### Old age benefit
        tabPanel(
          title = "Old Age Benefit",
          value = "oldagebenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Old Age Benefit programme."),
            br()
          ),
          topTabUI("oldA")
        ),
        
        ###### Household benefit
        tabPanel(
          title = "Household Benefit",
          value = "hhbenefit_tab",
          br(),
          column(
            12,
            p("Below in separate tabs are the estimated annual spending and simulated impacts of the Household Benefit programme"),
            br()
          ),
          topTabUI("B")
        )
      )
    )
  }
  return(ui)
})