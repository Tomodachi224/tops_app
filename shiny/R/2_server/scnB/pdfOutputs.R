## pdf_b outputs

pdf_b <- "A"

# text
text_pdf_b  <- reactive({
  data.frame(
    textcov1 = round(totaldata_b()[[paste0("meancov_", pdf_b)]][1]),
    textcov2 = round(deciledata_b()[deciledata_b()$decile==1 & deciledata_b()$female_head==2 & deciledata_b()$rural==2,  c(paste0("meancov_", pdf_b))]),
    textcov3 = round(deciledata_b()[deciledata_b()$decile==10 & deciledata_b()$female_head==2 & deciledata_b()$rural==2,  c(paste0("meancov_", pdf_b))]),
    textcov4 = round(totaldata_b()[[paste0("meancovchildren_", pdf_b)]][1]),
    textcov5 = round(totaldata_b()[[paste0("meancovworking_", pdf_b)]][1]),
    textcov6 = round(totaldata_b()[[paste0("meancovelderly_", pdf_b)]][1]),
    textexp1 = round(totaldata_b()[[paste0("meanexp_", pdf_b)]][1]),
    textexp2 = round(deciledata_b()[deciledata_b()$decile==1 & deciledata_b()$female_head==2 & deciledata_b()$rural==2,  c(paste0("meanexp_", pdf_b))]),
    textcov3 = round(deciledata_b()[deciledata_b()$decile==10 & deciledata_b()$female_head==2 & deciledata_b()$rural==2,  c(paste0("meanexp_", pdf_b))]),
    textexp4 = round(totaldata_b()[[paste0("meanbenexp_", pdf_b)]][1]),
    textexp5 = round(deciledata_b()[deciledata_b()$decile==1 & deciledata_b()$female_head==2 & deciledata_b()$rural==2,  c(paste0("meanbenexp_", pdf_b))]),
    textcov6 = round(deciledata_b()[deciledata_b()$decile==10 & deciledata_b()$female_head==2 & deciledata_b()$rural==2,  c(paste0("meanbenexp_", pdf_b))])
  )
})
data_textpovineq_pdf_b <- reactive({
  data <- impact_data_b()
  before1 <-
    weighted.mean(data$pov, data$weight * data$hhsize)
  after1 <-
    weighted.mean(data[[paste0("post_pov_", pdf_b)]], data$weight * data$hhsize)
  reduction1 <- (before1 - after1) * 100 / before1
  
  before2 <-
    weighted.mean(data$gap, data$weight * data$hhsize)
  after2 <-
    weighted.mean(data[[paste0("post_gap_", pdf_b)]], data$weight * data$hhsize)
  reduction2 <- (before2 - after2) * 100 / before2
  
  data$after <-
    data$adj_welfare - data[[paste0("value_", pdf_b)]] + data[[paste0("transfer_", pdf_b)]]
  
  before3 <-
    gini(data$adj_welfare, data$weight * data$hhsize)
  after3 <- gini(data$after, data$weight * data$hhsize)
  reduction3 <- (before3 - after3) * 100 / before3
  
  is.na(data[[paste0("transfer_", pdf_b)]]) <-
    data[[paste0("transfer_", pdf_b)]] == 0
  data <- data[!is.na(data[[paste0("transfer_", pdf_b)]]),]
  
  before4 <-
    weighted.mean(data$pov, data$weight * data$hhsize)
  after4 <-
    weighted.mean(data[[paste0("post_pov_", pdf_b)]], data$weight * data$hhsize)
  reduction4 <- (before4 - after4) * 100 / before4
  
  before5 <-
    weighted.mean(data$gap, data$weight * data$hhsize)
  after5 <-
    weighted.mean(data[[paste0("post_gap_", pdf_b)]], data$weight * data$hhsize)
  reduction5 <- (before5 - after5) * 100 / before5
  
  data <- data.frame(
    povall = round(c(before1, after1, reduction1), 1),
    gapall = round(c(before2, after2, reduction2), 1),
    gini = round(c(before3, after3, reduction3), 1),
    povben = round(c(before4, after4, reduction4), 1),
    gapben = round(c(before5, after5, reduction5))
  )
  return(data)
})

