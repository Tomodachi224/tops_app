## Cost module

costTabUI_c <- function(id) {
  ns <- NS(id)
  
  tagList(
    column(
      12,
      br(),
      p("This tab shows how much it would cost to implement the simulated programme(s), year by year, from 2022 to 2031. The estimates do not account for the country’s current expenditure on social protection. If a country already provides non-contributory schemes similar to those simulated, the cost projections do not refer to the additional resources needed to implement the proposed scheme(s) but to the total resources, including those that are already being spent on the existing schemes. The tab also highlights a few of the possible ﬁnancing streams that can make the proposed simulated programmes aﬀordable. For more information on sustainable financing options, see “How to finance inclusive social protection”. The tool uses data on economic growth and population projections sourced from IMF and UN DESA from 2019."),      h3("Projected annual spending (% of GDP), by programme, 2022 to 2031"),
      br(),
      plotlyOutput(ns("graphvalues")) %>% withSpinner(color = "#003972"),
      br())
  )
}

costTab_c <- function(input, output, session, toptab_c = "A", costs_data_c) {
  

  # cost
  plot_cost_c <- reactive({
    plot <- plotCost_c(d = costs_data_c())
    return(plot)
  })
  
  output$graphvalues <- renderPlotly({
    if (toptab_c=="A") {
      legend = TRUE
    } else {
      legend = FALSE
    }
    ggplotly(plot_cost_c()) %>%
      layout(legend = list(x = 100, y = 0.5),
             annotations =
               list(
                 x = 1.1,
                 y = -0.45,
                 text = "<em>Notes</em>: own calculations based on economic and population data from IMF and UN DESA",
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
      ) %>% config(displayModeBar = T, displaylogo = FALSE, modeBarButtons = list(list("toImage"))) %>% layout(xaxis=list(fixedrange=TRUE)) %>% layout(showlegend = legend) %>% layout(yaxis=list(fixedrange=TRUE))
  })
}
