## Reactive cost and fin data

## reactives in this file:
## 1. costs_data_b
## 2. fin_data_b
## 3. plot_cost_prog_b

costs_data_b <- eventReactive(input$run_b, {
  
  if (!is.null(input$mattransferA_b) && input$matbenefit_b==TRUE) {
    recmat <- demo_b()$data %>% select(c(2)) %>% rowSums(na.rm=TRUE)
    if (input[[paste0('mat', 'meansA_b')]] == TRUE) {
      recmat <- recmat*input$matcovA_b / 100
    }
    costsmat <- c((recmat * 1000 * 12 * input$mattransferA_b * (input$matlengthA_b *7/30/12)* (1 + input$mat_admin_b / 100)) / (10 ^ 9))
    costsmat_gdp <- c(costsmat * 100 / econ_b()$gdp)
    transfmat_gdppc <-
      c((input$mattransferA_b * 12) * 100 / (econ_b()$gdppc))
  } else {
    recmat <- rep(c(0), times = 10)
    costsmat <- rep(c(0), times = 10)
    costsmat_gdp <- rep(c(0), times = 10)
    transfmat_gdppc <- rep(c(0), times = 10)
  }
  
  prog_selection <- list(
    child_prog = input$childbenefit_b,
    disab_prog = input$disabilitybenefit_b,
    old_prog = input$oldagebenefit_b
  )
  
  recipients <- lapply(c("child", "disab", "old"), function(i) {
    agemin <- input[[paste0(i, 'ageA_b')]][1] + 2
    agemax <- input[[paste0(i, 'ageA_b')]][2] + 2
    if (!is.null(prog_selection[[paste0(i, '_prog')]]) && prog_selection[[paste0(i, '_prog')]]==TRUE) {
      if (i == "disab") {
        totelig <- demo_b()$disab %>% select(c(agemin:agemax)) %>% rowSums(na.rm=TRUE)
      } else {
        totelig <- demo_b()$data %>% select(c(agemin:agemax)) %>% rowSums(na.rm=TRUE)
      }
      if (input[[paste0(i, 'meansA_b')]] == TRUE) {
        totelig <- totelig*input[[paste0(i, 'covA_b')]] /  100
      }
      if (i == "old" & input$pensiontest_b==TRUE) {
        data <- svydata_b() %>% filter(age>=agemin - 2 & age<=agemax -2 ) %>% select(c("pension","weight"))
        share <- 100 - sum(data$weight * data$pension)*100 / sum(data$weight)
        totelig <- totelig*share/100
      }
      return(totelig)
    } else {
      return(rep(c(0), times = 10))
    }
  }
  )
  names(recipients) <- c("child", "disab", "old")
  
  costs <- lapply(c("child", "disab", "old"), function(i) {
    if (!is.null(prog_selection[[paste0(i, '_prog')]]) && prog_selection[[paste0(i, '_prog')]]==TRUE) {
      c((recipients[[paste0(i)]] * 1000 * input[[paste0(i, 'transferA_b')]] * 12 * (1 + input[[paste0(i, '_admin_b')]] / 100)) / (10 ^ 9))
    } else {
      rep(c(0), times = 10)
    }
  })
  names(costs) <- c("child", "disab", "old")
  
  transf_gdppc <-
    lapply(c("child", "disab", "old"), function(i) {
      if (!is.null(prog_selection[[paste0(i, '_prog')]]) && prog_selection[[paste0(i, '_prog')]]==TRUE) {
        c((input[[paste0(i, 'transferA_b')]] * 12) * 100 / econ_b()$gdppc)
      } else {
        rep(c(0), times = 10)
      }
    })
  names(transf_gdppc) <- c("child", "disab", "old")
  
  if (!is.null(input$hhtransferB_b) && input$meanstested_b==TRUE) {
    rechh <- c(demo_b()$tot_hh  * (input$hhcovB_b / 100))
    costshh <- c((rechh * 1000 * 12 * input$hhtransferB_b * (1 + input$hh_admin_b / 100)) / (10 ^ 9))
    costshh_gdp <- c(costshh * 100 / econ_b()$gdp)
    transfhh_gdppc <-
      c((input$hhtransferB_b * 12) * 100 / (econ_b()$gdppc * demo_b()$hhsize))
  } else {
    rechh <- rep(c(0), times = 10)
    costshh <- rep(c(0), times = 10)
    costshh_gdp <- rep(c(0), times = 10)
    transfhh_gdppc <- rep(c(0), times = 10)
  }
  
  rectotal  <- recmat + recipients$child + recipients$disab + recipients$old + rechh
  costtotal <- c(costsmat + costs$child + costs$disab + costs$old + costshh)
  costschild_gdp <- c(costs$child * 100 / econ_b()$gdp)
  costsdisab_gdp <- c(costs$disab * 100 / econ_b()$gdp)
  costsold_gdp <- c(costs$old * 100 / econ_b()$gdp)
  costtot_gdp <- c(costtotal * 100 / econ_b()$gdp)
  
  data <- data.frame(
    year = as.character(c(2022:2031)),
    gdp = econ_b()$gdp,
    recA = format(round(rectotal*1000, 0), nsmall = 0, big.mark = ","),
    costsA = round(costtotal*1000, 1),
    costsA_gdp = round(costtot_gdp, 2),
    recmatA = format(round(recmat*1000, 0), nsmall = 0, big.mark = ","),
    costsmatA = round(costsmat*1000, 1),
    costsmatA_gdp = round(costsmat_gdp, 2),
    recchildA = format(round(recipients$child*1000, 0), nsmall = 0, big.mark = ","),
    costschildA = round(costs$child*1000, 1),
    costschildA_gdp = round(costschild_gdp, 2),
    recdisabA = format(round(recipients$disab*1000, 0), nsmall = 0, big.mark = ","),
    costsdisabA = round(costs$disab*1000, 1),
    costsdisabA_gdp = round(costsdisab_gdp, 2),
    recoldA = format(round(recipients$old*1000, 0), nsmall = 0, big.mark = ","),
    costsoldA = round(costs$old*1000, 1),
    costsoldA_gdp = round(costsold_gdp, 2),
    recB = format(round(rechh*1000, 0), nsmall = 0, big.mark = ","),
    costsB = round(costshh*1000, 1),
    costsB_gdp = round(costshh_gdp, 2),
    transfchildA_gdppc = round(transf_gdppc$child, 2),
    transfdisabA_gdppc = round(transf_gdppc$disab, 2),
    transfoldA_gdppc = round(transf_gdppc$old, 2),
    transfB_gdppc = round(transfhh_gdppc, 2)
  )
return(data)
})

