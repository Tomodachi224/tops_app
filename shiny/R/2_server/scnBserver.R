###Server functions for Scenario B

#Programme names
tabfullname_b <- list(
  A = "of all programmes combined",
  matA = "of the Maternity Benefit programme",
  childA = "of the Child Benefit programme",
  disabA = "of the Disability programme",
  oldA = "of the Old Age programme",
  B = "of the Household Benefit programme"
)

# datasets for server
source("./R/2_server/scnB/dataServer.R", local = TRUE)

# Title
source("./R/2_server/scnB/titleRender.R", local = TRUE)

# parameters from landing page for Scenario A
source("./R/2_server/scnB/params.R", local = TRUE)

# Sidebar
source("./R/2_server/scnB/sidebar.R", local = TRUE)
source("./R/2_server/scnB/sidebar_aux.R", local = TRUE)

# costs
source("./R/2_server/scnB/dataCosts.R", local = TRUE)

# impact
source("./R/2_server/scnB/dataImpact.R", local = TRUE)

## Tabs
observeEvent(input$run_b, {  
  lapply(c("A", "matA", "childA", "disabA", "oldA", "B"), function(i) {
    callModule(topTab_b, paste0(i, "_b"), tab_b = i,
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
               exclusionerrors_b)
  })
})
source("./R/2_server/scnB/topTabSetup.R", local = TRUE)
##### Run button ####

output$runbutton2_b <- renderUI({
  if ((mparam_b$mat == TRUE || cparam_b$child == TRUE || dparam_b$disab ==TRUE || oparam_b$old==TRUE) || (!is.null(input$meanstested_b) && input$meanstested_b==TRUE)) {
    actionButton(
      "run_b",
      "Go",
      #type = "toggle",
      #value = FALSE,
      icon = icon("check-circle"),
      style = "color: white;background-color: #02B481;"
    )
  } else {
    actionButton(
      "run_no_b",
      "Go",
      #type = "toggle",
      #value = TRUE,
      icon = icon("check-circle"),
      style = "color: white;background-color: #02B481;"
    )
  }
})


##### Download handlers ####

# PDF report
output$reportDownload_b <- renderUI({
  if (((mparam_b$mat == TRUE || cparam_b$child == TRUE || dparam_b$disab ==TRUE || oparam_b$old==TRUE) || (!is.null(param_b$hh) && param_b$hh==TRUE)) && (!is.null(input$run_b) && input$run_b>=1)) {
    downloadButton(
      "reportPDF_b",
      "PDF",
      icon = icon("download"),
      style = "color: white;background-color: #02B481;"
    )
  } else {
    actionButton("do_b",
                 " PDF ",
                 icon = icon("download"),
                 style = "color: white;background-color: #02B481;")
  }
})
output$downloadFail_b <- renderText({
  if ((mparam_b$mat == TRUE || cparam_b$child == TRUE || dparam_b$disab ==TRUE || oparam_b$old==TRUE) || (param_b$hh==TRUE)) {
    return()
  } else {
    "No positive transfer value was entered"
  }
})


# # Load reactives for pdf report
source("./R/2_server/scnB/pdfOutputs.R", local = TRUE)
# 
# # Produce pdf (report.pdf)
source("./R/2_server/scnB/pdfReport.R", local = TRUE)

# reset sidebar
observeEvent(input$resetAll_b, {
  
    param_b$country <- ""
    param_b$hh <- FALSE
    
    mparam_b$mat <- FALSE
    mparam_b$matLength <- 14
    mparam_b$matTrans <- 0
    mparam_b$matAdmin <- 5
    mparam_b$matMeans <- FALSE
    mparam_b$matCov <- 75
    
    cparam_b$child <- FALSE
    cparam_b$childAge <- c(0,17)
    cparam_b$childTrans <- 0
    cparam_b$childAdmin <- 5
    cparam_b$childMeans <- FALSE
    cparam_b$childCov <- 75
    
    dparam_b$disab <- FALSE
    dparam_b$disabCov <- 75
    dparam_b$disabAge <- c(0,64)
    dparam_b$disabTrans <- 0
    dparam_b$disabAdmin <- 5
    dparam_b$disabMeans <- FALSE
    
    oparam_b$old <- FALSE
    oparam_b$oldCov <- 75
    oparam_b$oldAge <- c(65,100)
    oparam_b$oldTrans <- 0
    oparam_b$oldAdmin <- 5
    oparam_b$oldPension <- FALSE
    oparam_b$oldMeans <- FALSE
    
    hparam_b$hhCov <- 20
    hparam_b$hhTrans <- 0
    hparam_b$hhAdmin <- 10
})

# hide sidebar
observeEvent(input$showpanel_b, {
  if (input$showpanel_b == TRUE) {
    removeCssClass("Main_B", "col-sm-12")
    addCssClass("Main_B", "col-sm-8")
    shinyjs::show(id = "Sidebar_b")
    shinyjs::enable(id = "Sidebar_b")
  }
  else {
    removeCssClass("Main_B", "col-sm-8")
    addCssClass("Main_B", "col-sm-12")
    shinyjs::hide(id = "Sidebar_b")
  }
})

