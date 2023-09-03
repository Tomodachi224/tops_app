## PovIneq - impacts module

povImpactUI_c <- function(id) {
  ns <- NS(id)
  
  tagList(
    br(),
    p("This tab shows the simulated impacts of the programme(s) on poverty. It compares the poverty rate and poverty gap percentage reduction in both Scenarios"),
    h3("Simulated impacts on poverty reduction of programme(s) in Scenarios A and B"),
    h5("Simulated national poverty rate reduction after the introduction of the programme(s), by poverty lines and Scenarios"),
    plotlyOutput(ns("graphpov")) %>% withSpinner(color = "#003972"),
    br(),
    h5("Simulated national poverty gap reduction after the introduction of the programme, by poverty lines and Scenarios"),
    plotlyOutput(ns("graphgap")) %>% withSpinner(color = "#003972")
  )
}

povImpact_c <- function(input, output, session, toptab_c = "A",
                      caption_text_c,
                      impact_data,
                      impact_data_b) {
  
  
  datapov_a <- reactive({
    data <- impact_data()
    
    current1 <-
      weighted.mean(data$pov, data$weight )
    after1 <-
      weighted.mean(data[[paste0("post_pov_", toptab_c)]], data$weight )
    reduction1 <- (current1 - after1) * 100 / current1
    
    current2 <-
      weighted.mean(data$povI1, data$weight )
    after2 <-
      weighted.mean(data[[paste0("post_povI1_", toptab_c)]], data$weight )
    reduction2 <- (current2 - after2) * 100 / current2
    
    current3 <-
      weighted.mean(data$povI2, data$weight )
    after3 <-
      weighted.mean(data[[paste0("post_povI2_", toptab_c)]], data$weight )
    reduction3 <- (current3 - after3) * 100 / current3
    
    current4 <-
      weighted.mean(data$povI3, data$weight )
    after4 <-
      weighted.mean(data[[paste0("post_povI3_", toptab_c)]], data$weight )
    reduction4 <- (current4 - after4) * 100 / current4
    
    current <- c(current1, current2, current3, current4)
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
      change = round(reduction, 2)
    )
    return(data)
  })
  datapov_b <- reactive({
    data <- impact_data_b()
    
    current1 <-
      weighted.mean(data$pov, data$weight )
    after1 <-
      weighted.mean(data[[paste0("post_pov_", toptab_c)]], data$weight )
    reduction1 <- (current1 - after1) * 100 / current1
    
    current2 <-
      weighted.mean(data$povI1, data$weight )
    after2 <-
      weighted.mean(data[[paste0("post_povI1_", toptab_c)]], data$weight )
    reduction2 <- (current2 - after2) * 100 / current2
    
    current3 <-
      weighted.mean(data$povI2, data$weight )
    after3 <-
      weighted.mean(data[[paste0("post_povI2_", toptab_c)]], data$weight )
    reduction3 <- (current3 - after3) * 100 / current3
    
    current4 <-
      weighted.mean(data$povI3, data$weight )
    after4 <-
      weighted.mean(data[[paste0("post_povI3_", toptab_c)]], data$weight )
    reduction4 <- (current4 - after4) * 100 / current4
    
    current <- c(current1, current2, current3, current4)
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
      change = round(reduction, 2)
    )
    return(data)
  })
  
  datapov <- reactive({
    
    data1 <- datapov_a()
    data1$Scenario <- "Scenario A"
    data2 <- datapov_b()
    data2$Scenario <- "Scenario B"
    
    data <- bind_rows(data1, data2)
    return(data)
  })
  
  output$graphpov <- renderPlotly({
    
    # data <- data.frame(
    #   pov = c(datapov()$change),
    #   Scenario = rep(c("Scenario A",
    #                    "Scenario B"), each = 4),
    #   Line = rep(c(
    #     "National",
    #     "International (PPP $1.9)",
    #     "International (PPP $3.2)",
    #     "International (PPP $5.5)"
    #   ), times = 2)
    # )
    # data$Scenario <-
    #   factor(data$Scenario, levels = c("Scenario A",
    #                               "Scenario B"))
    
    plot <- ggplot(datapov(),
                   aes(
                     x = Line,
                     y = change,
                     fill=Scenario,
                     text = paste(
                       Scenario, 
                       "<br>", 
                       "Poverty line:",
                       Line,
                       "<br>",
                       "Poverty reduction (%):",
                       change
                     )
                   )
    ) +
      geom_bar(
        stat = "identity",
        position = "dodge",
        size = .2,
        alpha = 1
      ) +
      labs(y = "Poverty rate reduction (%)") +
      scale_fill_manual(values=c("#203764", "#8EA9DB"))+
      scale_x_discrete(
        name = "Poverty lines",
        limits = c(
              "National",
              "International (PPP $1.9)",
              "International (PPP $3.2)",
              "International (PPP $5.5)"
            )
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
        plot.margin = unit(c(1, 1, 3, 1), "cm"),
        axis.line.x = element_line(colour = "black"),
        axis.line.y = element_line(colour = "black")
      )
    
    ggplotly(plot, tooltip = "text") %>%
      layout(
        annotations = list(
          x = 1,
          y = -0.55,
          text = caption_text_c(),
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
  
  
  
  datagap_a <- reactive({
    data <- impact_data()
    
    current1 <-
      weighted.mean(data$gap, data$weight )
    after1 <-
      weighted.mean(data[[paste0("post_gap_", toptab_c)]], data$weight )
    reduction1 <- (current1 - after1) * 100 / current1
    
    current2 <-
      weighted.mean(data$gapI1, data$weight )
    after2 <-
      weighted.mean(data[[paste0("post_gapI1_", toptab_c)]], data$weight )
    reduction2 <- (current2 - after2) * 100 / current2
    
    current3 <-
      weighted.mean(data$gapI2, data$weight )
    after3 <-
      weighted.mean(data[[paste0("post_gapI2_", toptab_c)]], data$weight )
    reduction3 <- (current3 - after3) * 100 / current3
    
    current4 <-
      weighted.mean(data$gapI3, data$weight )
    after4 <-
      weighted.mean(data[[paste0("post_gapI3_", toptab_c)]], data$weight )
    reduction4 <- (current4 - after4) * 100 / current4
    
    current <- c(current1, current2, current3, current4)
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
      change = round(reduction, 2)
    )
    return(data)
  })
  datagap_b <- reactive({
    data <- impact_data_b()
    
    current1 <-
      weighted.mean(data$gap, data$weight )
    after1 <-
      weighted.mean(data[[paste0("post_gap_", toptab_c)]], data$weight )
    reduction1 <- (current1 - after1) * 100 / current1
    
    current2 <-
      weighted.mean(data$gapI1, data$weight )
    after2 <-
      weighted.mean(data[[paste0("post_gapI1_", toptab_c)]], data$weight )
    reduction2 <- (current2 - after2) * 100 / current2
    
    current3 <-
      weighted.mean(data$gapI2, data$weight )
    after3 <-
      weighted.mean(data[[paste0("post_gapI2_", toptab_c)]], data$weight )
    reduction3 <- (current3 - after3) * 100 / current3
    
    current4 <-
      weighted.mean(data$gapI3, data$weight )
    after4 <-
      weighted.mean(data[[paste0("post_gapI3_", toptab_c)]], data$weight )
    reduction4 <- (current4 - after4) * 100 / current4
    
    current <- c(current1, current2, current3, current4)
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
      change = round(reduction, 2)
    )
    return(data)
  })
  
  datagap <- reactive({
    
    data1 <- datagap_a()
    data1$Scenario <- "Scenario A"
    data2 <- datagap_b()
    data2$Scenario <- "Scenario B"
    
    data <- bind_rows(data1, data2)
    return(data)
  })
  
  
  output$graphgap <- renderPlotly({
    
    data <- data.frame(
      gap = c(datagap()$change),
      Scenario = rep(c("Scenario A",
                       "Scenario B"), each = 4),
      Line = rep(c(
        "National",
        "International (PPP $1.9)",
        "International (PPP $3.2)",
        "International (PPP $5.5)"
      ), times = 2)
    )
    data$Scenario <-
      factor(data$Scenario, levels = c("Scenario A",
                                       "Scenario B"))
    
    plot <- ggplot(data,
                   aes(
                     x = Line,
                     y = gap,
                     fill=Scenario,
                     text = paste(
                       Scenario, 
                       "<br>", 
                       "Poverty line:",
                       Line,
                       "<br>",
                       "Poverty gap change (%):",
                       gap
                     )
                   )
    ) +
      geom_bar(
        stat = "identity",
        position = "dodge",
        size = .2,
        alpha = 1
      ) +
      labs(y = "Poverty gap reduction (%)") +
      scale_fill_manual(values=c("#203764", "#8EA9DB"))+
      scale_x_discrete(
        name = "Poverty Lines",
        limits = c(
          "National",
          "International (PPP $1.9)",
          "International (PPP $3.2)",
          "International (PPP $5.5)"
        )
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
        plot.margin = unit(c(1, 1, 3, 1), "cm"),
        axis.line.x = element_line(colour = "black"),
        axis.line.y = element_line(colour = "black")
      )
    
    ggplotly(plot, tooltip = c("text")) %>%
      layout(
        annotations = list(
          x = 1,
          y = -0.55,
          text = caption_text_c(),
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
}