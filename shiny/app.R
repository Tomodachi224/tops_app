library(shiny)
library(DT)
library(ggplot2)
library(plotly)
library(scales)
library(shinycssloaders)
library(shinyjs)
library(shinyBS)
library(markdown)
library(rmarkdown)
library(feather)
library(shinyWidgets)
library(dplyr)
library(readr)
library(stringr)
library(ggthemes)
library(lubridate)

############ 0 Preamble #########################

  # Load data and information of countries in tool
  source("./R/0_preamble/about.R")

  # Load functions
  source("./R/0_preamble/loadFunctions.R")

  # Load modules
  source("./R/4_modules/scnA/covModule.R")
  source("./R/4_modules/scnA/expModule.R")
  source("./R/4_modules/scnA/povModule.R")
  source("./R/4_modules/scnA/costModule.R")
  source("./R/4_modules/scnA/finModule.R")
  source("./R/4_modules/scnA/topTabModule.R")

  source("./R/4_modules/scnB/covModule.R")
  source("./R/4_modules/scnB/expModule.R")
  source("./R/4_modules/scnB/povModule.R")
  source("./R/4_modules/scnB/costModule.R")
  source("./R/4_modules/scnB/finModule.R")
  source("./R/4_modules/scnB/topTabModule.R")

  source("./R/4_modules/summary/covModule.R")
  source("./R/4_modules/summary/expModule.R")
  source("./R/4_modules/summary/povModule.R")
  source("./R/4_modules/summary/costModule.R")
  source("./R/4_modules/summary/topTabModule.R")

############ 1 UI       #########################

  # Transition: landing page to main page
  mainPage = FALSE
  
  # UI 1 (Landing page)
  ui1 <- function() {
    source("./R/1_ui/ui1.R")$value
  }
  
  # UI 2 (Main page)
  ui2 <- function() {
    source("./R/1_ui/ui2.R")$value
  }

  ui = (uiOutput("page"))

