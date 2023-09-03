#### Parameters ####

# overall (param) ####
  param <<- list()
  param$country <- ""
  param$hh <- FALSE
  
  # Maternity benefit (mparam) ####
  mparam <<- list()
  mparam$mat <- FALSE
  mparam$matLength <- 18
  mparam$matTrans <- 0
  mparam$matAdmin <- 5
  mparam$matMeans <- FALSE
  mparam$matCov <- 75
  
  # observeEvent(input$country, {
  #   mparam$mat <- FALSE
  #   mparam$matLength <- 18
  #   mparam$matTrans <- 0
  #   mparam$matAdmin <- 5
  #   mparam$matMeans <- FALSE
  #   mparam$matCov <- 100
  # })
  # 
  # observeEvent(input$matbenefit, {
  #   mparam$mat <- input$matbenefit
  #   mparam$matMeans <- FALSE
  # })
  # 
  # observeEvent(input$matlengthA, {
  #   mparam$matLength <- input$matlengthA
  # })
  # 
  # observeEvent({if (!is.null(input$matbenefit) && input$matbenefit==TRUE) TRUE
  # }, {
  #   mparam$matLength <- 18
  # })
  # 
  # observeEvent({if (!is.null(input$matbenefit) && input$matbenefit==FALSE) TRUE
  # }, {
  #   mparam$matTrans <- 0
  # })
  # 
  # observeEvent(input$mattransferA, {
  #   mparam$matTrans <- input$mattransferA
  # })
  # 
  # observeEvent(input$mat_admin, {
  #   mparam$matAdmin <- input$mat_admin
  # })
  # 
  # observeEvent(input$matmeansA, {
  #   mparam$matMeans <- input$matmeansA
  # })
  # 
  # observeEvent(input$matcovA, {
  #   mparam$matCov <- input$matcovA
  # })
  
  # child benefit (cparam) ####
  cparam <<- list()
  cparam$child <- FALSE
  cparam$childAge <- c(0,17)
  cparam$childTrans <- 0
  cparam$childAdmin <- 5
  cparam$childMeans <- FALSE
  cparam$childCov <- 100
  
  # disability benefit (dparam) ####
  dparam <<- list()
  dparam$disabCov <- 100
  dparam$disab <- FALSE
  dparam$disabAge <- c(0,100)
  dparam$disabTrans <- 0
  dparam$disabAdmin <- 5
  dparam$disabMeans <- FALSE
  
  # old age benefit (oparam) ####
  oparam <<- list()
  oparam$old <- FALSE
  oparam$oldCov <- 100
  oparam$oldAge <- c(65,100)
  oparam$oldTrans <- 0
  oparam$oldAdmin <- 5
  oparam$oldPension <- FALSE
  oparam$oldMeans <- FALSE
  
  # household benefit (hparam) ####
  hparam <<- list()
  hparam$hhCov <- 20
  hparam$hhTrans <- 0
  hparam$hhAdmin <- 10
  
  gdpparam <<- list()
  gdpparam$gdp <- 2.5