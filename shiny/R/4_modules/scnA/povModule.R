## PovIneq - impacts module

povImpactUI<- function(id) {
  ns <- NS(id)
  
  tagList(
    br(),
    p("This tab shows indicators of poverty and inequality in three scenarios: with no schemes, with existing schemes and post reforms."),
    tags$li("Indicators in the ", tags$b("no schemes")," scenario reflect the level of poverty and inequality in the absence of any social protection schemes captured in the data. If any schemes exist, then “no schemes” outcomes are estimated after taking away these benefits."),
    tags$li("When a relevant scheme is in place (or captured by the survey), indicators of poverty and inequality in the ", tags$b("existing schemes")," scenario take them into account."),
    tags$li("Indicators of poverty and inequality in the ", tags$b("post reform")," scenario are calculated after taking away any non-contributory schemes currently in place (or captured by the survey), and adding the benefits from the simulated schemes."),
    h3("Simulated impacts on poverty and inequality of programme(s)"),
    br(),
    textOutput(ns("text_pregraphpov")),
    br(),
    h4("Simulated impact on poverty rates, whole population"),
    plotlyOutput(ns("graphpov")) %>% withSpinner(color = "#003972"),
    br(),
    h4("Simulated impact on poverty rates, whole population"),
    tableOutput(ns("tabpov")) %>% withSpinner(color = "#003972"),
    br(),
    textOutput(ns("text_graphpov")),
    h4("Simulated impact on poverty rates, recipient households"),
    plotlyOutput(ns("graphpov_ben")) %>% withSpinner(color = "#003972"),
    br(),
    h4("Simulated impact on poverty rates, recipient households"),
    tableOutput(ns("tabpov_ben")) %>% withSpinner(color = "#003972"),
    br(),
    textOutput(ns("text_graphgap")),
    h4("Simulated impact on poverty gap index, whole population"),
    plotlyOutput(ns("graphgap")) %>% withSpinner(color = "#003972"),
    br(),
    h4("Simulated impact on poverty gap index, whole population"),
    tableOutput(ns("tabgap")) %>% withSpinner(color = "#003972"),
    br(),
    textOutput(ns("text_graphgap_rec")),
    h4("Simulated impact on poverty gap index, recipient households"),
    plotlyOutput(ns("graphgap_ben")) %>% withSpinner(color = "#003972"),
    br(),
    h4("Simulated impact on poverty gap index, recipient households"),
    tableOutput(ns("tabgap_ben")) %>% withSpinner(color = "#003972"),
    br(),
    textOutput(ns("text_inequ")),
    h4("Simulated impact on inequality "),
    tableOutput(ns("tabgini")) %>% withSpinner(color = "#003972"),
    br()
  )
}

