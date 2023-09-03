## Consumption expenditure - impacts module

expImpactUI_c <- function(id) {
  ns <- NS(id)
  
  tagList(
    br(),
    p("This tab shows the simulated increase in household consumption (i.e. household expenditure per capita) relative to the current situation. It shows by how much household consumption would increase if individuals were provided the proposed benefits without taking away any of the existing ones. Keeping existing benefits reduces chances of error by avoiding additional assumptions on the existing schemes. It also avoids confusion by preventing users to obtain negative impacts when simulating schemes that are less generous than those already in place."),
    h3("Simulated increase in household consumption expenditure"),
    br(),
    h5("Simulated increase in household consumption expenditure among national population, by consumption expenditure deciles and Scenarios"),
    plotlyOutput(ns("graphexp_all")) %>% withSpinner(color = "#003972"),
    br(),
    h5("Simulated increase in household consumption expenditure among recipients, by consumption expenditure deciles and Scenarios"),
    plotlyOutput(ns("graphexp_cen")) %>% withSpinner(color = "#003972"),
    br()
  )
}


expImpact_c <- function(input, output, session, toptab_c = "A",
                      caption_text_c,
                      deciledata_c,
                      age5yrsdata_c) {
  

  #Consumption expenditure

  output$graphexp_all <- renderPlotly({
    
    data <- deciledata_c()
    data <- data[!is.na(data$rural) & data$rural==2 ,]
 
    data <- data.frame(
      Deciles = rep(c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest"), times = 2),
      Exp.Increase = round(c(data[[paste0("meanexp_", toptab_c)]]), 1),
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
      ggplot(data, aes(
        x = Deciles,
        y = Exp.Increase,
        group = Scenario,
        fill = Scenario,
        text = paste(
          Scenario,
          "<br>",
          "Deciles:",
          Deciles,
          "<br>",
          "Consumption Increase:",
          Exp.Increase
        )
      )) +
      geom_bar(
        stat = "identity",
        size = .2,
        alpha = 1,
        position = position_dodge2(width = 0.1, preserve = "single")
      ) +
      ylab("Increase in per capita \n consumption expenditure (%)") +
      scale_fill_manual(values = c("#203764", "#8EA9DB") ) +
      scale_x_discrete(
        name = "Deciles",
        limits = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest")
      ) +
      theme(
        plot.background = element_rect(fill = "white"),
        panel.border = element_blank(),
        panel.background = element_rect(fill = "white"),
        legend.background = element_rect(fill = "white"),
        legend.text = element_text(size = 12),
        legend.title = element_text(size = 1),
        axis.title.y = element_text(size = 12),
        axis.title.x = element_text(size = 14),
        axis.text.y = element_text(size = 12),
        axis.text.x = element_text(size = 12),
        plot.margin = unit(c(1, 1, 1.85, 1), "cm"),
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
  

  output$graphexp_cen <- renderPlotly({
    
    
    data <- deciledata_c()
    data <- data[!is.na(data$rural) & data$rural==2 ,]
    
    data <- data.frame(
      Deciles = rep(c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest"), times = 2),
      Exp.Increase = round(c(data[[paste0("meanbenexp_", toptab_c)]]), 1),
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
      ggplot(data, aes(
        x = Deciles,
        y = Exp.Increase,
        group = Scenario,
        fill = Scenario,
        text = paste(
          Scenario,
          "<br>",
          "Deciles:",
          Deciles,
          "<br>",
          "Consumption Increase:",
          Exp.Increase
        )
      )) +
      geom_bar(
        stat = "identity",
        size = .2,
        alpha = 1,
        position = position_dodge2(width = 0.1, preserve = "single")
      ) +
      ylab("Increase in per capita \n consumption expenditure (%)") +
      scale_fill_manual(values = c("#203764", "#8EA9DB") ) +
      scale_x_discrete(
        name = "Deciles",
        limits = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest")
      ) +
      theme(
        plot.background = element_rect(fill = "white"),
        panel.border = element_blank(),
        panel.background = element_rect(fill = "white"),
        legend.background = element_rect(fill = "white"),
        legend.text = element_text(size = 12),
        legend.title = element_text(size = 1),
        axis.title.y = element_text(size = 12),
        axis.title.x = element_text(size = 14),
        axis.text.y = element_text(size = 12),
        axis.text.x = element_text(size = 12),
        plot.margin = unit(c(1, 1, 1.85, 1), "cm"),
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
}
