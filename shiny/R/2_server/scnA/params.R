#### Parameters ####

# overall (param) ####
  param <- reactiveValues()
  param$country <- ""
  param$hh <- FALSE
  
  observeEvent({if (!is.null(input$country) && input$country!="") TRUE
     }, {
      param$country <- input$country
    })
  
  observeEvent({if (!is.null(input$meanstested)) TRUE
     }, {
      param$hh <- input$meanstested
    })
  
  observeEvent(input$country, {
    param$hh <- FALSE
  })

# Maternity benefit (mparam) ####
  mparam <- reactiveValues()
  mparam$mat <- FALSE
  mparam$matLength <- 18
  mparam$matTrans <- 0
  mparam$matAdmin <- 5
  mparam$matMeans <- FALSE
  mparam$matCov <- 75
  
  observeEvent(input$country, {
    mparam$mat <- FALSE
    mparam$matLength <- 18
    mparam$matTrans <- 0
    mparam$matAdmin <- 5
    mparam$matMeans <- FALSE
    mparam$matCov <- 100
  })
  
  observeEvent(input$matbenefit, {
    mparam$mat <- input$matbenefit
    mparam$matMeans <- FALSE
  })
  
  observeEvent(input$matlengthA, {
    mparam$matLength <- input$matlengthA
  })
  
  observeEvent({if (!is.null(input$matbenefit) && input$matbenefit==TRUE) TRUE
  }, {
    mparam$matLength <- 18
  })
  
  observeEvent({if (!is.null(input$matbenefit) && input$matbenefit==FALSE) TRUE
  }, {
    mparam$matTrans <- 0
  })
  
  observeEvent(input$mattransferA, {
    mparam$matTrans <- input$mattransferA
  })
  
  observeEvent(input$mat_admin, {
    mparam$matAdmin <- input$mat_admin
  })
  
  observeEvent(input$matmeansA, {
    mparam$matMeans <- input$matmeansA
  })
  
  observeEvent(input$matcovA, {
    mparam$matCov <- input$matcovA
  })
  
  # child benefit (cparam) ####
  cparam <- reactiveValues()
  cparam$child <- FALSE
  cparam$childAge <- c(0,17)
  cparam$childTrans <- 0
  cparam$childAdmin <- 5
  cparam$childMeans <- FALSE
  cparam$childCov <- 100
  
  observeEvent(input$country, {
    cparam$child <- FALSE
    cparam$childAge <- c(0,17)
    cparam$childTrans <- 0
    cparam$childAdmin <- 5
    cparam$childMeans <- FALSE
    cparam$childCov <- 100
  })
  
  observeEvent(input$childbenefit, {
    cparam$child <- input$childbenefit
    cparam$childMeans <- FALSE
  })
  
  observeEvent(input$childageA, {
    cparam$childAge <- input$childageA
  })
  
  observeEvent({if (!is.null(input$childbenefit) && input$childbenefit==TRUE) TRUE
     }, {
      cparam$childAge <- c(0,17)
    })
  
  observeEvent({if (!is.null(input$childbenefit) && input$childbenefit==FALSE) TRUE
     }, {
      cparam$childTrans <- 0
    })
  
  observeEvent(input$childtransferA, {
    cparam$childTrans <- input$childtransferA
  })
  
  observeEvent(input$child_admin, {
    cparam$childAdmin <- input$child_admin
  })
  
  observeEvent(input$childmeansA, {
    cparam$childMeans <- input$childmeansA
  })
  
  observeEvent(input$childcovA, {
    cparam$childCov <- input$childcovA
  })
