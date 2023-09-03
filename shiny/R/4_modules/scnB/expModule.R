## Consumption expenditure - impacts module

expImpactUI_b <- function(id) {
  ns <- NS(id)
  
  tagList(
    br(),
    p("This tab shows the simulated increase in household consumption (i.e. household expenditure per capita) relative to the current situation. It shows by how much household consumption would increase if individuals were provided the proposed benefits without taking away any of the existing ones. Keeping existing benefits reduces chances of error by avoiding additional assumptions on the existing schemes. It also avoids confusion by preventing users to obtain negative impacts when simulating schemes that are less generous than those already in place."),
    h3("Simulated increase in household consumption expenditure"),
    br(),
    textOutput(ns("text_graphexp_all")),
    h4("Simulated impact on the household consumption expenditure for the whole population, by consumption expenditure deciles"),
    plotlyOutput(ns("graphexp_all")) %>% withSpinner(color = "#003972"),
    uiOutput(ns("switch_int")),
    conditionalPanel(
      condition = "input.country_b != 'Turkey'",
      popify(
      materialSwitch(inputId = ns("graphexp_all_urb"), label = "Urban-Rural", right =TRUE, status = "default"),
      "",
      "The Urban-Rural switch button is disabled for Turkey, as the survey data do not identify households by place of residence, and corresponds to Malé-Other Atolls for Maldives."
    )
    ),
    materialSwitch(inputId = ns("graphexp_data_all"), label = "Show data table", right =TRUE, status = "default"),
    uiOutput(ns("showdatatable_all")),
    br(),
    textOutput(ns("text_graphexp_ben")),
    h4("Simulated impact on the household consumption expenditure among recipient households, by consumption expenditure deciles"),
    plotlyOutput(ns("graphexp_ben")) %>% withSpinner(color = "#003972"),
    conditionalPanel(
      condition = "input.country_b != 'Turkey'",
      popify(
      materialSwitch(inputId = ns("graphexp_ben_urb"), label = "Urban-Rural", right =TRUE, status = "default"),
      "",
      "The Urban-Rural switch button is disabled for Turkey, as the survey data do not identify households by place of residence, and corresponds to Malé-Other Atolls for Maldives."
    )
    ),
    materialSwitch(inputId = ns("graphexp_data_ben"), label = "Show data table", right =TRUE, status = "default"),
    uiOutput(ns("showdatatable_ben")),
    br(),
    textOutput(ns("text_graphexp_hhtype")),
    h4("Simulated impact on the household consumption expenditure among recipient households, by diﬀerent household types"),
    plotlyOutput(ns("graphexp_hhtype")) %>% withSpinner(color = "#003972"),
    conditionalPanel(
      condition = "input.country_b != 'Turkey'",
      popify(
      materialSwitch(inputId = ns("graphexp_hhtype_urb"), label = "Urban-Rural", right =TRUE, status = "default"),
      "",
      "The Urban-Rural switch button is disabled for Turkey, as the survey data do not identify households by place of residence, and corresponds to Malé-Other Atolls for Maldives."
    )
    ),
    materialSwitch(inputId = ns("graphexp_data_hhtype"), label = "Show data table", right =TRUE, status = "default"),
    uiOutput(ns("showdatatable_hhtype")),
    br()
  )
}


