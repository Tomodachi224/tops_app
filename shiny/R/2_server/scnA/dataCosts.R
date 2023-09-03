## Reactive cost and fin data

## reactives in this file:
## 1. costs_data
## 2. fin_data
## 3. plot_cost_prog

costs_data <- eventReactive(input$run, {
  
  if (!is.null(input$mattransferA) && input$matbenefit==TRUE) {
    recmat <- demo()$data %>% select(c(2)) %>% rowSums(na.rm=TRUE)
    if (input[[paste0('mat', 'meansA')]] == TRUE) {
      recmat <- recmat*input$matcovA / 100
    }
    costsmat <- c((recmat * 1000 * 12 * input$mattransferA * (input$matlengthA *7/30/ 12)* (1 + input$mat_admin / 100)) / (10 ^ 9))
    costsmat_gdp <- c(costsmat * 100 / econ()$gdp)
    transfmat_gdppc <-
      c((input$mattransferA * 12) * 100 / (econ()$gdppc))
  } else {
    recmat <- rep(c(0), times = 10)
    costsmat <- rep(c(0), times = 10)
    costsmat_gdp <- rep(c(0), times = 10)
    transfmat_gdppc <- rep(c(0), times = 10)
  }
  
  prog_selection <- list(
    child_prog = input$childbenefit,
    disab_prog = input$disabilitybenefit,
    old_prog = input$oldagebenefit
  )
  
  recipients <- lapply(c("child", "disab", "old"), function(i) {
    agemin <- input[[paste0(i, 'ageA')]][1] + 2
    agemax <- input[[paste0(i, 'ageA')]][2] + 2
    if (!is.null(prog_selection[[paste0(i, '_prog')]]) && prog_selection[[paste0(i, '_prog')]]==TRUE) {
      if (i == "disab") {
        totelig <- demo()$disab %>% select(c(agemin:agemax)) %>% rowSums(na.rm=TRUE)
      } else {
        totelig <- demo()$data %>% select(c(agemin:agemax)) %>% rowSums(na.rm=TRUE)
      }
      if (input[[paste0(i, 'meansA')]] == TRUE) {
        totelig <- totelig*input[[paste0(i, 'covA')]] /  100
      }
      if (i == "old" & input$pensiontest==TRUE) {
        data <- svydata() %>% filter(age>=agemin - 2 & age<=agemax -2 ) %>% select(c("pension","weight"))
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
      c((recipients[[paste0(i)]] * 1000 * input[[paste0(i, 'transferA')]] * 12 * (1 + input[[paste0(i, '_admin')]] / 100)) / (10 ^ 9))
    } else {
      rep(c(0), times = 10)
    }
  })
  names(costs) <- c("child", "disab", "old")
  
  transf_gdppc <-
    lapply(c("child", "disab", "old"), function(i) {
      if (!is.null(prog_selection[[paste0(i, '_prog')]]) && prog_selection[[paste0(i, '_prog')]]==TRUE) {
        c((input[[paste0(i, 'transferA')]] * 12) * 100 / econ()$gdppc)
      } else {
        rep(c(0), times = 10)
      }
    })
  names(transf_gdppc) <- c("child", "disab", "old")
  
  if (!is.null(input$meanstested) && input$meanstested==TRUE) {
    rechh <- c(demo()$tot_hh  * (input$hhcovB / 100))
    costshh <- c((rechh * 1000 * 12 * input$hhtransferB * (1 + input$hh_admin / 100)) / (10 ^ 9))
    costshh_gdp <- c(costshh * 100 / econ()$gdp)
    transfhh_gdppc <-
      c((input$hhtransferB * 12) * 100 / (econ()$gdppc * demo()$hhsize))
  } else {
    rechh <- rep(c(0), times = 10)
    costshh <- rep(c(0), times = 10)
    costshh_gdp <- rep(c(0), times = 10)
    transfhh_gdppc <- rep(c(0), times = 10)
  }
  
  rectotal  <- recmat + recipients$child + recipients$disab + recipients$old + rechh
  costtotal <- c(costsmat + costs$child + costs$disab + costs$old + costshh)
  costschild_gdp <- c(costs$child * 100 / econ()$gdp)
  costsdisab_gdp <- c(costs$disab * 100 / econ()$gdp)
  costsold_gdp <- c(costs$old * 100 / econ()$gdp)
  costtot_gdp <- c(costtotal * 100 / econ()$gdp)
  
  data <- data.frame(
    year = as.character(c(2022:2031)),
    gdp = econ()$gdp,
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

fin_data <- eventReactive(input$run,{
  data <- costs_data()
  govrev <- econ()$rev
  
  data$gdp <- econ()$gdp
  data$govrev <- govrev * data$gdp
  
  for (i in c("A", "matA", "childA", "disabA", "oldA", "B")) {
    data[[paste0("cost_rev_", i)]] <- round((data[[paste0("costs", i)]]/1000) * 100 / data$govrev, 2)
  }

  return(data)
})

plot_cost_prog <- eventReactive(input$run, {
  
  if (!is.null(input$mattransferA) && input$matbenefit == TRUE) {
    pmat = "Maternity Benefit"
  } else {
    pmat = ""
  }
  
  if (!is.null(input$childtransferA) && input$childbenefit == TRUE) {
    pchild = "Child Benefit"
  } else {
    pchild = ""
  }
  
  if (!is.null(input$disabtransferA) && input$disabilitybenefit == TRUE) {
    pdisab = "Disability Benefit"
  } else {
    pdisab = ""
  }
  
  if (!is.null(input$oldtransferA) && input$oldagebenefit == TRUE) {
    pold= "Old Age Benefit"
  } else {
    pold = ""
  }
  
  if (!is.null(input$hhtransferB) && input$meanstested == TRUE) {
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
