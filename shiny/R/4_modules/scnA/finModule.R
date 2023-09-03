## Affordability module

finTabUI <- function(id) {
  ns <- NS(id)
  
  tagList(
    column(
      12,
      br(),
      h3("Projected annual spending as a percentage of government revenue, 2022 to 2031"),
      div(
        tags$br(),
        tags$br(),
        textOutput(ns("fin1")),
        tags$br(),
        tags$h4("Required investment as a percentage of government revenue, by year"),
        tags$br(),
        plotlyOutput(ns("gfin1")) %>% withSpinner(color = "#003972"),
        tags$br(),
        tags$br(),
        conditionalPanel(
          condition = "input.country != 'Cook Islands'",
        tags$h3("A comparison of the estimated spending of the simulated programme(s) with public spending on other sectors in 2022"),
        tags$br(),
        "One option is to reallocate current government expenditure. The figure below shows current government expenditure breakdown by functional expenses , compared to the required spending.",
        tags$br(),
        tags$h4("Public spending on functional expenses as % of GDP, 2022"),
        plotlyOutput(ns("gfin2")) %>% withSpinner(color = "#003972"),
        tags$br()
        ),
        tags$br(),
        tags$h3("Government tax revenue from income and corporate taxes"),
        textOutput(ns("fin3")),
        tags$br(),
        tags$br()
      )
    )
  )
}

finTab <- function(input, output, sesstion, toptab = "A", tabfullname, costs_data, fin_data, govfin, econ, caption_text, param) {
  # Affordability
  output$fin1 <- renderText({
    data <- fin_data()
    paste0(
      "The figure below shows the estimated annual spending of the programme(s) as a percentage of government revenue, in 2022 and up to 2031. Simulations indicate that the proposed reforms ",
      tabfullname[[toptab]],
      " would require an initial budget equivalent to ",
      format(data[[paste0("cost_rev_", toptab)]][1], nsmall = 1 , big.mark = ","),
      " per cent of ",
      param$country,
      "'s total government revenue. Keeping the government revenue to GDP ratio constant, in 2026, the proposed reforms would be ",
      format(data[[paste0("cost_rev_", toptab)]][6], nsmall = 1 , big.mark = ","),
      " per cent of government revenue and ",
      format(data[[paste0("cost_rev_", toptab)]][10], nsmall = 1 , big.mark = ","),
      " per cent in 2031."
    )
  })

  output$gfin1 <- renderPlotly({
    data1 <- fin_data()
    if (data1[[paste0("costs", toptab)]][1] > 0) {
      data <- data.frame(Year = rep(c(2022:2031), times = 1),
                         Values = data1[[paste0("cost_rev_", toptab)]])
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
      ylim(0,NA)+
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
          text = "<em>Notes</em>: ESCAP calculations based on economic and population data from IMF and UN DESA",
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
    data <- costs_data()
    data <- data[data$year == 2022,]
    
    costs_gdp <- data[[paste0("costs", toptab, "_gdp")]]
    
    line <- c(costs_gdp)
    
    gdp <- econ()$gdp
    gdp <- rep(gdp[1], times = 10)
    expenses <- govfin()
    expenses_gdp <- round(expenses, 2)
    
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
      paste0("Costs of ", label_names[[toptab]], " (", costs_gdp, "%)")
    
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
    data <- data[!is.na(data$Expenses),]
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
          text = "<em>Notes</em>: programme(s) costs are based on economic and population data from IMF and UN DESA. For a complete list of data sources please see the About page.",
          showarrow = F,
          xref = 'paper',
          yref = 'paper',
          xanchor = 'right',
          yanchor = 'auto',
          align = 'right',
          xshift = 0,
          yshift = 0,
          font = list(size =
                        10, color = "black")
        )
    ) %>% config(displayModeBar = F) %>% layout(xaxis=list(fixedrange=TRUE)) %>% layout(yaxis=list(fixedrange=TRUE))
  })
  output$fin3 <- renderText({
    data <- fin_data()
    value <- round(data[[paste0("cost_rev_", toptab)]] * 100 / govfin()$tax_burden, 1)
    paste0(
      "An alternative approach would be to raise government revenues by increasing income and corporate taxes. In ",
      param$country,
      " the highest personal income tax bracket is ",
      govfin()$income_t,
      " per cent of net income and capital gains, and corporate tax is ",
      govfin()$corporate_t,
      " per cent of net profits and capital gains.",
      " The total cost of the programme(s) as percentage of tax revenue from income, profits and capital gains is ",
      value[1],
      " per cent. This illustrates how much more tax revenue government would be required to raise to fully fund the initial levels of investments."
    )
  })
}