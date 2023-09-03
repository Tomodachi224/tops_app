###Server functions for Scenario A

#Programme names
tabfullname <- list(
  A = "of all programmes combined",
  matA = "of the Maternity Benefit programme",
  childA = "of the Child Benefit programme",
  disabA = "of the Disability programme",
  oldA = "of the Old Age programme",
  B = "of the Household Benefit programme"
)

# datasets for server
source("./R/2_server/scnA/dataServer.R", local = TRUE)

# Title
source("./R/2_server/scnA/titleRender.R", local = TRUE)

# parameters from landing page for Scenario A
source("./R/2_server/scnA/params.R", local = TRUE)

# Sidebar
source("./R/2_server/scnA/sidebar.R", local = TRUE)
source("./R/2_server/scnA/sidebar_aux.R", local = TRUE)

# costs
source("./R/2_server/scnA/dataCosts.R", local = TRUE)

# impact
source("./R/2_server/scnA/dataImpact.R", local = TRUE)

## Tabs
observeEvent(input$run, {
  lapply(c("A", "matA", "childA", "disabA", "oldA", "B"), function(i) {
    callModule(topTab, i, tab = i,
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
               exclusionerrors)
  })
})
source("./R/2_server/scnA/topTabSetup.R", local = TRUE)
##### Run button ####

output$runbutton2 <- renderUI({
  if ((mparam$mat == TRUE || cparam$child == TRUE || dparam$disab ==TRUE || oparam$old==TRUE) || (!is.null(input$meanstested) && input$meanstested==TRUE)) {
    bsButton(
      "run",
      "Go",
      type = "toggle",
      value = TRUE,
      icon = icon("check-circle"),
      style = "success"
    )
  } else {
    bsButton(
      "run_no",
      "Go",
      type = "toggle",
      value = TRUE,
      icon = icon("check-circle"),
      style = "success"
    )
  }
})


##### Download handlers ####

# PDF report
output$reportDownload <- renderUI({
  if ((mparam$mat == TRUE || cparam$child == TRUE || dparam$disab ==TRUE || oparam$old==TRUE) || (!is.null(input$meanstested) && input$meanstested==TRUE)) {
    downloadButton(
      "reportPDF",
      "PDF",
      icon = icon("download"),
      style = "color: white;background-color: #02B481;"
    )
  } else {
    actionButton("do",
                 " PDF ",
                 icon = icon("download"),
                 style = "color: white;background-color: #02B481;")
  }
})
output$downloadFail <- renderText({
  if ((mparam$mat == TRUE || cparam$child == TRUE || dparam$disab ==TRUE || oparam$old==TRUE) || (!is.null(input$meanstested) && input$meanstested==TRUE)) {
    return()
  } else {
    "No positive transfer value was entered"
  }
})


# Load reactives for pdf report
source("./R/2_server/scnA/pdfOutputs.R", local = TRUE)

# Produce pdf (report.pdf)
source("./R/2_server/scnA/pdfReport.R", local = TRUE)

# reset sidebar
observeEvent(input$resetAll, {

    param$country <- ""
    param$hh <- FALSE
    
    mparam$mat <- FALSE
    mparam$matLength <- 14
    mparam$matTrans <- 0
    mparam$matAdmin <- 5
    mparam$matMeans <- FALSE
    mparam$matCov <- 75
    
    cparam$child <- FALSE
    cparam$childAge <- c(0,17)
    cparam$childTrans <- 0
    cparam$childAdmin <- 5
    cparam$childMeans <- FALSE
    cparam$childCov <- 75
    
    dparam$disab <- FALSE
    dparam$disabCov <- 75
    dparam$disabAge <- c(0,64)
    dparam$disabTrans <- 0
    dparam$disabAdmin <- 5
    dparam$disabMeans <- FALSE
    
    oparam$old <- FALSE
    oparam$oldCov <- 75
    oparam$oldAge <- c(65,100)
    oparam$oldTrans <- 0
    oparam$oldAdmin <- 5
    oparam$oldPension <- FALSE
    oparam$oldMeans <- FALSE
    
    hparam$hhCov <- 20
    hparam$hhTrans <- 0
    hparam$hhAdmin <- 10
})

# hide sidebar
observeEvent(input$showpanel, {
  if (input$showpanel == TRUE) {
    removeCssClass("Main_A", "col-sm-12")
    addCssClass("Main_A", "col-sm-8")
    shinyjs::show(id = "Sidebar")
    shinyjs::enable(id = "Sidebar")
  }
  else {
    removeCssClass("Main_A", "col-sm-8")
    addCssClass("Main_A", "col-sm-12")
    shinyjs::hide(id = "Sidebar")
  }
})