############ 2 Server   #########################
server = (function(input, output, session) {
  # options(shiny.reactlog=TRUE)
  
  output$citation <- renderUI({
    todaydate <- format(Sys.time(), "%d %B %Y")
    
    HTML(paste0(p(tags$b("Suggested Citation:"),"United Nations, Economic and Social Commission for Asia and the Pacific (ESCAP) , Social Protection Simulator. Available at ",
      tags$a(href="https://www.socialprotection-toolbox.org/simulation-tool", "https://www.socialprotection-toolbox.org/simulation-tool"), 
      " (accessed on ", todaydate, ")", align='center')))
    })
  
  #### Main Page (tool) ####

  ### Scenario A ####
  source("./R/2_server/scnAserver.R", local = TRUE)$value
  
  ### Scenario B ####
  source("./R/2_server/scnBserver.R", local = TRUE)$value
  
  ### Summary ####
  source("./R/2_server/summaryserver.R", local = TRUE)$value
  
  ##### Glossary page ####
  source("./R/2_server/glossaryserver.R", local = TRUE)$value
  
  ##### About page ####
  source("./R/2_server/aboutserver.R", local = TRUE)$value
  
  ##### Changing UI ####
  
  output$runbutton <- renderUI({
    if ((mparam$mat == TRUE || cparam$child == TRUE || dparam$disab ==TRUE || oparam$old==TRUE) || (!is.null(input$meanstested) && input$meanstested==TRUE)) {
      actionButton(
        "run",
        "Go",
        icon = icon("check-circle"),
        style = "color: white;background-color: #02B481;"
      )
    } else {
      actionButton(
        "run_no",
        "Go",
        icon = icon("check-circle"),
        style = "color: white;background-color: #02B481;"
      )
    }
  })
  
  transition <- reactiveValues(mainPage = mainPage)
  
  # Change from landing page to main page
  observeEvent(input$run,{
      transition$mainPage <- TRUE
  })
  
  # Change UI
  observe({
    if (transition$mainPage == FALSE) {
      output$page <- renderUI({
        do.call(bootstrapPage, c("", ui1()))
      })
    }
    if (transition$mainPage == TRUE)
    {
      output$page <- renderUI({
        div(class = "outer", do.call(bootstrapPage, c("", ui2())))
      })
    }
  })
  
  observeEvent(input$run, updateQueryString("?page=tool", mode = "push"))
  
  ##### Observe actions ####
  
  #move page up after landing page
  observeEvent(input$run, {
    js$return();
  })
  
  #Scenario A
  #change tab to about
    observeEvent(input$link_to_about , {
      updateTabsetPanel(session, "menu", selected = "about")
      js$return()
    })
  #move page up when clicking on return
  observeEvent(input$return, {
      js$return()
  }) 
  #change tab to scn B
  observeEvent(input$link_to_scen_b , {
    updateTabsetPanel(session, "maintabs", selected = "Scenario B")
    js$return()
  })
  #Scenario B
  #change tab to about
  observeEvent(input$link_to_about_b , {
    updateTabsetPanel(session, "menu", selected = "about")
    js$return()
  })
  #move page up when clicking on return
  observeEvent(input$return_b, {
    js$return()
  })
  #change tab to compare
  observeEvent(input$link_to_compare_b , {
    updateTabsetPanel(session, "maintabs", selected = "Compare")
    js$return()
  })
  #Summary Scenario
  #change tab to about
  observeEvent(input$link_to_about_c , {
    updateTabsetPanel(session, "menu", selected = "about")
    js$return()
  })
  #move page up when clicking on return
  observeEvent(input$return_c, {
    js$return()
  }) 
  
  #Conditional tabs
  
  #Scenario A
  observeEvent(input$run, {
    toggle(condition = (mparam$mat),
           selector = "#navbar li a[data-value=matbenefit_tab_A]")
  })
  observeEvent(input$run, {
    toggle(condition = (cparam$child),
           selector = "#navbar li a[data-value=childbenefit_tab_A]")
  })
  observeEvent(input$run, {
    toggle(condition = (dparam$disab),
      selector = "#navbar li a[data-value=disabilitybenefit_tab_A]")
  })
  observeEvent(input$run, {
    toggle(condition = (oparam$old),
           selector = "#navbar li a[data-value=oldagebenefit_tab_A]")
  })
  observeEvent(input$run, {
    toggle(condition = (input$meanstested),
           selector = "#navbar li a[data-value=hhbenefit_tab_A]")
  })
  
  #Scenario B
  observeEvent(input$run_b, {
    shinyjs::show("mainpanel_b")
  })
  
  observeEvent(input$run_b, {
    toggle(condition = (mparam_b$mat),
           selector = "#navbar_b li a[data-value=matbenefit_tab_b]")
  })
  observeEvent(input$run_b, {
    toggle(condition = (cparam_b$child),
           selector = "#navbar_b li a[data-value=childbenefit_tab_b]")
  })
  observeEvent(input$run_b, {
    toggle(condition = (dparam_b$disab),
           selector = "#navbar_b li a[data-value=disabilitybenefit_tab_b]")
  })
  observeEvent(input$run_b, {
    toggle(condition = (oparam_b$old),
           selector = "#navbar_b li a[data-value=oldagebenefit_tab_b]")
  })
  observeEvent(input$run_b, {
    toggle(condition = (param_b$hh),
           selector = "#navbar_b li a[data-value=hhbenefit_tab_b]")
  })
  
  #Summary Scenario
  observeEvent(input$run_b, {
    toggle(condition = (mparam$mat || cparam_b$mat),
           selector = "#navbar_c li a[data-value=matbenefit_tab_c]")
  })
  observeEvent(input$run_b, {
    toggle(condition = (cparam$child || cparam_b$child),
           selector = "#navbar_c li a[data-value=childbenefit_tab_c]")
  })
  observeEvent(input$run_b, {
    toggle(condition = (dparam$disab || dparam_b$disab),
           selector = "#navbar_c li a[data-value=disabilitybenefit_tab_c]")
  })
  observeEvent(input$run_b, {
    toggle(condition = (oparam$old || oparam_b$old),
           selector = "#navbar_c li a[data-value=oldagebenefit_tab_c]")
  })
  observeEvent(input$run_b, {
    toggle(condition = (param$hh || param_b$hh),
           selector = "#navbar_c li a[data-value=hhbenefit_tab_c]")
  })
  observeEvent(input$run_b, {
    shinyjs::show("tabsetpanel_c")
  })

})

############ Deploy ########################################
shinyApp(ui = ui, server = server)