povImpact<- function(input, output, session, toptab= "A",
                      impact_data, 
                      caption_text,
                      age5yrsdata) {
  
  # Poverty and inequality
  data_for_textpovineq <- reactive({
    data <- impact_data()
    before1 <-
      weighted.mean(data$pov, data$weight )
    after1 <-
      weighted.mean(data[[paste0("post_pov_", toptab)]], data$weight )
    reduction1 <- (before1 - after1) * 100 / before1
    
    before2 <-
      weighted.mean(data$gap, data$weight )
    after2 <-
      weighted.mean(data[[paste0("post_gap_", toptab)]], data$weight )
    reduction2 <- (before2 - after2) * 100 / before2
    
    check <- sum(data[[paste0("cov_", toptab)]])
    
    if (check>0) {
      data$after <-
        data$adj_welfare - data[[paste0("value_", toptab)]] + data[[paste0("transfer_", toptab)]]
    } else {
      data$after <-
        data$adj_welfare
    }
    
    before3 <-
      gini(data$adj_welfare, data$weight )
    after3 <- gini(data$after, data$weight )
    reduction3 <- (before3 - after3) * 100 / before3
    
    is.na(data[[paste0("transfer_", toptab)]]) <-
      data[[paste0("transfer_", toptab)]] == 0
    data <- data[!is.na(data[[paste0("transfer_", toptab)]]),]
    
    before4 <-
      weighted.mean(data$pov, data$weight )
    after4 <-
      weighted.mean(data[[paste0("post_pov_", toptab)]], data$weight )
    reduction4 <- (before4 - after4) * 100 / before4
    
    before5 <-
      weighted.mean(data$gap, data$weight )
    after5 <-
      weighted.mean(data[[paste0("post_gap_", toptab)]], data$weight )
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
  
  output$text_pregraphpov <- renderText({
    data <- data_for_textpovineq()
    text <-
      paste0(
        "The ﬁgure below shows the simulated impact on poverty rates for the whole population, indicating the share of the total population living below national and international poverty lines."
        # "The simulated overall poverty reduction is ",
        # data$povall[3],
        # " per cent reduction. Among recipient households, the poverty rate will decrease ",
        # data$povben[3],
        # " per cent. The simulations also suggest a ",
        # data$gapall[3],
        # " per cent reduction in the national poverty gap, and ",
        # data$gapben[3],
        # " per cent among recipient households. National inequality is expected to decrease by ",
        # data$gini[3],
        # " per cent when measured by the Gini index. Overall, the poverty rate changes from ",
        # data$povall[1],
        # " per cent to ",
        # data$povall[2],
        # " per cent. Among recipient households, the poverty rate goes from ",
        # data$povben[1],
        # " per cent to ",
        # data$povben[2],
        # " per cent."
      )
    return(text)
  })

  output$text_graphpov <- renderText({
    text <-
      paste(
        "The ﬁgure below shows the simulated impact on poverty rates among recipient households, 
        indicating the share of recipient households living below national and international poverty lines."
      )
    return(text)
  })

  output$text_graphgap <- renderText({
    text <-
      paste0(
        "The ﬁgure below shows the simulated impact on poverty gap index for the whole population, indicating the average percentage shortfall in income from the poverty line."
      )
    return(text)
  })

  output$text_graphgap_rec <- renderText({
    text <-
      paste0(
        "The ﬁgure below shows the simulated impact on poverty gap index for among recipient households, indicating the average percentage shortfall in income from the poverty line."
      )
    return(text)
  })

  output$text_inequ <- renderText({
    #data <- data_for_textpovineq()
    text <-
      paste0(
        "The table below shows the simulated impact on inequality, as measured by the Gini coefficient, the Palma ratio, and the Quintile ratio under three scenarios: with no schemes in place, with existing schemes, and with the proposed schemes."
      )
    return(text)
  })
  
  datapov <- reactive({
    data <- impact_data()
    
    current1 <-
      weighted.mean(data$pov, data$weight )
    before1 <-
      weighted.mean(data[[paste0("pre_pov_", toptab)]], data$weight )
    after1 <-
      weighted.mean(data[[paste0("post_pov_", toptab)]], data$weight )
    reduction1 <- (current1 - after1) * 100 / current1
    
    current2 <-
      weighted.mean(data$povI1, data$weight )
    before2 <-
      weighted.mean(data[[paste0("pre_povI1_", toptab)]], data$weight )
    after2 <-
      weighted.mean(data[[paste0("post_povI1_", toptab)]], data$weight )
    reduction2 <- (current2 - after2) * 100 / current2
    
    current3 <-
      weighted.mean(data$povI2, data$weight )
    before3 <-
      weighted.mean(data[[paste0("pre_povI2_", toptab)]], data$weight )
    after3 <-
      weighted.mean(data[[paste0("post_povI2_", toptab)]], data$weight )
    reduction3 <- (current3 - after3) * 100 / current3
    
    current4 <-
      weighted.mean(data$povI3, data$weight )
    before4 <-
      weighted.mean(data[[paste0("pre_povI3_", toptab)]], data$weight )
    after4 <-
      weighted.mean(data[[paste0("post_povI3_", toptab)]], data$weight )
    reduction4 <- (current4 - after4) * 100 / current4
    
    current <- c(current1, current2, current3, current4)
    before <- c(before1, before2, before3, before4)
    after <- c(after1, after2, after3, after4)
    reduction <-
      c(reduction1, reduction2, reduction3, reduction4)

    check1 <- sum(impact_data()[[paste0("value_", toptab)]])
    if (check1 > 0) {
      datatable <- data.frame(
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
      datagraph <- data.frame(
        pov = c(datatable$Baseline, datatable$Current, datatable$After),
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
      levels <- c("With no schemes",
                  "With existing schemes",
                  "Post reforms")
      align <- paste0('lrrr')
    } else {
      datatable <- data.frame(
        Line = c(
          "National",
          "International (PPP $1.9)",
          "International (PPP $3.2)",
          "International (PPP $5.5)"
        ),
        Current = round(current, 2),
        After = round(after,2)
      )
      datagraph <- data.frame(
        pov = c(datatable$Current, datatable$After),
        cat = rep(c("With no schemes",
                    "Post reforms"), each = 4),
        Line = rep(c(
          "National",
          "International (PPP $1.9)",
          "International (PPP $3.2)",
          "International (PPP $5.5)"
        ), times = 2)
      )
      levels <- c("With no schemes",
                  "Post reforms")
      align <- paste0('lrr')
    }
    
    datagraph$Line <-
      factor(datagraph$Line, levels = c(
        "National",
        "International (PPP $1.9)",
        "International (PPP $3.2)",
        "International (PPP $5.5)")) 
    
    datagraph$cat <-
      factor(datagraph$cat, levels = levels)
    
    list <- list(datagraph = datagraph, 
                 levels = levels, 
                 datatable = datatable,
                 align = align)
    return(list)
  })
  output$graphpov <- renderPlotly({
    plot <- ggplot(datapov()$datagraph,
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
        limits = datapov()$levels
      ) +
      theme(
        plot.background = element_rect(fill = "white"),
        panel.border = element_blank(),
        panel.background = element_rect(fill = "white"),
        legend.background = element_rect(fill = "white"),
        legend.text = element_text(size = 12),
        legend.title = element_blank(),
        axis.title.y = element_text(size = 14),
        axis.title.x = element_text(size = 14),
        axis.text.y = element_text(size = 14),
        axis.text.x = element_text(size = 10),
        plot.margin = unit(c(1, 1, 2, 1), "cm"),
        axis.line.x = element_line(colour = "black"),
        axis.line.y = element_line(colour = "black")
      )
    ggplotly(plot, tooltip = "text") %>%
      layout(
        annotations = list(
          x =1.25,
          y = -0.25,
          text = caption_text(),
          showarrow = F,
          xref = 'paper',
          yref = 'paper',
          xanchor = 'right',
          yanchor = 'auto',
          xshift = 0,
          yshift = 0,
          font = list(size = 10, color = "black")
        )
      ) %>% config(displayModeBar = T, displaylogo = FALSE, modeBarButtons = list(list("toImage"))) %>% layout(xaxis=list(fixedrange=TRUE)) %>% layout(showlegend = TRUE) %>% layout(yaxis=list(fixedrange=TRUE))
  })
  output$tabpov <- renderTable({
    data  <- datapov()$datatable
    
    colnames(data) <-
      c("Poverty Line",
        datapov()$levels)
    return(data)
  }, align = datapov()$align, hover = T, rownames = FALSE)
  
  datapov_ben <- reactive({
    data <- impact_data()
    is.na(data[[paste0("transfer_", toptab)]]) <-
      data[[paste0("transfer_", toptab)]] == 0
    data <- data[!is.na(data[[paste0("transfer_", toptab)]]),]
    
    current1 <-
      weighted.mean(data$pov, data$weight )
    before1 <-
      weighted.mean(data[[paste0("pre_pov_", toptab)]], data$weight )
    after1 <-
      weighted.mean(data[[paste0("post_pov_", toptab)]], data$weight )
    reduction1 <- (current1 - after1) * 100 / current1
    
    current2 <-
      weighted.mean(data$povI1, data$weight )
    before2 <-
      weighted.mean(data[[paste0("pre_povI1_", toptab)]], data$weight )
    after2 <-
      weighted.mean(data[[paste0("post_povI1_", toptab)]], data$weight )
    reduction2 <- (current2 - after2) * 100 / current2
    
    current3 <-
      weighted.mean(data$povI2, data$weight )
    before3 <-
      weighted.mean(data[[paste0("pre_povI2_", toptab)]], data$weight )
    after3 <-
      weighted.mean(data[[paste0("post_povI2_", toptab)]], data$weight )
    reduction3 <- (current3 - after3) * 100 / current3
    
    current4 <-
      weighted.mean(data$povI3, data$weight )
    before4 <-
      weighted.mean(data[[paste0("pre_povI3_", toptab)]], data$weight )
    after4 <-
      weighted.mean(data[[paste0("post_povI3_", toptab)]], data$weight )
    reduction4 <- (current4 - after4) * 100 / current4
    
    current <- c(current1, current2, current3, current4)
    before <- c(before1, before2, before3, before4)
    after <- c(after1, after2, after3, after4)
    reduction <-
      c(reduction1, reduction2, reduction3, reduction4)
    
    check1 <- sum(impact_data()[[paste0("value_", toptab)]])
    if (check1 > 0) {
      datatable <- data.frame(
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
      datagraph <- data.frame(
        pov = c(datatable$Baseline, datatable$Current, datatable$After),
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
      levels <- c("With no schemes",
                  "With existing schemes",
                  "Post reforms")
      align <- paste0('lrrr')
    } else {
      datatable <- data.frame(
        Line = c(
          "National",
          "International (PPP $1.9)",
          "International (PPP $3.2)",
          "International (PPP $5.5)"
        ),
        Current = round(current, 2),
        After = round(after,2)
      )
      datagraph <- data.frame(
        pov = c(datatable$Current, datatable$After),
        cat = rep(c("With no schemes",
                    "Post reforms"), each = 4),
        Line = rep(c(
          "National",
          "International (PPP $1.9)",
          "International (PPP $3.2)",
          "International (PPP $5.5)"
        ), times = 2)
      )
      levels <- c("With no schemes",
                  "Post reforms")
      align <- paste0('lrr')
    }
    
    datagraph$Line <-
      factor(datagraph$Line, levels = c(
        "National",
        "International (PPP $1.9)",
        "International (PPP $3.2)",
        "International (PPP $5.5)")) 
    
    datagraph$cat <-
      factor(datagraph$cat, levels = levels)
    
    list <- list(datagraph = datagraph, 
                 levels = levels, 
                 datatable = datatable,
                 align = align)
    return(list)
  })
  output$graphpov_ben <- renderPlotly({
          plot <- ggplot(datapov_ben()$datagraph,
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
        limits = datapov_ben()$levels
      ) +
      theme(
        plot.background = element_rect(fill = "white"),
        panel.border = element_blank(),
        panel.background = element_rect(fill = "white"),
        legend.background = element_rect(fill = "white"),
        legend.text = element_text(size = 12),
        legend.title = element_blank(),
        axis.title.y = element_text(size = 14),
        axis.title.x = element_text(size = 14),
        axis.text.y = element_text(size = 14),
        axis.text.x = element_text(size = 10),
        plot.margin = unit(c(1, 1, 2, 1), "cm"),
        axis.line.x = element_line(colour = "black"),
        axis.line.y = element_line(colour = "black")
      )
    ggplotly(plot, tooltip = "text") %>%
      layout(
        annotations = list(
          x =1.25,
          y = -0.25,
          text = caption_text(),
          showarrow = F,
          xref = 'paper',
          yref = 'paper',
          xanchor = 'right',
          yanchor = 'auto',
          xshift = 0,
          yshift = 0,
          font = list(size = 10, color = "black")
        )
      ) %>% config(displayModeBar = T, displaylogo = FALSE, modeBarButtons = list(list("toImage"))) %>% layout(xaxis=list(fixedrange=TRUE)) %>% layout(showlegend = TRUE) %>% layout(yaxis=list(fixedrange=TRUE))
  })
  output$tabpov_ben <- renderTable({
    data  <- datapov_ben()$datatable
    
    colnames(data) <-
      c("Poverty Line",
        datapov_ben()$levels)
    return(data)  }, align = datapov_ben()$align, hover = T, rownames = FALSE)
  
  datagap <- reactive({
    data <- impact_data()
    
    current1 <-
      weighted.mean(data$gap, data$weight )
    before1 <-
      weighted.mean(data[[paste0("pre_gap_", toptab)]], data$weight )
    after1 <-
      weighted.mean(data[[paste0("post_gap_", toptab)]], data$weight )
    reduction1 <- (current1 - after1) * 100 / current1
    
    current2 <-
      weighted.mean(data$gapI1, data$weight )
    before2 <-
      weighted.mean(data[[paste0("pre_gapI1_", toptab)]], data$weight )
    after2 <-
      weighted.mean(data[[paste0("post_gapI1_", toptab)]], data$weight )
    reduction2 <- (current2 - after2) * 100 / current2
    
    current3 <-
      weighted.mean(data$gapI2, data$weight )
    before3 <-
      weighted.mean(data[[paste0("pre_gapI2_", toptab)]], data$weight )
    after3 <-
      weighted.mean(data[[paste0("post_gapI2_", toptab)]], data$weight )
    reduction3 <- (current3 - after3) * 100 / current3
    
    current4 <-
      weighted.mean(data$gapI3, data$weight )
    before4 <-
      weighted.mean(data[[paste0("pre_gapI3_", toptab)]], data$weight )
    after4 <-
      weighted.mean(data[[paste0("post_gapI3_", toptab)]], data$weight )
    reduction4 <- (current4 - after4) * 100 / current4
    
    current <- c(current1, current2, current3, current4)
    before <- c(before1, before2, before3, before4)
    after <- c(after1, after2, after3, after4)
    reduction <-
      c(reduction1, reduction2, reduction3, reduction4)
    
    check1 <- sum(impact_data()[[paste0("value_", toptab)]])
    if (check1 > 0) {
      datatable <- data.frame(
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
      datagraph <- data.frame(
        pov = c(datatable$Baseline, datatable$Current, datatable$After),
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
      levels <- c("With no schemes",
                  "With existing schemes",
                  "Post reforms")
      align <- paste0('lrrr')
    } else {
      datatable <- data.frame(
        Line = c(
          "National",
          "International (PPP $1.9)",
          "International (PPP $3.2)",
          "International (PPP $5.5)"
        ),
        Current = round(current, 2),
        After = round(after,2)
      )
      datagraph <- data.frame(
        pov = c(datatable$Current, datatable$After),
        cat = rep(c("With no schemes",
                    "Post reforms"), each = 4),
        Line = rep(c(
          "National",
          "International (PPP $1.9)",
          "International (PPP $3.2)",
          "International (PPP $5.5)"
        ), times = 2)
      )
      levels <- c("With no schemes",
                  "Post reforms")
      align <- paste0('lrr')
    }
    
    datagraph$Line <-
      factor(datagraph$Line, levels = c(
        "National",
        "International (PPP $1.9)",
        "International (PPP $3.2)",
        "International (PPP $5.5)")) 
    
    datagraph$cat <-
      factor(datagraph$cat, levels = levels)
    
    list <- list(datagraph = datagraph, 
                 levels = levels, 
                 datatable = datatable,
                 align = align)
    return(list)
    
  })
  output$graphgap <- renderPlotly({
     plot <- ggplot(datagap()$datagraph,
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
        limits = datagap()$levels
      ) +
      theme(
        plot.background = element_rect(fill = "white"),
        panel.border = element_blank(),
        panel.background = element_rect(fill = "white"),
        legend.background = element_rect(fill = "white"),
        legend.text = element_text(size = 12),
        legend.title = element_blank(),
        axis.title.y = element_text(size = 14),
        axis.title.x = element_text(size = 14),
        axis.text.y = element_text(size = 14),
        axis.text.x = element_text(size = 10),
        plot.margin = unit(c(1, 1, 2, 1), "cm"),
        axis.line.x = element_line(colour = "black"),
        axis.line.y = element_line(colour = "black")
      )
    ggplotly(plot, tooltip = "text") %>%
      layout(
        annotations = list(
          x =1.25,
          y = -0.25,
          text = caption_text(),
          showarrow = F,
          xref = 'paper',
          yref = 'paper',
          xanchor = 'right',
          yanchor = 'auto',
          xshift = 0,
          yshift = 0,
          font = list(size = 10, color = "black")
        )
      ) %>% config(displayModeBar = T, displaylogo = FALSE, modeBarButtons = list(list("toImage"))) %>% layout(xaxis=list(fixedrange=TRUE)) %>% layout(showlegend = TRUE) %>% layout(yaxis=list(fixedrange=TRUE))
  })
  output$tabgap <- renderTable({
    data <- datagap()$datatable
    colnames(data) <-
      c("Poverty Line",
        datagap()$levels)
    
    return(data)
    
  }, align = datagap()$align, hover = T, rownames = FALSE)
  
  datagap_ben <- reactive({
    data <- impact_data()
    is.na(data[[paste0("transfer_", toptab)]]) <-
      data[[paste0("transfer_", toptab)]] == 0
    data <- data[!is.na(data[[paste0("transfer_", toptab)]]),]
    
    
    current1 <-
      weighted.mean(data$gap, data$weight )
    before1 <-
      weighted.mean(data[[paste0("pre_gap_", toptab)]], data$weight )
    after1 <-
      weighted.mean(data[[paste0("post_gap_", toptab)]], data$weight )
    reduction1 <- (current1 - after1) * 100 / current1
    
    current2 <-
      weighted.mean(data$gapI1, data$weight )
    before2 <-
      weighted.mean(data[[paste0("pre_gapI1_", toptab)]], data$weight )
    after2 <-
      weighted.mean(data[[paste0("post_gapI1_", toptab)]], data$weight )
    reduction2 <- (current2 - after2) * 100 / current2
    
    current3 <-
      weighted.mean(data$gapI2, data$weight )
    before3 <-
      weighted.mean(data[[paste0("pre_gapI2_", toptab)]], data$weight )
    after3 <-
      weighted.mean(data[[paste0("post_gapI2_", toptab)]], data$weight )
    reduction3 <- (current3 - after3) * 100 / current3
    
    current4 <-
      weighted.mean(data$gapI3, data$weight )
    before4 <-
      weighted.mean(data[[paste0("pre_gapI3_", toptab)]], data$weight )
    after4 <-
      weighted.mean(data[[paste0("post_gapI3_", toptab)]], data$weight )
    reduction4 <- (current4 - after4) * 100 / current4
    
    current <- c(current1, current2, current3, current4)
    before <- c(before1, before2, before3, before4)
    after <- c(after1, after2, after3, after4)
    reduction <-
      c(reduction1, reduction2, reduction3, reduction4)
    
    check1 <- sum(impact_data()[[paste0("value_", toptab)]])
    if (check1 > 0) {
      datatable <- data.frame(
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
      datagraph <- data.frame(
        pov = c(datatable$Baseline, datatable$Current, datatable$After),
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
      levels <- c("With no schemes",
                  "With existing schemes",
                  "Post reforms")
      align <- paste0('lrrr')
    } else {
      datatable <- data.frame(
        Line = c(
          "National",
          "International (PPP $1.9)",
          "International (PPP $3.2)",
          "International (PPP $5.5)"
        ),
        Current = round(current, 2),
        After = round(after,2)
      )
      datagraph <- data.frame(
        pov = c(datatable$Current, datatable$After),
        cat = rep(c("With no schemes",
                    "Post reforms"), each = 4),
        Line = rep(c(
          "National",
          "International (PPP $1.9)",
          "International (PPP $3.2)",
          "International (PPP $5.5)"
        ), times = 2)
      )
      levels <- c("With no schemes",
                  "Post reforms")
      align <- paste0('lrr')
    }
    
    datagraph$Line <-
      factor(datagraph$Line, levels = c(
        "National",
        "International (PPP $1.9)",
        "International (PPP $3.2)",
        "International (PPP $5.5)")) 
    
    datagraph$cat <-
      factor(datagraph$cat, levels = levels)
    
    list <- list(datagraph = datagraph, 
                 levels = levels, 
                 datatable = datatable,
                 align = align)
    return(list)
    
  })
  output$graphgap_ben <- renderPlotly({
    
    plot <- ggplot(datagap_ben()$datagraph,
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
        limits = datagap_ben()$levels
      ) +
      theme(
        plot.background = element_rect(fill = "white"),
        panel.border = element_blank(),
        panel.background = element_rect(fill = "white"),
        legend.background = element_rect(fill = "white"),
        legend.text = element_text(size = 12),
        legend.title = element_blank(),
        axis.title.y = element_text(size = 14),
        axis.title.x = element_text(size = 14),
        axis.text.y = element_text(size = 14),
        axis.text.x = element_text(size = 10),
        plot.margin = unit(c(1, 1, 2, 1), "cm"),
        axis.line.x = element_line(colour = "black"),
        axis.line.y = element_line(colour = "black")
      )
    ggplotly(plot, tooltip = "text") %>%
      layout(
        annotations = list(
          x = 1.25,
          y = -0.25,
          text = caption_text(),
          showarrow = F,
          xref = 'paper',
          yref = 'paper',
          xanchor = 'right',
          yanchor = 'auto',
          xshift = 0,
          yshift = 0,
          font = list(size = 10, color = "black")
        )
      ) %>% config(displayModeBar = T, displaylogo = FALSE, modeBarButtons = list(list("toImage"))) %>% layout(xaxis=list(fixedrange=TRUE)) %>% layout(showlegend = TRUE) %>% layout(yaxis=list(fixedrange=TRUE))
  })
  output$tabgap_ben <- renderTable({
    data <- datagap_ben()$datatable
    
    colnames(data) <-
      c("Poverty Line",
        datagap_ben()$levels)
    
    return(data)
    
  }, align = datagap_ben()$align, hover = T, rownames = FALSE)
  
  output$tabgini <- renderTable({
    data <- impact_data()
    
    check <- sum(data[[paste0("cov_", toptab)]])
    
    if (check>0) {
      data$after <-
        data$adj_welfare - data[[paste0("value_", toptab)]] + data[[paste0("transfer_", toptab)]]
    } else {
      data$after <-
        data$adj_welfare
    }

    data$before <-
      data$adj_welfare - data[[paste0("value_", toptab)]]
    
    data$weight_pop <- data$weight 
    
    current1 <- gini(data$adj_welfare, data$weight_pop)
    before1 <- gini(data$before, data$weight_pop)
    after1 <- gini(data$after, data$weight_pop)
    reduction1 <- (current1 - after1) * 100 / current1
    
    #palma ratio
    current2 <- palmaratio(data$adj_welfare, data$weight_pop)
    before2 <- palmaratio(data$before, data$weight_pop)
    after2 <- palmaratio(data$after, data$weight_pop)
    reduction2 <- (current2 - after2) * 100 / current2
    
    #20:20 ratio
    current3 <-
      quintileratio(data$adj_welfare, data$weight_pop)
    before3 <- quintileratio(data$before, data$weight_pop)
    after3 <- quintileratio(data$after, data$weight_pop)
    reduction3 <- (current3 - after3) * 100 / current3
    
    current <- c(current1, current2, current3)
    before <- c(before1, before2, before3)
    after <- c(after1, after2, after3)
    reduction <- c(reduction1, reduction2, reduction3)
    
    check1 <- sum(impact_data()[[paste0("value_", toptab)]])
    if (check1 > 0) {
    data <- data.frame(
      inequal = c("Gini index", "Palma ratio", "Quintile Ratio"),
      Baseline = paste(as.character(format(
        before, digits = 3
      )), sep = ""),
      Current = paste(as.character(format(
        current, digits = 3
      )), sep = ""),
      After = paste(as.character(format(
        after, digits = 3
      )), sep = "")
    )
    } else {
      data <- data.frame(
        inequal = c("Gini index", "Palma ratio", "Quintile Ratio"),
        Current = paste(as.character(format(
          current, digits = 3
        )), sep = ""),
        After = paste(as.character(format(
          after, digits = 3
        )), sep = "")
      )
    }
    
    colnames(data) <-
      c("Inequality Metric",
        datagap_ben()$levels)
    
    return(data)
    
  }, align = datagap_ben()$align, hover = T, rownames = FALSE)
}