fin_data_b <- reactive({
  data <- costs_data_b()
  govrev <- econ_b()$rev
  
  data$gdp <- econ_b()$gdp
  data$govrev <- govrev * data$gdp
  
  for (i in c("A", "matA", "childA", "disabA", "oldA", "B")) {
    data[[paste0("cost_rev_", i)]] <- round((data[[paste0("costs", i)]]/1000) * 100 / data$govrev, 2)
  }
  
  return(data)
})

plot_cost_prog_b <- eventReactive(input$run_b, {
  
  if (!is.null(input$mattransferA_b) && input$matbenefit_b == TRUE) {
    pmat = "Maternity Benefit"
  } else {
    pmat = ""
  }
  
  if (!is.null(input$childtransferA_b) && input$childbenefit_b == TRUE) {
    pchild = "Child Benefit"
  } else {
    pchild = ""
  }
  
  if (!is.null(input$disabtransferA_b) && input$disabilitybenefit_b == TRUE) {
    pdisab = "Disability Benefit"
  } else {
    pdisab = ""
  }
  
  if (!is.null(input$oldtransferA_b) && input$oldagebenefit_b == TRUE) {
    pold= "Old Age Benefit"
  } else {
    pold = ""
  }
  
  if (!is.null(input$hhtransferB_b) && input$meanstested_b == TRUE) {
    phh = "Household Benefit"
  } else {
    phh = ""
  }
  programmes <- c(pmat, pchild, pdisab, pold, phh)
  programmes <- programmes[programmes != ""]
  
  list <- list(
    A = programmes,
    matA = c("Maternity Benefit"),
    childA = c("Child Benefit"),
    disabA = c("Disability Benefit"),
    oldA = c("Old Age Benefit"),
    B = c("Household Benefit")
  )
  return(list)
})
