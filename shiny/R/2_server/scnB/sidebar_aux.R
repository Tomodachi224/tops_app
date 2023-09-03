## Reactives and outputs for text on sidebar

## reactives in this file:
## 1. welfarelevelchild_b
## 2. welfareleveldisab_b
## 3. welfarelevelold_b
## 4. welfarelevelhh_b

## outputs in this file:
## 1. childmeansA_welfare_b
## 2. gdppercapita_childA_b
## 3. disabmeansA_welfare_b
## 4. gdppercapita_disabA_b
## 5. oldmeansA_welfare_b
## 6. gdppercapita_oldA_b
## 7. hhmeansB_welfare_b
## 8. gdppercapita_B_b
## 9. gdpgrowthrate_b
## 10. existing_childA_b
## 11. existing_disabA_b
## 12. existing_oldA_b
## 13. existing_B_b

### income threshold and exclusion error ####
exclusionerrors_b <- eventReactive(input$run_b, {
  if (mparam_b$matMeans == TRUE &&
      mparam_b$matCov > 0 && mparam_b$matCov < 100) {
    data1 <- impact_data_b()
    data1<- data1[(data1$newmother==1), ]
    
    data1$excluded = (data1$rank_matA > input$matcovA_b) * 100
    data1 <- data1[order(data1$adj_welfare),]
    
    data1$cumul <-(100 * cumsum(data1$weight) / sum(data1$weight))
    data1 <- data1[data1$cumul < input$matcovA_b, ]
    
    data1$exclusionrate <- weighted.mean(data1$excluded, data1$weight)
    error <- round(data1$exclusionrate[1], 1)
    
    sum <- round(max(data1$adj_welfare), 0)
    
    textmatA <-
      paste(
        "Means-tested programmes often apply a proxy means test to determine eligibility. The selected coverage determines that only mothers of newborns with a household consumption expenditure below ",
        econ_b()$cur,
        " ",
        format(sum, nsmall = 0 , big.mark = ","),
        " per month per capita are eligible. ",
        "Once applying a regression-based proxy means test and restricting coverage, up to ",
        format(error, nsmall = 0 , big.mark = ","),
        "% of eligible mothers of newborns are likely to be excluded from the programme due to targeting errors. For more information about the applied proxy means test, see the About page.",
        sep = ""
      )
  } else {
    textmatA <- ""
  }
  
  if (cparam_b$childMeans == TRUE &&
      cparam_b$childCov > 0 && cparam_b$childCov < 100) {
    data1 <- impact_data_b()
    data1<- data1[(data1$age>=input$childageA_b[1] & data1$age<=input$childageA_b[2]), ]
    
    data1$excluded = (data1$rank_childA > input$childcovA_b) * 100
    data1 <- data1[order(data1$adj_welfare),]
    
    data1$cumul <-(100 * cumsum(data1$weight) / sum(data1$weight))
    data1 <- data1[data1$cumul < input$childcovA_b, ]
    
    data1$exclusionrate <- weighted.mean(data1$excluded, data1$weight)
    error <- round(data1$exclusionrate[1], 1)
    
    sum <- round(max(data1$adj_welfare), 0)
    
    textchildA <-
      paste(
        "Means-tested programmes often apply a proxy means test to determine eligibility. The selected coverage determines that only children aged ",
        cparam_b$childAge[1],
        " to ",
        cparam_b$childAge[2],
        " years with a household consumption expenditure below ",
        econ_b()$cur,
        " ",
        format(sum, nsmall = 0 , big.mark = ","),
        " per month per capita are eligible. ",
        "Once applying a regression-based proxy means test and restricting coverage, up to ",
        format(error, nsmall = 0 , big.mark = ","),
        "% of eligible children are likely to be excluded from the programme due to targeting errors. For more information about the applied proxy means test, see the About page.",
        sep = ""
      )
  } else {
    textchildA <- ""
  }
  
  if (dparam_b$disabMeans == TRUE &&
      dparam_b$disabCov > 0 && dparam_b$disabCov < 100) {
    
    
    data2 <- impact_data_b()
    data2 <- data2[(data2$disab==1 & data2$age>=input$disabageA_b[1] & data2$age<=input$disabageA_b[2]), ]
    
    data2$excluded = (data2$rank_disabA > input$disabcovA_b) * 100
    data2 <- data2[order(data2$adj_welfare),]
    
    data2$cumul <-(100 * cumsum(data2$weight) / sum(data2$weight))
    data2 <- data2[data2$cumul < input$disabcovA_b, ]
    
    data2$exclusionrate <- weighted.mean(data2$excluded, data2$weight)
    error <- round(data2$exclusionrate[1], 1)
    
    sum <- round(max(data2$adj_welfare), 0)
    
    textdisabA <-
      paste(
        "Means-tested programmes often apply a proxy means test to determine eligibility. The selected coverage determines that only persons with severe disabilities aged ",
        dparam_b$disabAge[1],
        " to ",
        dparam_b$disabAge[2],
        " years with a household consumption expenditure below ",
        econ_b()$cur,
        " ",
        format(sum, nsmall = 0 , big.mark = ","),
        " per month per capita are eligible. ",
        "Once applying a regression-based proxy means test and restricting coverage, up to ",
        format(error, nsmall = 0 , big.mark = ","),
        "% of eligible persons with severe disabilities are likely to be excluded from the programme due to targeting errors. For more information about the applied proxy means test, see the About page.",
        sep = ""
      )
  } else {
    textdisabA <- ""
  }
  
  if (oparam_b$oldMeans == TRUE &&
      oparam_b$oldCov > 0 && oparam_b$oldCov < 100) {
    
    data3 <- impact_data_b()
    if (oparam_b$oldPension==TRUE) {
      data3 <- data3[(data3$pension==0 & data3$age>=input$oldageA_b[1] & data3$age<=input$oldageA_b[2]), ]
    } else {
      data3 <- data3[(data3$age>=input$oldageA_b[1] & data3$age<=input$oldageA_b[2]), ]
    }
    
    data3$excluded = (data3$rank_oldA > input$oldcovA_b) * 100
    data3 <- data3[order(data3$adj_welfare),]
    
    data3$cumul <-(100 * cumsum(data3$weight) / sum(data3$weight))
    data3 <- data3[data3$cumul < input$oldcovA_b, ]
    
    data3$exclusionrate <- weighted.mean(data3$excluded, data3$weight)
    error <- round(data3$exclusionrate[1], 1)
    
    sum <- round(max(data3$adj_welfare), 0)
    
    textoldA <-
      paste(
        "Means-tested programmes often apply a proxy means test to determine eligibility. The selected coverage determines that only older people aged ",
        oparam_b$oldAge[1],
        " + ",
        "years with a household consumption expenditure below ",
        econ_b()$cur,
        " ",
        format(sum, nsmall = 0 , big.mark = ","),
        " per month per capita are eligible. ",
        "Once applying a regression-based proxy means test and restricting coverage, up to ",
        format(error, nsmall = 0 , big.mark = ","),
        "% of eligible older people are likely to be excluded from the programme due to targeting errors. For more information about the applied proxy means test, see the About page.",
        sep = ""
      )
  } else {
    textoldA <- ""
  }
  
  if (hparam_b$hhCov > 0 && hparam_b$hhCov < 100) {
    data <- impact_data_b()
    data <- data[order(data$pmt),]
    data$excluded = ((100 * cumsum(data$weight) / sum(data$weight)) > input$hhcovB_b) * 100
    data <- data[order(data$adj_welfare),]
    
    data <- data[order(data$adj_welfare),]
    data$cumul <- (100 * cumsum(data$weight) / sum(data$weight))
    data <- data[data$cumul < input$hhcovB_b, ]
    
    sum <- round(max(data$adj_welfare), 2)
    
    data$exclusionrate <-
      weighted.mean(data$excluded, data$weight)
    error <- round(data$exclusionrate[1], 0)
    
    textB <-
      paste(
        "Means-tested programmes often apply a proxy means test to determine eligibility. The selected coverage determines that only households with expenditure below ",
        econ_b()$cur,
        " ",
        format(sum, nsmall = 0 , big.mark = ","),
        " per month per capita are eligible. ",
        "Once applying a regression-based proxy means test and restricting coverage, up to ",
        format(error, nsmall = 0 , big.mark = ","),
        "% of eligible households are likely to be excluded from the programme due to targeting errors. For more information about the applied proxy means test, see the About page.",
        sep = ""
      )
  } else {
    textB <- ""
  }
  
  textA <- ""
  
  list(matA = textmatA, childA = textchildA, disabA = textdisabA, oldA = textoldA, B = textB, A = textA)
})

  ### transfer as gdp per capita ####
  
  # maternity benefit
  output$gdppercapita_matA_b <- renderText({
    validate(need(
      input$mattransferA_b != "",
      "Please enter a non-negative transfer value"
    ))
    gdppc <- econ_b()$gdppc
    transfmat_gdppc <-
      c((input$mattransferA_b * 12) * 100 / gdppc[1])
    gdppc <- round(transfmat_gdppc, 2)
    ppp_factor <- econ_b()$ppp * econ_b()$cpi22/econ_b()$cpi11
    ppp_equivalent <- round(input$mattransferA_b/ppp_factor, 0)
    text <-
      paste("This is equivalent to $", ppp_equivalent, " PPP, or ", gdppc, "% of GDP per capita per annum.", sep = "")
    return(text)
  })
  
  # Child benefit
  output$gdppercapita_childA_b <- renderText({
    validate(need(
      input$childtransferA_b != "",
      "Please enter a non-negative transfer value"
    ))
    gdppc <- econ_b()$gdppc
    transfchild_gdppc <-
      c((input$childtransferA_b * 12) * 100 / gdppc[1])
    gdppc <- round(transfchild_gdppc, 2)
    ppp_factor <- econ_b()$ppp * econ_b()$cpi22/econ_b()$cpi11
    ppp_equivalent <- round(input$childtransferA_b/ppp_factor, 0)
    text <-
      paste("This is equivalent to $", ppp_equivalent, " PPP, or ", gdppc, "% of GDP per capita per annum.", sep = "")
    return(text)
  })
 
  # Disability benefit
  output$gdppercapita_disabA_b <- renderText({
    validate(need(
      input$disabtransferA_b != "",
      "Please enter a non-negative transfer value"
    ))
    gdppc <- econ_b()$gdppc
    transfdisab_gdppc <-
      c((input$disabtransferA_b * 12) * 100 / gdppc[1])
    gdppc <- round(transfdisab_gdppc, 2)
    ppp_factor <- econ_b()$ppp * econ_b()$cpi22/econ_b()$cpi11
    ppp_equivalent <- round(input$disabtransferA_b/ppp_factor, 0)
    text <-
      paste("This is equivalent to $", ppp_equivalent, " PPP, or ", gdppc, "% of GDP per capita per annum.", sep = "")
    return(text)
  })
  
  # old age benefit
  output$gdppercapita_oldA_b <- renderText({
    validate(need(
      input$oldtransferA_b != "",
      "Please enter a non-negative transfer value"
    ))
    gdppc <- econ_b()$gdppc
    transfold_gdppc <- c((input$oldtransferA_b * 12) * 100 / gdppc[1])
    gdppc <- round(transfold_gdppc, 2)
    ppp_factor <- econ_b()$ppp * econ_b()$cpi22/econ_b()$cpi11
    ppp_equivalent <- round(input$oldtransferA_b/ppp_factor, 0)
    text <-
      paste("This is equivalent to $", ppp_equivalent, " PPP, or ", gdppc, "% of GDP per capita per annum.", sep = "")
    return(text)
  })
  
  # household benefit
  output$gdppercapita_B_b <- renderText({
    validate(need(
      input$hhtransferB_b != "",
      "Please enter a non-negative transfer value"
    ))
    gdppc <- econ_b()$gdppc
    hhsize <- demo_b()$hhsize
    transfhh_gdppc <-
      c((input$hhtransferB_b * 12) * 100 / (gdppc[1] * hhsize[1]))
    gdppc <- round(transfhh_gdppc, 2)
    ppp_factor <- econ_b()$ppp * econ_b()$cpi22/econ_b()$cpi11
    ppp_equivalent <- round(input$hhtransferB_b/ppp_factor, 0)
    text <-
      paste("This is equivalent to $", ppp_equivalent, " PPP, or ", gdppc, "% of GDP per capita per annum.", sep = "")
    return(text)
  }) 
  
  # GDP growth rate ####
  output$gdpgrowthrate_b <- renderUI({
    popify(
      sliderInput(
        inputId = "gdp_proj_b",
        "Drag slider to change future annual real GDP growth: 0% - 10%",
        min = 0,
        max = 10,
        value = gdpparam_b$gdp,
        post = "%",
        step = 0.1
      ),
      "",
      "This is the projected average annual growth rate. The default uses IMF projections up to 2023"
    )
  })

  ### Existing programmes ####
  lapply(c("matA", "childA", "disabA", "oldA", "B"), function(i) {
    output[[paste0("existing_", i, "_b")]] <- renderText({
      col <- match(param_b$country, countrylist) + 1
      text <- paste(existingProg[existingProg$progtype == i, col])
      return(text)
    })
  })

