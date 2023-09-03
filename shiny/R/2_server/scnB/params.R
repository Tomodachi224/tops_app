#### Parameters ####

# overall (param_b) ####
  param_b <- reactiveValues()
  param_b$country <- ""
  param_b$hh <- FALSE
  
  observeEvent({if (!is.null(input$country_b) && input$country_b!="") TRUE
     }, {
      param_b$country <- input$country_b
    })
  
  observeEvent({if (!is.null(input$meanstested_b)) TRUE
     }, {
      param_b$hh <- input$meanstested_b
    })

  observeEvent(input$country_b, {
    param_b$hh <- FALSE
  })
  
# Maternity benefit (mparam_b) ####
  mparam_b <- reactiveValues()
  mparam_b$mat <- FALSE
  mparam_b$matLength <- 18
  mparam_b$matTrans <- 0
  mparam_b$matAdmin <- 5
  mparam_b$matMeans <- FALSE
  mparam_b$matCov <- 75
  
  observeEvent(input$country_b, {
    mparam_b$mat <- FALSE
    mparam_b$matLength <- 18
    mparam_b$matTrans <- 0
    mparam_b$matAdmin <- 5
    mparam_b$matMeans <- FALSE
    mparam_b$matCov <- 100
  })
  
  observeEvent(input$matbenefit_b, {
    mparam_b$mat <- input$matbenefit_b
    mparam_b$matMeans <- FALSE
  })
  
  observeEvent(input$matlengthA_b, {
    mparam_b$matLength <- input$matlengthA_b
  })
  
  observeEvent({if (!is.null(input$matbenefit_b) && input$matbenefit_b==TRUE) TRUE
  }, {
    mparam_b$matLength <- 18
  })
  
  observeEvent({if (!is.null(input$matbenefit_b) && input$matbenefit_b==FALSE) TRUE
  }, {
    mparam_b$matTrans <- 0
  })
  
  observeEvent(input$mattransferA_b, {
    mparam_b$matTrans <- input$mattransferA_b
  })
  
  observeEvent(input$mat_admin_b, {
    mparam_b$matAdmin <- input$mat_admin_b
  })
  
  observeEvent(input$matmeansA_b, {
    mparam_b$matMeans <- input$matmeansA_b
  })
  
  observeEvent(input$matcovA_b, {
    mparam_b$matCov <- input$matcovA_b
  })
  
# child benefit (cparam_b) ####
  cparam_b <- reactiveValues()
  cparam_b$child <- FALSE
  cparam_b$childAge <- c(0,17)
  cparam_b$childTrans <- 0
  cparam_b$childAdmin <- 5
  cparam_b$childMeans <- FALSE
  cparam_b$childCov <- 75
  
  observeEvent(input$country_b, {
    cparam_b$child <- FALSE
    cparam_b$childAge <- c(0,17)
    cparam_b$childTrans <- 0
    cparam_b$childAdmin <- 5
    cparam_b$childMeans <- FALSE
    cparam_b$childCov <- 100
  })
  
  observeEvent(input$childbenefit_b, {
    cparam_b$child <- input$childbenefit_b
    cparam_b$childMeans <- FALSE
  })
  
  observeEvent(input$childageA_b, {
    cparam_b$childAge <- input$childageA_b
  })
  
  observeEvent({if (!is.null(input$childbenefit_b) && input$childbenefit_b==TRUE) TRUE
     }, {
      cparam_b$childAge <- c(0,17)
    })
  
  observeEvent({if (!is.null(input$childbenefit_b) && input$childbenefit_b==FALSE) TRUE
     }, {
      cparam_b$childTrans <- 0
    })
  
  observeEvent(input$childtransferA_b, {
    cparam_b$childTrans <- input$childtransferA_b
  })
  
  observeEvent(input$child_admin_b, {
    cparam_b$childAdmin <- input$child_admin_b
  })
  
  observeEvent(input$childmeansA_b, {
    cparam_b$childMeans <- input$childmeansA_b
  })
  
  observeEvent(input$childcovA_b, {
    cparam_b$childCov <- input$childcovA_b
  })