# coverage
plot_graphcov_exp_pdf_b <- reactive({
  plot <- plotGraphcov_exp(dataGraphcov_exp(d = deciledata_b(), d2 = totaldata_b()))
  plot <- plot + theme(legend.position = "none")
  return(plot)
})

# Consumption expenditure
plot_graphexp_all_pdf_b <- reactive({
  plot <- plotGraphexp_all(d = deciledata_b(), d2 = totaldata_b(), t = c(pdf_b))
  plot <- plot + theme(legend.position = "none")
  return(plot)
})
plot_graphexp_ben_pdf_b <- reactive({
  plot <- plotGraphexp_ben(d = deciledata_b(), d2 = totaldata_b(), t = c(pdf_b))
  plot <- plot + theme(legend.position = "none")
  return(plot)
})

# Poverty and inequality
datapov_pdf_b <- reactive({
  data <- impact_data_b()
  
  current1 <-
    weighted.mean(data$pov, data$weight * data$hhsize)
  before1 <-
    weighted.mean(data[[paste0("pre_pov_", pdf_b)]], data$weight * data$hhsize)
  after1 <-
    weighted.mean(data[[paste0("post_pov_", pdf_b)]], data$weight * data$hhsize)
  reduction1 <- (current1 - after1) * 100 / current1
  
  current2 <-
    weighted.mean(data$povI1, data$weight * data$hhsize)
  before2 <-
    weighted.mean(data[[paste0("pre_povI1_", pdf_b)]], data$weight * data$hhsize)
  after2 <-
    weighted.mean(data[[paste0("post_povI1_", pdf_b)]], data$weight * data$hhsize)
  reduction2 <- (current2 - after2) * 100 / current2
  
  current3 <-
    weighted.mean(data$povI2, data$weight * data$hhsize)
  before3 <-
    weighted.mean(data[[paste0("pre_povI2_", pdf_b)]], data$weight * data$hhsize)
  after3 <-
    weighted.mean(data[[paste0("post_povI2_", pdf_b)]], data$weight * data$hhsize)
  reduction3 <- (current3 - after3) * 100 / current3
  
  current4 <-
    weighted.mean(data$povI3, data$weight * data$hhsize)
  before4 <-
    weighted.mean(data[[paste0("pre_povI3_", pdf_b)]], data$weight * data$hhsize)
  after4 <-
    weighted.mean(data[[paste0("post_povI3_", pdf_b)]], data$weight * data$hhsize)
  reduction4 <- (current4 - after4) * 100 / current4
  
  current <- c(current1, current2, current3, current4)
  before <- c(before1, before2, before3, before4)
  after <- c(after1, after2, after3, after4)
  reduction <-
    c(reduction1, reduction2, reduction3, reduction4)
  
  data <- data.frame(
    Line = c(
      "National",
      "International (PPP $1.9)",
      "International (PPP $3.2)",
      "International (PPP $5.5)"
    ),
    Baseline = round(before, 2),
    Current = round(current, 2),
    After = round(after,2)
  )
  return(data)
})
plot_graphpov_pdf_b <- reactive({
  data <- data.frame(
    pov = c(datapov_pdf_b()$Baseline, datapov_pdf_b()$Current, datapov_pdf_b()$After),
    cat = rep(c("With no schemes",
                "With existing schemes",
                "Post reforms"), each = 4),
    Line = rep(c(
      "National",
      "International (PPP $1.9)",
      "International (PPP $3.2)",
      "International (PPP $5.5)"
    ), times = 3)
  )
  data$cat <-
    factor(data$cat, levels = c("With no schemes",
                                "With existing schemes",
                                "Post reforms"))
  
  plot <- ggplot(data,
                 aes(
                   x = cat,
                   y = pov,
                   fill=Line,
                   text = paste(
                     cat, 
                     "<br>", 
                     "Poverty line:",
                     Line,
                     "<br>",
                     "Poverty:",
                     pov
                   )
                 )
  ) +
    geom_bar(
      stat = "identity",
      position = "dodge",
      size = .2,
      alpha = 1
    ) +
    labs(y = "Poverty rate (%)") +
    scale_fill_manual(values=c("#c0d5fa","#8EA9DB","#2c4c8b","#203764"))+
    scale_x_discrete(
      name = "",
      limits = c("With no schemes",
                 "With existing schemes",
                 "Post reforms")
    ) +
    theme(
      plot.background = element_rect(fill = "white"),
      panel.border = element_blank(),
      panel.background = element_rect(fill = "white"),
      legend.background = element_rect(fill = "white"),
      legend.text = element_text(size = 10),
      legend.title = element_blank(),
      axis.title.y = element_text(size = 12),
      axis.title.x = element_text(size = 12),
      axis.text.y = element_text(size = 10),
      axis.text.x = element_text(size = 10),
      plot.margin = unit(c(1, 1, 2, 1), "cm"),
      axis.line.x = element_line(colour = "black"),
      axis.line.y = element_line(colour = "black")
    )
  return(plot)
})

