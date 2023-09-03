## Affordability module

finTabUI_b <- function(id) {
  ns <- NS(id)
  
  tagList(
    column(
      12,
      br(),
      div(
        "Besides highlighting potential impacts in coverage, consumption and poverty and inequality; today, any investiment in social protection has to be presented as affordable. This section provides a few of the possible financing streams that can make sensible reforms affordable. Note, however, that each country is unique, and that all and any alternative options should be carrefully examined against its context.",
        tags$br(),
        tags$br(),
        tags$h4("Investment as a percentage of government revenue"),
        textOutput(ns("fin1")),
        tags$br(),
        tags$h5("Required investment as a percentage of government revenue, by year"),
        tags$br(),
        plotlyOutput(ns("gfin1")) %>% withSpinner(color = "#003972"),
        tags$br(),
        tags$br(),
        tags$h4("A comparison of the estimated cost of the simulated programme(s) with public spending on other sectors in 2022"),
        "One option is to reallocate current government expenditure. The figure below highlights current government expenditure by functional outlays against the required investment.",
        tags$br(),
        tags$h5("Public spending on functional expenses as % of GDP, 2022"),
        plotlyOutput(ns("gfin2")) %>% withSpinner(color = "#003972"),
        tags$br(),
        tags$br(),
        tags$h4("Government tax revenue from income and corporate taxes"),
        textOutput(ns("fin3")),
        tags$br(),
        tags$br()
      )
    )
  )
}

finTab_b <- function(input, output, sesstion, toptab_b = "A", tabfullname_b, costs_data_b, fin_data_b, govfin_b, econ_b, caption_text_b, param_b) {
  

  # Affordability
  output$fin1 <- renderText({
    data <- fin_data_b()
    paste0(
      "The proposed reforms ",
      tabfullname_b[[toptab_b]],
      " would require an initial budget of approximately ",
      econ_b()$cur,
      " ",
      format(data[[paste0("costs", toptab_b)]][1], nsmall = 0 , big.mark = ","),
      " or ",
      format(data[[paste0("costs", toptab_b, "_gdp")]][1], nsmall = 1 , big.mark = ","),
      " per cent of GDP. This is equivalent to ",
      format(data[[paste0("cost_rev_", toptab_b)]][1], nsmall = 1 , big.mark = ","),
      " per cent of ",
      param_b$country,
      "'s total government revenue. However, keeping the ratio government revenue to GDP constant, in 2026, the proposed reforms would be ",
      format(data[[paste0("cost_rev_", toptab_b)]][6], nsmall = 1 , big.mark = ","),
      " per cent of government revenue and ",
      format(data[[paste0("cost_rev_", toptab_b)]][10], nsmall = 1 , big.mark = ","),
      " per cent in 2031."
    )
  })
  output$gfin1 <- renderPlotly({
    data1 <- fin_data_b()
    if (data1[[paste0("costs", toptab_b)]][1] > 0) {
      data <- data.frame(Year = rep(c(2022:2031), times = 1),
                         Values = data1[[paste0("cost_rev_", toptab_b)]])
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
      scale_x_discrete(name = "Year", limits = c(2022:2031)) +
      ylab(paste("Percentage of government revenue")) +
      theme(
        plot.background = element_rect(fill = "white"),
        panel.border = element_blank(),
        panel.background = element_rect(fill = "white"),
        legend.position = 'none',
        axis.title.y = element_text(size = 14),
        axis.title.x = element_text(size = 14),
        axis.text.y = element_text(size = 14),
        axis.text.x = element_text(size = 12, angle = 90),
        plot.margin = unit(c(1, 1, 1.85, 1), "cm"),
        axis.line.x = element_line(colour = "black"),
        axis.line.y = element_line(colour = "black")
      )
    
    ggplotly(plot, tooltip = c("text")) %>%
      layout(
        annotations = list(
          x = 1,
          y = -0.55,
          text = caption_text_b(),
          showarrow = F,
          xref = 'paper',
          yref = 'paper',
          xanchor = 'right',
          yanchor = 'auto',
          xshift = 0,
          yshift = 0,
          font = list(size = 10, color = "black")
        )
      ) %>% config(displayModeBar = F) %>% layout(xaxis=list(fixedrange=TRUE)) %>% layout(yaxis=list(fixedrange=TRUE))
  })
  output$gfin2 <- renderPlotly({
    data <- costs_data_b()
    data <- data[data$year == 2022,]
    
    costs_gdp <- data[[paste0("costs", toptab_b, "_gdp")]]
    
    line <- c(costs_gdp)
    
    gdp <- econ_b()$gdp
    gdp <- rep(gdp[1], times = 10)
    expenses <- govfin_b()
    expenses_gdp <- round(expenses * 100 / gdp, 2)
    
    label_names <-
      c(
        "programmes combined",
        "Child Benefit",
        "Disability Benefit",
        "Old Age Benefit",
        "Household Benefit"
      )
    names(label_names) <-
      c("A", "childA", "disabA", "oldA", "B")
    
    text <-
      paste0("Costs of ", label_names[[toptab_b]], " (", costs_gdp, "%)")
    
    data <- data.frame(
      Categories = c(
        "General public services",
        "Defence",
        "Public order & safety",
        "econ_bomic Affairs",
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
        expenses_gdp$econ_b,
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
          "econ_bomic Affairs",
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
      ylab("Functional expenses as % of GDP") +
      theme(
        plot.background = element_rect(fill = "white"),
        panel.border = element_blank(),
        panel.background = element_rect(fill = "white"),
        legend.position = "none",
        axis.title.y = element_text(size = 10),
        axis.title.x = element_blank(),
        axis.text.y = element_text(size = 12),
        axis.text.x = element_text(size = 10, angle = 90),
        plot.margin = unit(c(1, 1, 1.85, 1), "cm"),
        axis.line.x = element_line(colour = "black"),
        axis.line.y = element_line(colour = "black")
      )
    ggplotly(plot, tooltip = c("text")) %>% layout(
      annotations =
        list(
          x = 1,
          y = -1.75,
          text = caption_text_b(),
          showarrow = F,
          xref = 'paper',
          yref = 'paper',
          xanchor = 'right',
          yanchor = 'auto',
          xshift = 0,
          yshift = 0,
          font = list(size =
                        10, color = "black")
        )
    ) %>% config(displayModeBar = F) %>% layout(xaxis=list(fixedrange=TRUE)) %>% layout(yaxis=list(fixedrange=TRUE))
  })
  output$fin3 <- renderText({
    data <- fin_data_b()
    value <- round(data[[paste0("cost_rev_", toptab_b)]] * 100 / govfin_b()$tax_burden, 1)
    paste0(
      "An orthodox approach would be to raise government tax revenue by increasing income and corporate taxes. In ",
      param_b$country,
      " the highest personal income tax bracket is ",
      govfin_b()$income_t,
      " per cent of net income and capital gains, and corporate tax is ",
      govfin_b()$corporate_t,
      " per cent of net profits and capital gains.",
      " The total cost of the programme(s) as % of tax revenue from income, profits and capital gains is ",
      value[1],
      " per cent. This illustrates how much more tax revenue government would be required to raise to fully fund the initial levels of investiments."
    )
  })
}