# disability benefit (dparam_b) ####
  dparam_b <- reactiveValues()
  dparam_b$disabCov <- 75
  dparam_b$disab <- FALSE
  dparam_b$disabAge <- c(0,64)
  dparam_b$disabTrans <- 0
  dparam_b$disabAdmin <- 5
  dparam_b$disabMeans <- FALSE
  
  observeEvent(input$country_b, {
    dparam_b$disabCov <- 100
    dparam_b$disab <- FALSE
    dparam_b$disabAge <- c(0,64)
    dparam_b$disabTrans <- 0
    dparam_b$disabAdmin <- 5
    dparam_b$disabMeans <- FALSE
  })
  
  observeEvent(input$disabilitybenefit_b, {
    dparam_b$disab <- input$disabilitybenefit_b
    dparam_b$disabMeans <- FALSE
  })
  
  observeEvent(input$disabageA_b, {
    dparam_b$disabAge <- input$disabageA_b
  })
  
  observeEvent({if (!is.null(input$disabilitybenefit_b) && input$disabilitybenefit_b==TRUE) TRUE
     }, {
      dparam_b$disabAge <- c(0,64)
    })
  
  observeEvent({if (!is.null(input$disabilitybenefit_b) && input$disabilitybenefit_b==FALSE) TRUE
     }, {
      dparam_b$disabTrans <- 0
    })
  
  observeEvent(input$disabtransferA_b, {
    dparam_b$disabTrans <- input$disabtransferA_b
  })
  
  observeEvent(input$disab_admin_b, {
    dparam_b$disabAdmin <- input$disab_admin_b
  })
  
  observeEvent(input$disabmeansA_b, {
    dparam_b$disabMeans <- input$disabmeansA_b
  })
  
  observeEvent(input$disabcovA_b, {
    dparam_b$disabCov <- input$disabcovA_b
  })

# old age benefit (oparam_b) ####
  oparam_b <- reactiveValues()
  oparam_b$old <- FALSE
  oparam_b$oldCov <- 75
  oparam_b$oldAge <- c(65,100)
  oparam_b$oldTrans <- 0
  oparam_b$oldAdmin <- 5
  oparam_b$oldPension <- FALSE
  oparam_b$oldMeans <- FALSE
  
  observeEvent(input$country_b, {
    oparam_b$old <- FALSE
    oparam_b$oldCov <- 100
    oparam_b$oldAge <- c(65,100)
    oparam_b$oldTrans <- 0
    oparam_b$oldAdmin <- 5
    oparam_b$oldPension <- FALSE
    oparam_b$oldMeans <- FALSE
  })
  
  observeEvent(input$oldagebenefit_b, {
    oparam_b$old <- input$oldagebenefit_b
    oparam_b$oldMeans <- FALSE
  })  
  
  observeEvent(input$oldageA_b, {
    oparam_b$oldAge <- input$oldageA_b
  })
  
  observeEvent({if (!is.null(input$oldagebenefit_b) && input$oldagebenefit_b==TRUE) TRUE
     }, {
      oparam_b$oldAge <- c(65,100)
    })
  
  observeEvent({if (!is.null(input$oldagebenefit_b) && input$oldagebenefit_b==FALSE) TRUE
     }, {
      oparam_b$oldTrans <- 0
    })
  
  observeEvent(input$oldtransferA_b, {
    oparam_b$oldTrans <- input$oldtransferA_b
  })
  
  observeEvent(input$old_admin_b, {
    oparam_b$oldAdmin <- input$old_admin_b
  })
  
  observeEvent(input$pensiontest_b, {
    oparam_b$oldPension <- input$pensiontest_b
  })
  
  observeEvent(input$oldmeansA_b, {
    oparam_b$oldMeans <- input$oldmeansA_b
  })
  
  observeEvent(input$oldcovA_b, {
    oparam_b$oldCov <- input$oldcovA_b
  })

# household benefit (hparam_b) ####
  hparam_b <- reactiveValues()
  hparam_b$hhCov <- 20
  hparam_b$hhTrans <- 0
  hparam_b$hhAdmin <- 10
  
  observeEvent(input$country_b, {
    hparam_b$hhCov <- 20
    hparam_b$hhTrans <- 0
    hparam_b$hhAdmin <- 10
  })
  
  observeEvent(input$hhcovB_b, {
    hparam_b$hhCov <- input$hhcovB_b
  })
  
  observeEvent({if (!is.null(input$meanstested_b) && input$meanstested_b==TRUE) TRUE
     }, {
      hparam_b$hhCov <- 20
    })
  
  observeEvent({if (!is.null(input$meanstested_b) && input$meanstested_b==FALSE) TRUE
     }, {
      hparam_b$hhTrans <- 0
    })
  
  observeEvent(input$hhtransferB_b, {
    hparam_b$hhTrans <- input$hhtransferB_b
  })
  
  observeEvent(input$hh_admin_b, {
    hparam_b$hhAdmin <- input$hh_admin_b
  })
  
  gdpparam_b <- reactiveValues()
  gdpparam_b$gdp <- 4
  
  observeEvent(input$country_b, {
    gdpparam_b$gdp <- econ_b()$growth
  })
  
  observeEvent(input$gdp_proj_b, {
    gdpparam_b$gdp <- input$gdp_proj_b
  })