datagap_pdf_b <- reactive({
  data <- impact_data()
  
  current1 <-
    weighted.mean(data$gap, data$weight * data$hhsize)
  before1 <-
    weighted.mean(data[[paste0("pre_gap_", pdf_b)]], data$weight * data$hhsize)
  after1 <-
    weighted.mean(data[[paste0("post_gap_", pdf_b)]], data$weight * data$hhsize)
  reduction1 <- (current1 - after1) * 100 / current1
  
  current2 <-
    weighted.mean(data$gapI1, data$weight * data$hhsize)
  before2 <-
    weighted.mean(data[[paste0("pre_gapI1_", pdf_b)]], data$weight * data$hhsize)
  after2 <-
    weighted.mean(data[[paste0("post_gapI1_", pdf_b)]], data$weight * data$hhsize)
  reduction2 <- (current2 - after2) * 100 / current2
  
  current3 <-
    weighted.mean(data$gapI2, data$weight * data$hhsize)
  before3 <-
    weighted.mean(data[[paste0("pre_gapI2_", pdf_b)]], data$weight * data$hhsize)
  after3 <-
    weighted.mean(data[[paste0("post_gapI2_", pdf_b)]], data$weight * data$hhsize)
  reduction3 <- (current3 - after3) * 100 / current3
  
  current4 <-
    weighted.mean(data$gapI3, data$weight * data$hhsize)
  before4 <-
    weighted.mean(data[[paste0("pre_gapI3_", pdf_b)]], data$weight * data$hhsize)
  after4 <-
    weighted.mean(data[[paste0("post_gapI3_", pdf_b)]], data$weight * data$hhsize)
  reduction4 <- (current4 - after4) * 100 / current4
  
  current <- c(current1, current2, current3, current4)
  before <- c(before1, before2, before3, before4)
  after <- c(after1, after2, after3, after4)
  reduction <-
    c(reduction1, reduction2, reduction3, reduction4)
  
  data <- data.frame(
    Line = c(
      "National",
      "International (PPP $1.9)",
      "International (PPP $3.2)",
      "International (PPP $5.5)"
    ),
    Baseline = round(before, 2),
    Current = round(current, 2),
    After = round(after, 2)
  )
  return(data)
  
})
plot_graphgap_pdf_b <- reactive({
  data <- data.frame(
    pov = c(datagap_pdf_b()$Baseline, datagap_pdf_b()$Current, datagap_pdf_b()$After),
    cat = rep(c("With no schemes",
                "With existing schemes",
                "Post reforms"), each = 4),
    Line = rep(c(
      "National",
      "International (PPP $1.9)",
      "International (PPP $3.2)",
      "International (PPP $5.5)"
    ), times = 3)
  )
  data$cat <-
    factor(data$cat, levels = c("With no schemes",
                                "With existing schemes",
                                "Post reforms"))
  
  plot <- ggplot(data,
                 aes(
                   x = cat,
                   y = pov,
                   fill=Line,
                   text = paste(
                     cat,
                     "<br>", 
                     "Poverty line:",
                     Line,
                     "<br>",
                     "Poverty gap:",
                     pov
                   )
                 )
  ) +
    geom_bar(
      stat = "identity",
      position = "dodge",
      size = .2,
      alpha = 1
    ) +
    labs(y = "Poverty gap (%)") +
    scale_fill_manual(values=c("#c0d5fa","#8EA9DB","#2c4c8b","#203764"))+
    scale_x_discrete(
      name = "",
      limits = c("With no schemes",
                 "With existing schemes",
                 "Post reforms")
    ) +
    theme(
      plot.background = element_rect(fill = "white"),
      panel.border = element_blank(),
      panel.background = element_rect(fill = "white"),
      legend.background = element_rect(fill = "white"),
      legend.text = element_text(size = 10),
      legend.title = element_blank(),
      axis.title.y = element_text(size = 12),
      axis.title.x = element_text(size = 12),
      axis.text.y = element_text(size = 10),
      axis.text.x = element_text(size = 10),
      plot.margin = unit(c(1, 1, 2, 1), "cm"),
      axis.line.x = element_line(colour = "black"),
      axis.line.y = element_line(colour = "black")
    )
})

