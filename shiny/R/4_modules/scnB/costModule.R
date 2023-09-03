## Cost module

costTabUI_b <- function(id) {
  ns <- NS(id)
  
 tagList(
    column(
      12,
      br(),
      p("This tab shows how much it would cost to implement the simulated programme(s), year by year, from 2022 to 2031. The estimates do not account for the country’s current expenditure on social protection. If a country already provides non-contributory schemes similar to those simulated, the cost projections do not refer to the additional resources needed to implement the proposed scheme(s) but to the total resources, including those that are already being spent on the existing schemes. The tab also highlights a few of the possible ﬁnancing streams that can make the proposed simulated programmes aﬀordable. For more information on sustainable financing options, see ", tags$a(href="https://www.unescap.org/sites/default/d8files/knowledge-products/How_finance_inclusive_social_protection.pdf", "“How to finance inclusive social protection”", target="_blank"), ". The tool uses data on economic growth and population projections sourced from IMF and UN DESA from 2019."),      p("The estimates do not account for the country’s current expenditure on social protection. If a country already provides non-contributory schemes similar to those simulated, the cost projections do not refer to the additional resources needed to implement the proposed scheme(s) but to the total resources, including those that are already being spent on the existing schemes."),
      p("The tab also highlights a few of the possible ﬁnancing streams that can make the proposed simulated programmes aﬀordable. The tool uses data on economic growth and population projections sourced from IMF and UN DESA from 2019."),
      h3("Projected annual spending (% of GDP), by programme, 2022 to 2031"),
      br(),
      textOutput((ns("text_graphspend"))),
      h4("Projected annual spending (% of GDP), by programme, by year"),
      plotlyOutput(ns("graphvalues")) %>% withSpinner(color = "#003972"),
      br(),
      DT::dataTableOutput(ns("totalvalues")) %>% withSpinner(color = "#003972"),
      br(),
      br())
  )
}


costTab_b <- function(input, output, session, toptab_b = "A", tabfullname_b, costs_data_b, fin_data_b, plot_cost_prog_b, econ_b, param_b) {
  

  # cost
  plot_cost <- reactive({
    plot <-
      plotCost(
        d = costs_data_b(),
        c = plot_cost_prog_b()[[toptab_b]]
      )
    return(plot)
  })
  
  output$graphvalues <- renderPlotly({
    ggplotly(plot_cost()) %>%
      layout(legend = list(x = 100, y = 0.5),
             annotations =
               list(
                 x = 1,
                 y = -0.45,
                 text = "<em>Notes</em>: ESCAP calculations based on economic and population data from IMF and UN DESA",
                 showarrow = F,
                 xref = 'paper',
                 yref = 'paper',
                 xanchor =
                   'right',
                 yanchor = 'auto',
                 xshift = 0,
                 yshift = 0,
                 font =
                   list(size = 10, color = "black")
               )
      ) %>% config(displayModeBar = T, displaylogo = FALSE, modeBarButtons = list(list("toImage"))) %>% layout(xaxis=list(fixedrange=TRUE)) %>% layout(showlegend = TRUE) %>% layout(yaxis=list(fixedrange=TRUE))
  })
  output$totalvalues <- DT::renderDataTable({
    data1 <- costs_data_b()
    data <- data.frame(
      year = data1$year,
      rec = data1[[paste0("rec", toptab_b)]],
      costs = format(data1[[paste0("costs", toptab_b)]], big.mark = ","),
      costs_gdp = format(data1[[paste0("costs", toptab_b, "_gdp")]], big.mark = ",")
    )
    
    DT::datatable(
      data,
      rownames = FALSE,
      colnames = c(
        "Year",
        "<center>Recipients </center>",
        paste0(
          "<center>Spending <br> (millions of ",
          econ_b()$cur,
          ")</center>"
        ),
        "<center>Spending <br> (% of GDP)</center>"
      ),
      extensions = 'Buttons',
      options = list(
        columnDefs = list(
          list(
            className = 'dt-center',
            targets = "_all",
            width = '200px'
          )
        ),
        dom = 'tB',
        pageLength = 13,
        buttons = c("copy", list(list(extend='csv',
                                      filename = 'Costs-ScnB'),
                                 list(extend='excel',
                                      filename = 'Costs-ScnB')))
      ),
      class = "display",
      escape = FALSE
    )
  })

 output$text_graphspend <- renderText ({
       data <- fin_data_b()
    paste0(
      "The figure below shows the estimated annual spending of the programme(s) as a percentage of gross domestic product (GDP) in 2022 and up to 2031,
      while the following table shows the same estimates but in billions of ", econ_b()$cur,
      ". Simulations indicate that the proposed reforms  ",
      tabfullname_b[[toptab_b]],
      " would require an initial budget of ",
      econ_b()$cur,
      " ",
      format(data[[paste0("costs", toptab_b)]][1], nsmall = 0 , big.mark = ","),
      " billion. This is equivalent to ",
      format(data[[paste0("costs", toptab_b, "_gdp")]][1], nsmall = 1 , big.mark = ","),
      " per cent of ",
      param_b$country,
      "'s GDP in 2022. The projected annual spending in 2031 would reach ",
      econ_b()$cur,
      " ",
      format(data[[paste0("costs", toptab_b)]][10], nsmall = 0 , big.mark = ","),
      " billion, or ",
      format(data[[paste0("costs", toptab_b, "_gdp")]][10], nsmall = 1 , big.mark = ","),
      " per cent of ",
      param_b$country,
      "'s GDP in 2031."
    )
 })
}
