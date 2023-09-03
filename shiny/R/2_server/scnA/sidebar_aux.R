## Reactives and outputs for text on sidebar

## reactives in this file:
## 1. welfarelevelchild
## 2. welfareleveldisab
## 3. welfarelevelold
## 4. welfarelevelhh

## outputs in this file:
## 1. childmeansA_welfare
## 2. gdppercapita_childA
## 3. disabmeansA_welfare
## 4. gdppercapita_disabA
## 5. oldmeansA_welfare
## 6. gdppercapita_oldA
## 7. hhmeansB_welfare
## 8. gdppercapita_B
## 9. gdpgrowthrate
## 10. existing_childA
## 11. existing_disabA
## 12. existing_oldA
## 13. existing_B

  ### income threshold and exclusion error ####
  exclusionerrors <- eventReactive(input$run, {
    if (mparam$matMeans == TRUE &&
        mparam$matCov > 0 && mparam$matCov < 100) {
      data1 <- impact_data()
      data1<- data1[(data1$newmother==1), ]
    
      data1$excluded = (data1$rank_matA > input$matcovA) * 100
      data1 <- data1[order(data1$adj_welfare),]
      
      data1$cumul <-(100 * cumsum(data1$weight) / sum(data1$weight))
      data1 <- data1[data1$cumul < input$matcovA, ]
      
      data1$exclusionrate <- weighted.mean(data1$excluded, data1$weight)
      error <- round(data1$exclusionrate[1], 1)
      
      sum <- round(max(data1$adj_welfare), 0)
      
      textmatA <-
        paste(
          "Means-tested programmes often apply a proxy means test to determine eligibility. The selected coverage determines that only mothers of newborns with a household consumption expenditure below ",
          econ()$cur,
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
    
    if (cparam$childMeans == TRUE &&
        cparam$childCov > 0 && cparam$childCov < 100) {
      data1 <- impact_data()
      data1<- data1[(data1$age>=input$childageA[1] & data1$age<=input$childageA[2]), ]
      
      data1$excluded = (data1$rank_childA > input$childcovA) * 100
      data1 <- data1[order(data1$adj_welfare),]
      
      data1$cumul <-(100 * cumsum(data1$weight) / sum(data1$weight))
      data1 <- data1[data1$cumul < input$childcovA, ]
      
      data1$exclusionrate <- weighted.mean(data1$excluded, data1$weight)
      error <- round(data1$exclusionrate[1], 1)
      
      sum <- round(max(data1$adj_welfare), 0)
      
      textchildA <-
        paste(
          "Means-tested programmes often apply a proxy means test to determine eligibility. The selected coverage determines that only children aged ",
          cparam$childAge[1],
          " to ",
          cparam$childAge[2],
          " years with a household consumption expenditure below ",
          econ()$cur,
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
    
    if (dparam$disabMeans == TRUE &&
        dparam$disabCov > 0 && dparam$disabCov < 100) {
      
      
      data2 <- impact_data()
      data2 <- data2[(data2$disab==1 & data2$age>=input$disabageA[1] & data2$age<=input$disabageA[2]), ]
      
      data2$excluded = (data2$rank_disabA > input$disabcovA) * 100
      data2 <- data2[order(data2$adj_welfare),]
      
      data2$cumul <-(100 * cumsum(data2$weight) / sum(data2$weight))
      data2 <- data2[data2$cumul < input$disabcovA, ]
      
      data2$exclusionrate <- weighted.mean(data2$excluded, data2$weight)
      error <- round(data2$exclusionrate[1], 1)
      
      sum <- round(max(data2$adj_welfare), 0)
      
      textdisabA <-
        paste(
          "Means-tested programmes often apply a proxy means test to determine eligibility. The selected coverage determines that only persons with severe disabilities aged ",
          dparam$disabAge[1],
          " to ",
          dparam$disabAge[2],
          " years with a household consumption expenditure below ",
          econ()$cur,
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
    
    if (oparam$oldMeans == TRUE &&
        oparam$oldCov > 0 && oparam$oldCov < 100) {
      
      data3 <- impact_data()
      if (oparam$oldPension==TRUE) {
        data3 <- data3[(data3$pension==0 & data3$age>=input$oldageA[1] & data3$age<=input$oldageA[2]), ]
      } else {
        data3 <- data3[(data3$age>=input$oldageA[1] & data3$age<=input$oldageA[2]), ]
      }
      
      data3$excluded = (data3$rank_oldA > input$oldcovA) * 100
      data3 <- data3[order(data3$adj_welfare),]
      
      data3$cumul <-(100 * cumsum(data3$weight) / sum(data3$weight))
      data3 <- data3[data3$cumul < input$oldcovA, ]
      
      data3$exclusionrate <- weighted.mean(data3$excluded, data3$weight)
      error <- round(data3$exclusionrate[1], 1)
      
      sum <- round(max(data3$adj_welfare), 0)
      
      textoldA <-
        paste(
          "Means-tested programmes often apply a proxy means test to determine eligibility. The selected coverage determines that only older people aged ",
          oparam$oldAge[1],
          " + ",
          "years with a household consumption expenditure below ",
          econ()$cur,
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
    
    if (hparam$hhCov > 0 && hparam$hhCov < 100) {
    data <- impact_data()
    data <- data[order(data$pmt),]
    data$excluded = ((100 * cumsum(data$weight) / sum(data$weight)) > input$hhcovB) * 100
    data <- data[order(data$adj_welfare),]
    
    data <- data[order(data$adj_welfare),]
    data$cumul <- (100 * cumsum(data$weight) / sum(data$weight))
    data <- data[data$cumul < input$hhcovB, ]
    
    sum <- round(max(data$adj_welfare), 2)
    
    data$exclusionrate <-
      weighted.mean(data$excluded, data$weight)
    error <- round(data$exclusionrate[1], 0)
    
    textB <-
      paste(
        "Means-tested programmes often apply a proxy means test to determine eligibility. The selected coverage determines that only households with expenditure below ",
        econ()$cur,
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
  # Maternity benefit
  output$gdppercapita_matA <- renderText({
    validate(need(
      input$mattransferA != "",
      "Please enter a non-negative transfer value"
    ))
    gdppc <- econ()$gdppc
    transfmat_gdppc <-
      c((input$mattransferA * 12) * 100 / gdppc[1])
    gdppc <- round(transfmat_gdppc, 2)
    ppp_factor <- econ()$ppp * econ()$cpi22/econ()$cpi11
    ppp_equivalent <- round(input$mattransferA/ppp_factor, 0)
    text <-
      paste("This is equivalent to $", ppp_equivalent, " PPP, or ", gdppc, "% of GDP per capita per annum.", sep = "")
    return(text)
  })
  
  # Child benefit
  output$gdppercapita_childA <- renderText({
    validate(need(
      input$childtransferA != "",
      "Please enter a non-negative transfer value"
    ))
    gdppc <- econ()$gdppc
    transfchild_gdppc <-
      c((input$childtransferA * 12) * 100 / gdppc[1])
    gdppc <- round(transfchild_gdppc, 2)
    ppp_factor <- econ()$ppp * econ()$cpi22/econ()$cpi11
    ppp_equivalent <- round(input$childtransferA/ppp_factor, 0)
    text <-
      paste("This is equivalent to $", ppp_equivalent, " PPP, or ", gdppc, "% of GDP per capita per annum.", sep = "")
    return(text)
  })
  
  # Disability benefit
  output$gdppercapita_disabA <- renderText({
    validate(need(
      input$disabtransferA != "",
      "Please enter a non-negative transfer value"
    ))
    gdppc <- econ()$gdppc
    transfdisab_gdppc <-
      c((input$disabtransferA * 12) * 100 / gdppc[1])
    gdppc <- round(transfdisab_gdppc, 2)
    ppp_factor <- econ()$ppp * econ()$cpi22/econ()$cpi11
    ppp_equivalent <- round(input$disabtransferA/ppp_factor, 0)
    text <-
      paste("This is equivalent to $", ppp_equivalent, " PPP, or ", gdppc, "% of GDP per capita per annum.", sep = "")
    return(text)
  })
  
  # old age benefit
  output$gdppercapita_oldA <- renderText({
    validate(need(
      input$oldtransferA != "",
      "Please enter a non-negative transfer value"
    ))
    gdppc <- econ()$gdppc
    transfold_gdppc <- c((input$oldtransferA * 12) * 100 / gdppc[1])
    gdppc <- round(transfold_gdppc, 2)
    ppp_factor <- econ()$ppp * econ()$cpi22/econ()$cpi11
    ppp_equivalent <- round(input$oldtransferA/ppp_factor, 0)
    text <-
      paste("This is equivalent to $", ppp_equivalent, " PPP, or ", gdppc, "% of GDP per capita per annum.", sep = "")
    return(text)
  })
  
  # household benefit 
  output$gdppercapita_B <- renderText({
    validate(need(
      input$hhtransferB != "",
      "Please enter a non-negative transfer value"
    ))
    gdppc <- econ()$gdppc
    hhsize <- demo()$hhsize
    transfhh_gdppc <-
      c((input$hhtransferB * 12) * 100 / (gdppc[1] * hhsize[1]))
    gdppc <- round(transfhh_gdppc, 2)
    ppp_factor <- econ()$ppp * econ()$cpi22/econ()$cpi11
    ppp_equivalent <- round(input$hhtransferB/ppp_factor, 0)
    text <-
      paste("This is equivalent to $", ppp_equivalent, " PPP, or ", gdppc, "% of GDP per capita per annum.", sep = "")
    return(text)
  }) 
  
  ### GDP growth rate ####
  output$gdpgrowthrate <- renderUI({
    popify(
      sliderInput(
        inputId = "gdp_proj",
        "Drag slider to change future annual real GDP growth: 0% - 10%",
        min = 0,
        max = 10,
        value = gdpparam$gdp,
        post = "%",
        step = 0.1
      ),
      "",
      "This is the projected average annual growth rate. The default uses IMF projections up to 2023"
    )
  })

  ### Existing programmes ####
  lapply(c("matA", "childA", "disabA", "oldA", "B"), function(i) {
    output[[paste0("existing_", i)]] <- renderText({
      col <- match(input$country, countrylist) + 1
      text <- paste(existingProg[existingProg$progtype == i, col])
      return(text)
    })
  })