# Costs
plot_cost_pdf_b <- reactive({
  plot <-
    plotCost(
      d = costs_data_b(),
      c = plot_cost_prog_b()[[pdf_b]]
    )
  plot <- plot + 
    theme(
      legend.text = element_text(size = 10),
      axis.title.y = element_text(size = 12),
      axis.title.x = element_text(size = 12),
      axis.text.y = element_text(size = 10),
      axis.text.x = element_text(size = 10)
    )
  return(plot)
})

# Affordability

data_textfin1_pdf_b <- reactive({
  data <- fin_data_b()
  text <- paste0(
    "The proposed reforms ",
    tabfullname_b[[pdf_b]],
    " would require an initial budget of approximately ",
    econ_b()$cur,
    " ",
    format(data[[paste0("costs", pdf_b)]][1], nsmall = 0 , big.mark = ","),
    " or ",
    format(data[[paste0("costs", pdf_b, "_gdp")]][1], nsmall = 1 , big.mark = ","),
    " per cent of GDP. This is equivalent to ",
    format(data[[paste0("cost_rev_", pdf_b)]][1], nsmall = 1 , big.mark = ","),
    " per cent of ",
    input$country_b,
    "'s total government revenue. However, keeping the ratio government revenue to GDP constant, in 2026, the proposed reforms would be ",
    format(data[[paste0("cost_rev_", pdf_b)]][6], nsmall = 1 , big.mark = ","),
    " per cent of government revenue and ",
    format(data[[paste0("cost_rev_", pdf_b)]][10], nsmall = 1 , big.mark = ","),
    " per cent in 2031."
  )
  return(text)
})
plot_graphfin1_pdf_b <- reactive({
  data1 <- fin_data_b()
  if (data1[[paste0("costs", pdf_b)]][1] > 0) {
    data <- data.frame(Year = rep(c(2022:2031), times = 1),
                       Values = data1[[paste0("cost_rev_", pdf_b)]])
  } else{
    data <- data.frame(Year = rep(c(2022:2031), times = 1),
                       Values = rep(c(0), each = 10))
  }
  plot <-
    ggplot(data, aes(x = Year,  y= Values)) +
    geom_line(colour = "#8EA9DB")  +
    geom_point(colour = "#8EA9DB",aes(text = paste(
      "Year:",
      Year,
      "<br>",
      format(Values, nsmall = 0 , big.mark = ","),
      "%"
    ))) +
    scale_x_continuous(name = "Year", breaks = c(2022:2031), labels = c(2022:2031)) +
    ylab(paste("Percentage of government revenue")) +
    theme(
      plot.background = element_rect(fill = "white"),
      panel.border = element_blank(),
      panel.background = element_rect(fill = "white"),
      legend.position = 'none',
      axis.title.y = element_text(size = 12),
      axis.title.x = element_text(size = 12),
      axis.text.y = element_text(size = 10),
      axis.text.x = element_text(size = 10, angle = 90),
      plot.margin = unit(c(1, 1, 3, 1), "cm"),
      axis.line.x = element_line(colour = "black"),
      axis.line.y = element_line(colour = "black")
    )
  return(plot)
  })