# disability benefit (dparam) ####
  dparam <- reactiveValues()
  dparam$disabCov <- 100
  dparam$disab <- FALSE
  dparam$disabAge <- c(0,64)
  dparam$disabTrans <- 0
  dparam$disabAdmin <- 5
  dparam$disabMeans <- FALSE
  
  observeEvent(input$country, {
    dparam$disabCov <- 100
    dparam$disab <- FALSE
    dparam$disabAge <- c(0,64)
    dparam$disabTrans <- 0
    dparam$disabAdmin <- 5
    dparam$disabMeans <- FALSE
  })
  
  observeEvent(input$disabilitybenefit, {
    dparam$disab <- input$disabilitybenefit
    dparam$disabMeans <- FALSE
  })
  
  observeEvent(input$disabageA, {
    dparam$disabAge <- input$disabageA
  })
  
  observeEvent({if (!is.null(input$disabilitybenefit) && input$disabilitybenefit==TRUE) TRUE
     }, {
      dparam$disabAge <- c(0,64)
    })
  
  observeEvent({if (!is.null(input$disabilitybenefit) && input$disabilitybenefit==FALSE) TRUE
     }, {
      dparam$disabTrans <- 0
    })
  
  observeEvent(input$disabtransferA, {
    dparam$disabTrans <- input$disabtransferA
  })
  
  observeEvent(input$disab_admin, {
    dparam$disabAdmin <- input$disab_admin
  })
  
  observeEvent(input$disabmeansA, {
    dparam$disabMeans <- input$disabmeansA
  })
  
  observeEvent(input$disabcovA, {
    dparam$disabCov <- input$disabcovA
  })

# old age benefit (oparam) ####
  oparam <- reactiveValues()
  oparam$old <- FALSE
  oparam$oldCov <- 100
  oparam$oldAge <- c(65,100)
  oparam$oldTrans <- 0
  oparam$oldAdmin <- 5
  oparam$oldPension <- FALSE
  oparam$oldMeans <- FALSE
  
  observeEvent(input$country, {
    oparam$old <- FALSE
    oparam$oldCov <- 100
    oparam$oldAge <- c(65,100)
    oparam$oldTrans <- 0
    oparam$oldAdmin <- 5
    oparam$oldPension <- FALSE
    oparam$oldMeans <- FALSE
  })
  
  observeEvent(input$oldagebenefit, {
    oparam$old <- input$oldagebenefit
    oparam$oldMeans <- FALSE
  })
  
  observeEvent(input$oldageA, {
    oparam$oldAge <- input$oldageA
  })
  
  observeEvent({if (!is.null(input$oldagebenefit) && input$oldagebenefit==TRUE) TRUE
     }, {
      oparam$oldAge <- c(65,100)
    })
  
  observeEvent({if (!is.null(input$oldagebenefit) && input$oldagebenefit==FALSE) TRUE
     }, {
      oparam$oldTrans <- 0
    })
  
  observeEvent(input$oldtransferA, {
    oparam$oldTrans <- input$oldtransferA
  })
  
  observeEvent(input$old_admin, {
    oparam$oldAdmin <- input$old_admin
  })
  
  observeEvent(input$pensiontest, {
    oparam$oldPension <- input$pensiontest
  })
  
  observeEvent(input$oldmeansA, {
    oparam$oldMeans <- input$oldmeansA
  })
  
  observeEvent(input$oldcovA, {
    oparam$oldCov <- input$oldcovA
  })

# household benefit (hparam) ####
  hparam <- reactiveValues()
  hparam$hhCov <- 20
  hparam$hhTrans <- 0
  hparam$hhAdmin <- 10
  
  observeEvent(input$country, {
    hparam$hhCov <- 20
    hparam$hhTrans <- 0
    hparam$hhAdmin <- 10
  })
  
  observeEvent(input$hhcovB, {
    hparam$hhCov <- input$hhcovB
  })
  
  observeEvent({if (!is.null(input$meanstested) && input$meanstested==TRUE) TRUE
     }, {
      hparam$hhCov <- 20
    })
  
  observeEvent({if (!is.null(input$meanstested) && input$meanstested==FALSE) TRUE
     }, {
      hparam$hhTrans <- 0
    })
  
  observeEvent(input$hhtransferB, {
    hparam$hhTrans <- input$hhtransferB
  })
  
  observeEvent(input$hh_admin, {
    hparam$hhAdmin <- input$hh_admin
  })
  
  gdpparam <- reactiveValues()
  gdpparam$gdp <- 4
  
  observeEvent(input$country, {
    gdpparam$gdp <- econ()$growth
  })
  
  observeEvent(input$gdp_proj, {
    gdpparam$gdp <- input$gdp_proj
  })

