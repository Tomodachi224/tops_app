 ######## TABS
 output$TopTabSetup_b <- renderUI({
   if (mparam_b$mat==TRUE && cparam_b$child==FALSE && dparam_b$disab == FALSE && oparam_b$old == FALSE && param_b$hh ==FALSE){
     ui <- tagList(
       tabsetPanel(
         id = "navbar_b",
         type = "tabs",
         
         ###### Maternity benefit
         tabPanel(
           title = "Maternity Benefit",
           value = "matbenefit_tab_b",
           br(),
           column(
             12,
             p("Below in separate tabs are the estimated annual spending and simulated impacts of the Maternity Benefit programme."),
             br()
           ),
           topTabUI_b("matA_b")
         ),
         
         ###### Child benefit
         tabPanel(
           title = "Child Benefit",
           value = "childbenefit_tab_b",
           br(),
           column(
             12,
             p("Below in separate tabs are the estimated annual spending and simulated impacts of the Child Benefit programme."),
             br()
           ),
           topTabUI_b("childA_b")
         ),
         
         ###### Disability benefit
         tabPanel(
           title = "Disability Benefit",
           value = "disabilitybenefit_tab_b",
           br(),
           column(
             12,
             p("Below in separate tabs are the estimated annual spending and simulated impacts of the Disability Benefit programme."),
             br()
           ),
           topTabUI_b("disabA_b")
         ),
         
         ###### Old age benefit
         tabPanel(
           title = "Old Age Benefit",
           value = "oldagebenefit_tab_b",
           br(),
           column(
             12,
             p("Below in separate tabs are the estimated annual spending and simulated impacts of the Old Age Benefit programme."),
             br()
           ),
           topTabUI_b("oldA_b")
         ),
         
         ###### Household benefit
         tabPanel(
           title = "Household Benefit",
           value = "hhbenefit_tab_b",
           br(),
           column(
             12,
             p("Below in separate tabs are the estimated annual spending and simulated impacts of the Household Benefit programme"),
             br()
           ),
           topTabUI_b("B_b")
         ),
         ###### Combined
         tabPanel(
           title = "Combined",
           value = "combined_tab_b",
           br(),
           column(
             12,
             p("Below in separate tabs are the estimated annual spending and simulated impacts of all programmes combined."),
             br()
           ),
           topTabUI_b("A_b")
         )
       )
     )
     
     
     
     
     
     
     
     
   } 
   else if (mparam_b$mat==FALSE && cparam_b$child==TRUE && dparam_b$disab == FALSE && oparam_b$old == FALSE && param_b$hh ==FALSE){
   ui <- tagList(
     tabsetPanel(
       id = "navbar_b",
       type = "tabs",

       ###### Child benefit
       tabPanel(
        title = "Child Benefit",
        value = "childbenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Child Benefit programme."),
          br()
        ),
        topTabUI_b("childA_b")
      ),
      
      ###### Maternity benefit
      tabPanel(
        title = "Maternity Benefit",
        value = "matbenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Maternity Benefit programme."),
          br()
        ),
        topTabUI_b("matA_b")
      ),
      
      ###### Disability benefit
      tabPanel(
        title = "Disability Benefit",
        value = "disabilitybenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Disability Benefit programme."),
          br()
        ),
        topTabUI_b("disabA_b")
      ),
      
      ###### Old age benefit
      tabPanel(
        title = "Old Age Benefit",
        value = "oldagebenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Old Age Benefit programme."),
          br()
        ),
        topTabUI_b("oldA_b")
      ),
      
      ###### Household benefit
      tabPanel(
        title = "Household Benefit",
        value = "hhbenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Household Benefit programme"),
          br()
        ),
        topTabUI_b("B_b")
      ),
            ###### Combined
      tabPanel(
        title = "Combined",
        value = "combined_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of all programmes combined."),
          br()
        ),
        topTabUI_b("A_b")
      )
   )
   )
    
    
   
   
   
   
    
   
   } 
   else if (mparam_b$mat==FALSE && cparam_b$child==FALSE && dparam_b$disab == TRUE && oparam_b$old == FALSE && param_b$hh ==FALSE) {
      ui <- tagList(
        tabsetPanel(
          id = "navbar_b",
          type = "tabs",
      
      ###### Disability benefit
      tabPanel(
        title = "Disability Benefit",
        value = "disabilitybenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Disability Benefit programme."),
          br()
        ),
        topTabUI_b("disabA_b")
      ),
      
      ###### Maternity benefit
      tabPanel(
        title = "Maternity Benefit",
        value = "matbenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Maternity Benefit programme."),
          br()
        ),
        topTabUI_b("matA_b")
      ),
      
      ###### Child benefit
      tabPanel(
        title = "Child Benefit",
        value = "childbenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Child Benefit programme."),
          br()
        ),
        topTabUI_b("childA_b")
      ),
      
      ###### Old age benefit
      tabPanel(
        title = "Old Age Benefit",
        value = "oldagebenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Old Age Benefit programme."),
          br()
        ),
        topTabUI_b("oldA_b")
      ),
      
      ###### Household benefit
      tabPanel(
        title = "Household Benefit",
        value = "hhbenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Household Benefit programme"),
          br()
        ),
        topTabUI_b("B_b")
      ),
            ###### Combined
      tabPanel(
        title = "Combined",
        value = "combined_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of all programmes combined."),
          br()
        ),
        topTabUI_b("A_b")
      )
  )
      )
  
      
   
      
    
      } 
   else if (mparam_b$mat==FALSE && cparam_b$child==FALSE && dparam_b$disab == FALSE && oparam_b$old == TRUE && param_b$hh ==FALSE) {
    ui <- tagList(
      tabsetPanel(
        id = "navbar_b",
        type = "tabs",
     
      ###### Old age benefit
      tabPanel(
        title = "Old Age Benefit",
        value = "oldagebenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Old Age Benefit programme."),
          br()
        ),
        topTabUI_b("oldA_b")
      ),
      
      ###### Maternity benefit
      tabPanel(
        title = "Maternity Benefit",
        value = "matbenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Maternity Benefit programme."),
          br()
        ),
        topTabUI_b("matA_b")
      ),
      
      ###### Child benefit
      tabPanel(
        title = "Child Benefit",
        value = "childbenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Child Benefit programme."),
          br()
        ),
        topTabUI_b("childA_b")
      ),
      
      ###### Disability benefit
      tabPanel(
        title = "Disability Benefit",
        value = "disabilitybenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Disability Benefit programme."),
          br()
        ),
        topTabUI_b("disabA_b")
      ),
      ###### Household benefit
      tabPanel(
        title = "Household Benefit",
        value = "hhbenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Household Benefit programme"),
          br()
        ),
        topTabUI_b("B_b")
      ),
            ###### Combined
      tabPanel(
        title = "Combined",
        value = "combined_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of all programmes combined."),
          br()
        ),
        topTabUI_b("A_b")
      )
  )
    )
  
    
   
    
    
    } 
   else if (mparam_b$mat==FALSE && cparam_b$child==FALSE && dparam_b$disab == FALSE && oparam_b$old == FALSE && param_b$hh ==TRUE) {
    ui <- tagList(
      tabsetPanel(
        id = "navbar_b",
        type = "tabs",
      ###### Household benefit
      tabPanel(
        title = "Household Benefit",
        value = "hhbenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Household Benefit programme"),
          br()
        ),
        topTabUI_b("B_b")
      ),

      
      ###### Maternity benefit
      tabPanel(
        title = "Maternity Benefit",
        value = "matbenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Maternity Benefit programme."),
          br()
        ),
        topTabUI_b("matA_b")
      ),
      
      ###### Child benefit
      tabPanel(
        title = "Child Benefit",
        value = "childbenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Child Benefit programme."),
          br()
        ),
        topTabUI_b("childA_b")
      ),
      
      ###### Disability benefit
      tabPanel(
        title = "Disability Benefit",
        value = "disabilitybenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Disability Benefit programme."),
          br()
        ),
        topTabUI_b("disabA_b")
      ),
      
      ###### Old age benefit
      tabPanel(
        title = "Old Age Benefit",
        value = "oldagebenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Old Age Benefit programme."),
          br()
        ),
        topTabUI_b("oldA_b")
      ),
       
     ###### Combined
      tabPanel(
        title = "Combined",
        value = "combined_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of all programmes combined."),
          br()
        ),
        topTabUI_b("A_b")
      )
  )
)
  
    
   
    
    } 
   else {
    ui <- tagList(
      tabsetPanel(
        id = "navbar_b",
        type = "tabs",
      ###### Combined
      tabPanel(
        title = "Combined",
        value = "combined_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of all programmes combined."),
          br()
        ),
        topTabUI_b("A_b")
      ),
      
      ###### Maternity benefit
      tabPanel(
        title = "Maternity Benefit",
        value = "matbenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Maternity Benefit programme."),
          br()
        ),
        topTabUI_b("matA_b")
      ),
      
      ###### Child benefit
      tabPanel(
        title = "Child Benefit",
        value = "childbenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Child Benefit programme."),
          br()
        ),
        topTabUI_b("childA_b")
      ),
      
      ###### Disability benefit
      tabPanel(
        title = "Disability Benefit",
        value = "disabilitybenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Disability Benefit programme."),
          br()
        ),
        topTabUI_b("disabA_b")
      ),
      
      ###### Old age benefit
      tabPanel(
        title = "Old Age Benefit",
        value = "oldagebenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Old Age Benefit programme."),
          br()
        ),
        topTabUI_b("oldA_b")
      ),
      
      ###### Household benefit
      tabPanel(
        title = "Household Benefit",
        value = "hhbenefit_tab_b",
        br(),
        column(
          12,
          p("Below in separate tabs are the estimated annual spending and simulated impacts of the Household Benefit programme"),
          br()
        ),
        topTabUI_b("B_b")
      )
  )
)
  }
   return(ui)
 })