plot_graphfin2_pdf_b <- reactive({
  data <- costs_data_b()
  data <- data[data$year == 2022,]
  
  costs_gdp <- data[[paste0("costs", pdf_b, "_gdp")]]
  
  line <- c(costs_gdp)
  
  gdp <- econ_b()$gdp
  gdp <- gdp[1]
  expenses <- govfin_b()
  expenses_gdp <- round(expenses * 100 / gdp, 2)
  
  label_names <-
    c(
      "programmes combined",
      "Maternity Benefit",
      "Child Benefit",
      "Disability Benefit",
      "Old Age Benefit",
      "Household Benefit"
    )
  names(label_names) <-
    c("A", "matA", "childA", "disabA", "oldA", "B")
  
  text <-
    paste0("Costs of ", label_names[[pdf_b]], " (", costs_gdp, "%)")
  
  data <- data.frame(
    Categories = c(
      "General public services",
      "Defence",
      "Public order & safety",
      "Economic Affairs",
      "Environment",
      "Housing",
      "Health",
      "Culture",
      "Education",
      "Social Protection"
    ),
    Expenses = c(
      expenses_gdp$gen,
      expenses_gdp$def,
      expenses_gdp$safety,
      expenses_gdp$econ,
      expenses_gdp$envir,
      expenses_gdp$house,
      expenses_gdp$health,
      expenses_gdp$culture,
      expenses_gdp$educ,
      expenses_gdp$socprot
    )
  )
  
  data$Categories <-
    factor(
      data$Categories,
      levels = c(
        "General public services",
        "Defence",
        "Public order & safety",
        "Economic Affairs",
        "Environment",
        "Housing",
        "Health",
        "Culture",
        "Education",
        "Social Protection"
      )
    )
  
  plot <-
    ggplot(data, aes(
      text = paste(
        "Functional expense:",
        Categories,
        "<br>",
        "Expenditure (% of GDP):",
        Expenses,
        "<br>",
        "Costs of programme(s) (% of GDP):",
        line
      )
    )) +
    geom_bar(
      aes(
        x = Categories,
        y = Expenses,
        fill = Categories
      ),
      stat = "identity",
      size = .2,
      alpha = .4
    ) +
    geom_hline(yintercept = line,
               linetype = "dashed",
               color = "red") +
    geom_text(
      aes(4, line, label = text),
      nudge_y = 0.1,
      color = "black",
      size = 4
    ) +
    ylab("Functional expenses \n as % of GDP") +
    theme(
      plot.background = element_rect(fill = "white"),
      panel.border = element_blank(),
      panel.background = element_rect(fill = "white"),
      legend.position = "none",
      axis.title.y = element_text(size = 12),
      axis.title.x = element_blank(),
      axis.text.y = element_text(size = 10),
      axis.text.x = element_text(size = 10, angle = 90),
      plot.margin = unit(c(1, 1, 3, 1), "cm"),
      axis.line.x = element_line(colour = "black"),
      axis.line.y = element_line(colour = "black")
    )
  return(plot)
})
data_textfin3_pdf_b <- reactive({
  data <- fin_data_b()
  value <- round(data[[paste0("cost_rev_", pdf_b)]] * 100 / govfin_b()$tax_burden, 1)
  text <- paste0(
    "An orthodox approach would be to raise government tax revenue by increasing income and corporate taxes. In ",
    param_b$country,
    " the highest income tax bracket is ",
    govfin_b()$income_t,
    " per cent, and corporate tax is ",
    govfin_b()$corporate_t,
    " per cent.",
    " The total cost of the programme(s) as % of tax revenue from income, profits and capital gains is ",
    value[1],
    " per cent. This illustrates how much more tax revenue government would be required to raise to fully fund the initial levels of investiments."
  )
  return(text)
})
