## Coverage - impacts module

covImpactUI_c <- function(id) {
  ns <- NS(id)
  
  tagList(
    br(),
    p("This tab shows the simulated programme coverage - both by consumption expenditure deciles and by five-year age groups."),
    h3("Simulated coverage of programme(s)"),
    br(),
    h5("Simulated coverage of direct and indirect recipients among national population, by consumption expenditure deciles and Scenarios"),
    plotlyOutput(ns("graphcov_exp")) %>% withSpinner(color = "#003972"),
    br(),
    h5("Simulated coverage of direct and indirect recipients among national population, by household structure and Scenarios"),
    plotlyOutput(ns("graphcov_hhtype")) %>% withSpinner(color = "#003972"),
    br()
  )
  
}

covImpact_c <- function(input, output, session, toptab_c = "A",
                                              caption_text_c,
                                              deciledata_c,
                                              hhtypedata_c) {
  

  # Coverage


  #by deciles
  output$graphcov_exp <- renderPlotly({

    data <- deciledata_c()
    data <- data[!is.na(data$rural) & data$rural==2,]

    data <- data.frame(
      Deciles = rep(c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest"), times = 2),
      Coverage = round(c(data[[paste0("meancov_", toptab_c)]]), 1),
      Scenario = c(data[[paste0("Scenario")]])
    )

    data$Deciles <-
      factor(
        data$Deciles,
        levels = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest")
      )

    data$Scenario <-
      factor(data$Scenario, levels = c("Scenario A", "Scenario B"))

    plot <-
      ggplot(
        data,
        aes(
          x = Deciles,
          y = Coverage,
          group = Scenario,
          fill = Scenario,
          text = paste(
            Scenario,
            "<br>",
            "Deciles:",
            Deciles,
            "<br>",
            "Coverage (%):",
            Coverage
          )
        )
      ) +
      geom_bar(
        stat = "identity",
        size = .2,
        alpha = 1,
        position = position_dodge2(width = 0.1, preserve = "single")
      ) +
      labs(y = "Coverage (%)") +
      scale_fill_manual(values = c("#203764", "#8EA9DB") ) +
      scale_x_discrete(
        name = "Deciles",
        limits = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest")
      ) +
      ylim(0, 100) +
      theme(
        plot.background = element_rect(fill = "white"),
        panel.border = element_blank(),
        panel.background = element_rect(fill = "white"),
        legend.background = element_rect(fill = "white"),
        legend.text = element_text(size = 12),
        legend.title = element_text(size = 1),
        axis.title.y = element_text(size = 14),
        axis.title.x = element_text(size = 14),
        axis.text.y = element_text(size = 14),
        plot.margin = unit(c(1, 1, 2, 1), "cm"),
        axis.line.x = element_line(colour = "black"),
        axis.line.y = element_line(colour = "black")
      )

    ggplotly(plot, tooltip = c("text")) %>%
      layout(
        annotations =
          list(
            x = 1,
            y = -0.45,
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



  #by age groups


  output$graphcov_hhtype <- renderPlotly({
    
    data <- hhtypedata_c()
    data <- data[data$rural==2 & data$female_head==2,]
    
    data <- data.frame(
      Type = rep(c("Couple household, with children",
               "Couple household, with no children",
               "One-person household, 18-59 years",
               "One-person household, 60+ years",
               "Other household types",
               "Single parent/caregiver (<60 years)",
               "Skipped generation",
               "Three generation household"), times = 2),
      Coverage = round(c(data[[paste0("meancov_", toptab_c)]]), 1),
      Scenario = c(data[[paste0("Scenario")]])
    )
    
    data$Type <-
      factor(
        data$Type,
        levels = c("Couple household, with children", "Couple household, with no children", "Single parent/caregiver (<60 years)", "One-person household, 60+ years", "One-person household, 18-59 years", "Three generation household", "Skipped generation", "Other household types", "Total"),
      )
    
    data$Scenario <-
      factor(data$Scenario, levels = c("Scenario A", "Scenario B"))
    
    plot <-
      ggplot(data, aes(
        x = Type,
        y = Coverage,
        group = Scenario,
        fill = Scenario,
        text = paste(Scenario, "<br>","Household type:", Type, "<br>", "Coverage:", Coverage)
      )) +
      geom_bar(
        stat = "identity",
        size = .2,
        alpha = 1,
        position = position_dodge2(width = 0.1, preserve = "single")
      ) +
      labs(y = "Coverage (%)") +
      scale_fill_manual(values = c("#203764", "#8EA9DB") ) +
      scale_x_discrete(
        name = "Household Type",
        labels = function(x) str_wrap(c("Couple household, with children", "Couple household, with no children", "Single parent/caregiver (<60 years)", "One-person household, 60+ years", "One-person household, 18-59 years", "Three generation household", "Skipped generation", "Other household types"), width = 5)
      ) +
      ylim(0, 100) +
      theme(
        plot.background = element_rect(fill = "white"),
        panel.border = element_blank(),
        panel.background = element_rect(fill = "white"),
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
        annotations =
          list(
            x = 1,
            y = -0.75,
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