expImpact_b <- function(input, output, session, toptab_b = "A",
                      caption_text_b,
                      param_b,
                      deciledata_b,
                      age5yrsdata_b,
                      hhtypedata_b,
                      totaldata_b) {
  
  ns <-session$ns
  
  
  output$switch_int <- renderUI({
    if (toptab_b=="A" | toptab_b=="B") {
      tagList(p(""))
    } else if (toptab_b=="matA") {
      materialSwitch(inputId = ns("graphexp_int"), label = "Consumption increase among mothers of newborns (15-49 years)", right =TRUE, status = "default")
    } else if (toptab_b=="childA") {
      materialSwitch(inputId = ns("graphexp_int"), label = "Consumption increase among children (0-17 years)", right =TRUE, status = "default")
    } else if (toptab_b=="disabA") {
      materialSwitch(inputId = ns("graphexp_int"), label = "Consumption increase among persons with severe disabilities", right =TRUE, status = "default")
    } else {
      materialSwitch(inputId = ns("graphexp_int"), label = "Consumption increase among older persons (60+ years)", right =TRUE, status = "default")
    }
  })
  
  intended_category <- reactive({
    if (toptab_b=="A" | toptab_b=="B") {
      return(0)
    } else {
      if (input$graphexp_int==TRUE && !is.null(input$graphexp_int)) {
        return(1)
      } else {
        return(0)
      }
    }
  })
  
  # observe({
  #   if (param_b$country=="Philippines" || param_b$country=="Maldives") {
  #     disable("graphexp_all_urb")
  #     disable("graphexp_ben_urb")
  #     disable("graphexp_hhtype_urb")
  #   }
  # })
  
  #Consumption expenditure - all
  output$text_graphexp_all <- renderText({
    data <- deciledata_b()
    text <-
      paste0(
        "The ﬁgure below shows the simulated increase in household consumption expenditure of the whole population by consumption expenditure deciles. Simulations indicate an increase in per capita consumption expenditure by  ",
        round(totaldata_b()[[paste0("meanexp_", toptab_b)]][1]),
        " per cent on average. Across consumption expenditure deciles, increases will range from ",
        round(data[data$decile==1 & data$female_head==2 & data$rural==2,  c(paste0("meanexp_", toptab_b))]),
        " per cent in the lowest consumption expenditure decile, to ",
        round(data[data$decile==10 & data$female_head==2 & data$rural==2,  c(paste0("meanexp_", toptab_b))]),
        " per cent in the highest consumption expenditure decile."
      )
    return(text)
  })
  plot_graphexp_all <- reactive({
    if (intended_category()==1) {
      if (input$graphexp_all_urb==FALSE) {
        plot <- plotGraphexp_all(deciledata_b(), totaldata_b(), t = c(toptab_b), int = c("int"))
      } else {
        plot <- plotGraphexp_all_urb(deciledata_b(), totaldata_b(), t = c(toptab_b), int = c("int"))
      }
    } else {
      if (input$graphexp_all_urb==FALSE) {
        plot <- plotGraphexp_all(deciledata_b(), totaldata_b(), t = c(toptab_b))
      } else {
        plot <- plotGraphexp_all_urb(deciledata_b(), totaldata_b(), t = c(toptab_b))
      }
    }
    return(plot)
  }) 
  output$graphexp_all <- renderPlotly({
    if (input$graphexp_all_urb==FALSE) {
      legend = FALSE
    } else {
      legend = TRUE
    }
    ggplotly(plot_graphexp_all(), tooltip = c("text")) %>%
      layout(
        annotations =
          list(
            x = 1,
            y = -0.45,
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
      ) %>% config(displayModeBar = T, displaylogo = FALSE, modeBarButtons = list(list("toImage"))) %>% layout(xaxis=list(fixedrange=TRUE)) %>% layout(showlegend = legend) %>% layout(yaxis=list(fixedrange=TRUE))
  })
  
  #Consumption expenditure - beneficiaries
  output$text_graphexp_ben <- renderText({
    data <- deciledata_b()
    text <-
      paste0(
        "The ﬁgure below shows the simulated increase in household consumption expenditure among recipient households by consumption expenditure deciles. Simulations indicate an increase in per capita consumption expenditure by  ",
        round(totaldata_b()[[paste0("meanbenexp_", toptab_b)]][1]),
        " per cent, on average. Across consumption expenditure deciles, increases will range from ",
        round(data[data$decile==1 & data$female_head==2 & data$rural==2,  c(paste0("meanbenexp_", toptab_b))]),
        " per cent in the lowest consumption expenditure decile, to  ",
        round(data[data$decile==10 & data$female_head==2 & data$rural==2,  c(paste0("meanbenexp_", toptab_b))]),
        " per cent in the highest consumption expenditure decile."
      )
    return(text)
  })
  plot_graphexp_ben <- reactive({
    if (input$graphexp_ben_urb==FALSE) {
      plot <- plotGraphexp_ben(deciledata_b(), totaldata_b(),  t = c(toptab_b))
    } else {
      plot <- plotGraphexp_ben_urb(deciledata_b(), totaldata_b(), t = c(toptab_b))
    }
    return(plot)
  }) 
  output$graphexp_ben <- renderPlotly({
    if (input$graphexp_ben_urb==FALSE) {
      legend = FALSE
    } else {
      legend = TRUE
    }
    ggplotly(plot_graphexp_ben(), tooltip = c("text")) %>%
      layout(
        annotations =
          list(
            x = 1,
            y = -0.45,
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
      ) %>% config(displayModeBar = T, displaylogo = FALSE, modeBarButtons = list(list("toImage"))) %>% layout(xaxis=list(fixedrange=TRUE)) %>% layout(showlegend = legend) %>% layout(yaxis=list(fixedrange=TRUE))
  })
  
  #Consumption expenditure - all, household type
  output$text_graphexp_hhtype <- renderText({
    data <- hhtypedata_b()
    text <-
      paste0(
        "The ﬁgure below shows the simulated increase in household consumption expenditure among recipient households, by diﬀerent household types. Simulations indicate an average increase in per capita consumption expenditure by ",
        round(data[data$hhtype3=="Couple household, with children" & data$female_head==2 & data$rural==2,  c(paste0("meanbenexp_", toptab_b))]),
        " per cent for couple households with children, ",
        round(data[data$hhtype3=="Couple household, with no children" & data$female_head==2 & data$rural==2,  c(paste0("meanbenexp_", toptab_b))]),
        " per cent for couple households with no children, and ",
        round(data[data$hhtype3=="One-person household, 60+ years" & data$female_head==2 & data$rural==2,  c(paste0("meanbenexp_", toptab_b))]),
        " per cent for one-person households (60+ years)."
      )
    return(text)
  })
  plot_graphexp_hhtype <- reactive({
    if (input$graphexp_hhtype_urb==FALSE) {
      plot <- plotGraphexp_hht(hhtypedata_b(), totaldata_b(),  t = c(toptab_b))
    } else {
      plot <- plotGraphexp_hht_urb(hhtypedata_b(), totaldata_b(), t = c(toptab_b))
    }
    return(plot)
  }) 
  output$graphexp_hhtype <- renderPlotly({
    if (input$graphexp_hhtype_urb==FALSE) {
      legend = FALSE
    } else {
      legend = TRUE
    }
    ggplotly(plot_graphexp_hhtype(), tooltip = c("text")) %>%
      layout(
        annotations =
          list(
            x = 1,
            y = -0.75,
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
      ) %>% config(displayModeBar = T, displaylogo = FALSE, modeBarButtons = list(list("toImage"))) %>% layout(xaxis=list(fixedrange=TRUE)) %>% layout(showlegend = legend) %>% layout(yaxis=list(fixedrange=TRUE))
  })
  
  #Show data
  output$datavalues_all <- DT::renderDataTable({
    data <- deciledata_b()
    data <- data[order(data$rural),]
    data_urban <- data[data$rural ==0 & is.na(data$female_head),]
    data_rural <- data[data$rural ==1 & is.na(data$female_head),]
    data_total <- data[data$rural ==2 & data$female_head==2,]
    total <- totaldata_b()
    
    if (intended_category()==1) {
      varname <- paste0("meanexpint_")
    } else {
      varname <- paste0("meanexp_")
    }
    
    if (param_b$country=="Philippines" || param_b$country=="Maldives" || param_b$country=="Turkey") {
      data <- data.frame(
        Deciles = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total"),
        Total = round(c(data_total[[paste0(varname,toptab_b)]], total[total$rural==2, c(paste0(varname, toptab_b))]),1)
      )
      target <- c(1)
    } else {
      data <- data.frame(
        Deciles = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total"),
        Total = round(c(data_total[[paste0(varname,toptab_b)]], total[total$rural==2, c(paste0(varname, toptab_b))]),1),
        Urban = round(c(data_urban[[paste0(varname,toptab_b)]], total[total$rural==0, c(paste0(varname, toptab_b))]),1),
        Rural = round(c(data_rural[[paste0(varname,toptab_b)]], total[total$rural==1, c(paste0(varname, toptab_b))]),1)
      )
      target <-c(1:3)
    }
    
    DT::datatable(
      data,
      rownames = FALSE,
      extensions = 'Buttons',
      options = list(
        columnDefs = list(
          list(
            className = 'dt-center',
            targets = target,
            width = '200px'
          )
        ),
        dom = 'tB',
        pageLength = 13,
        buttons = c("copy", list(list(extend='csv',
                                      filename = 'Expenditure-All-decile-ScnA'),
                                 list(extend='excel',
                                      filename = 'Expenditure-All-decile-ScnA',
                                      title = "Increase in consumption expenditure by deciles",
                                      messageBottom = caption_text_b())))
      ),
      class = "display",
      escape = FALSE
    )
  })
  output$showdatatable_all <- renderUI({
    if (input$graphexp_data_all==FALSE) {
      tagList(br())
    } else {
      DT::dataTableOutput(ns("datavalues_all")) %>% withSpinner(color = "#003972")
    }
  })
  
  output$datavalues_ben <- DT::renderDataTable({
    data <- deciledata_b()
    data <- data[order(data$rural),]
    data_urban <- data[data$rural ==0 & is.na(data$female_head),]
    data_rural <- data[data$rural ==1 & is.na(data$female_head),]
    data_total <- data[data$rural ==2 & data$female_head==2,]
    total <- totaldata_b()
    
    if (param_b$country=="Philippines" || param_b$country=="Maldives" || param_b$country=="Turkey") {
      data <- data.frame(
        Deciles = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total"),
        Total = round(c(data_total[[paste0("meanbenexp_",toptab_b)]], total[total$rural==2, c(paste0("meanbenexp_", toptab_b))]),1)
      )
      target <- c(1)
    } else {
      data <- data.frame(
        Deciles = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total"),
        Total = round(c(data_total[[paste0("meanbenexp_",toptab_b)]], total[total$rural==2, c(paste0("meanbenexp_", toptab_b))]),1),
        Urban = round(c(data_urban[[paste0("meanbenexp_",toptab_b)]], total[total$rural==0, c(paste0("meanbenexp_", toptab_b))]),1),
        Rural = round(c(data_rural[[paste0("meanbenexp_",toptab_b)]], total[total$rural==1, c(paste0("meanbenexp_", toptab_b))]),1)
      )
      target <-c(1:3)
    }
    
    DT::datatable(
      data,
      rownames = FALSE,
      extensions = 'Buttons',
      options = list(
        columnDefs = list(
          list(
            className = 'dt-center',
            targets = target,
            width = '200px'
          )
        ),
        dom = 'tB',
        pageLength = 13,
        buttons = c("copy", list(list(extend='csv',
                                      filename = 'Expenditure-Ben-decile-ScnA'),
                                 list(extend='excel',
                                      filename = 'Expenditure-Ben-decile-ScnA',
                                      title = "Increase in consumption expenditure by deciles",
                                      messageBottom = caption_text_b())))
      ),
      class = "display",
      escape = FALSE
    )
  })
  output$showdatatable_ben <- renderUI({
    if (input$graphexp_data_ben==FALSE) {
      tagList(br())
    } else {
      DT::dataTableOutput(ns("datavalues_ben")) %>% withSpinner(color = "#003972")
    }
  })
  
  output$datavalues_hhtype <- DT::renderDataTable({
    data <- hhtypedata_b()
    data <- data[order(data$rural),]
    data_urban <- data[data$rural ==0 & is.na(data$female_head),]
    data_rural <- data[data$rural ==1 & is.na(data$female_head),]
    data_total <- data[data$rural ==2 & data$female_head==2,]
    total <- totaldata_b()
    
    if (param_b$country=="Philippines" || param_b$country=="Maldives" || param_b$country=="Turkey") {
      data <- data.frame(
        Deciles = c("Couple household, with children",
                    "Couple household, with no children",
                    "One-person household, 18-59 years",
                    "One-person household, 60+ years",
                    "Other household types",
                    "Single parent/caregiver (<60 years)",
                    "Skipped generation",
                    "Three generation household", "Total"),
        Total = round(c(data_total[[paste0("meanbenexp_",toptab_b)]], total[total$rural==2, c(paste0("meanbenexp_", toptab_b))]),1)
      )
      target <- c(1)
    } else {
      data <- data.frame(
        Deciles = c("Couple household, with children",
                    "Couple household, with no children",
                    "One-person household, 18-59 years",
                    "One-person household, 60+ years",
                    "Other household types",
                    "Single parent/caregiver (<60 years)",
                    "Skipped generation",
                    "Three generation household", "Total"),
        Total = round(c(data_total[[paste0("meanbenexp_",toptab_b)]], total[total$rural==2, c(paste0("meanbenexp_", toptab_b))]),1),
        Urban = round(c(data_urban[[paste0("meanbenexp_",toptab_b)]], total[total$rural==0, c(paste0("meanbenexp_", toptab_b))]),1),
        Rural = round(c(data_rural[[paste0("meanbenexp_",toptab_b)]], total[total$rural==1, c(paste0("meanbenexp_", toptab_b))]),1)
      )
      target <-c(1:3)
    }
    
    DT::datatable(
      data,
      rownames = FALSE,
      extensions = 'Buttons',
      options = list(
        columnDefs = list(
          list(
            className = 'dt-center',
            targets = target,
            width = '200px'
          )
        ),
        dom = 'tB',
        pageLength = 13,
        buttons = c("copy", list(list(extend='csv',
                                      filename = 'Expenditure-Ben-decile-ScnA'),
                                 list(extend='excel',
                                      filename = 'Expenditure-Ben-decile-ScnA',
                                      title = "Increase in consumption expenditure by deciles",
                                      messageBottom = caption_text_b())))
      ),
      class = "display",
      escape = FALSE
    )
  })
  output$showdatatable_hhtype <- renderUI({
    if (input$graphexp_data_hhtype==FALSE) {
      tagList(br())
    } else {
      DT::dataTableOutput(ns("datavalues_hhtype")) %>% withSpinner(color = "#003972")
    }
  })
}
