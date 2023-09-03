## Coverage - impacts module

covImpactUI_b <- function(id) {
  ns <- NS(id)
  
  tagList(
    br(),
    p("This tab shows the simulated programme coverage by consumption expenditure deciles."),
    h3("Simulated coverage of programme(s)"),
    br(),
    p(textOutput(ns("text_graphcov_exp"))),
    p(textOutput(ns("text_errors"))),
    h4("Simulated coverage of the whole population, by consumption expenditure deciles"),
    plotlyOutput(ns("graphcov_exp")) %>% withSpinner(color = "#003972"),
    uiOutput(ns("switch_int")),
    conditionalPanel(
      condition = "input.country_b != 'Turkey'",
      popify(
        materialSwitch(inputId = ns("graphcov_exp_urb"), label = "Urban-Rural", right =TRUE, status = "default"),
        "",
        "The Urban-Rural switch button is disabled for Turkey, as the survey data do not identify households by place of residence, and corresponds to Malé-Other Atolls for Maldives."
      )
    ),
    materialSwitch(inputId = ns("graphcov_data"), label = "Show data table", right =TRUE, status = "default"),
    uiOutput(ns("showdatatable")),
    br(),
    textOutput(ns("text_graphcov_hhtype")),
    h4("Simulated coverage of the whole population, by different types of households"),
    plotlyOutput(ns("graphcov_hhtype")) %>% withSpinner(color = "#003972"),
    conditionalPanel(
      condition = "input.country_b != 'Turkey'",
      popify(
      materialSwitch(inputId = ns("graphcov_hhtype_urb"), label = "Urban-Rural", right =TRUE, status = "default"),
      "",
      "The Urban-Rural switch button is disabled for Turkey, as the survey data do not identify households by place of residence, and corresponds to Malé-Other Atolls for Maldives."
    )
    ),
    materialSwitch(inputId = ns("graphcov_data_hhtype"), label = "Show data table", right =TRUE, status = "default"),
    uiOutput(ns("showdatatable_hhtype")),
    br(),
    uiOutput(ns("uitabcov"))
  )
  
}

covImpact_b <- function(input, output, session, toptab_b = "A",
                                              caption_text_b,
                                              param_b,
                                              deciledata_b,
                                              age5yrsdata_b,
                                              hhtypedata_b,
                                              totaldata_b,
                                              impact_data_b, 
                                              exclusionerrors_b) {
  
  ns <-session$ns
  
  # Coverage
  
  output$switch_int <- renderUI({
    if (toptab_b=="A" | toptab_b=="B") {
      tagList(p(""))
    } else if (toptab_b=="matA") {
      materialSwitch(inputId = ns("graphcov_exp_int"), label = "Coverage among mothers of newborns (15-49 years)", right =TRUE, status = "default")
    } else if (toptab_b=="childA") {
      materialSwitch(inputId = ns("graphcov_exp_int"), label = "Coverage among children (0-17 years)", right =TRUE, status = "default")
    } else if (toptab_b=="disabA") {
      materialSwitch(inputId = ns("graphcov_exp_int"), label = "Coverage among persons with severe disabilities", right =TRUE, status = "default")
    } else {
      materialSwitch(inputId = ns("graphcov_exp_int"), label = "Coverage among older persons (60+ years)", right =TRUE, status = "default")
    }
  })
  
  intended_category <- reactive({
    if (toptab_b=="A" | toptab_b=="B") {
      return(0)
    } else {
      if (input$graphcov_exp_int==TRUE && !is.null(input$graphcov_exp_int)) {
        return(1)
      } else {
        return(0)
      }
    }
  })
  
  # observe({
  #   if (param_b$country=="Philippines" || param_b$country=="Maldives") {
  #     disable("graphcov_exp_urb")
  #     disable("graphcov_hhtype_urb")
  #   }
  # })
  
  output$text_errors<- renderText({
    text <- exclusionerrors_b()[[paste0(toptab_b)]]
    return(paste0(text))
  })
  
  #by deciles
  output$text_graphcov_exp <- renderText({
    data <- deciledata_b()
    text <-
      paste0(
        "The figure below depicts the simulated coverage by consumption expenditure deciles after the proposed reforms. Simulations indicate that ",
        round(totaldata_b()[[paste0("meancov_", toptab_b)]][1]),
        " per cent of the population are likely to benefit directly or indirectly from the programme(s). Across welfare deciles, coverage will range from ",
        round(data[data$decile==1 & data$female_head==2 & data$rural==2,  c(paste0("meancov_", toptab_b))]),
        " per cent in the lowest decile and ",
        round(data[data$decile==10 & data$female_head==2 & data$rural==2,  c(paste0("meancov_", toptab_b))]),
        " per cent in the highest decile."
      )
    return(text)
  })
  
  plot_graphcov_exp <- reactive({
    if (intended_category()==1) {
      if (input$graphcov_exp_urb==FALSE) {
        plot <- plotGraphcov_exp(dataGraphcov_exp(d = deciledata_b(), d2 = totaldata_b(), t = c(toptab_b), int = c("int")))
      } else {
        plot <- plotGraphcov_exp_urb(dataGraphcov_exp_urb(d = deciledata_b(), d2 = totaldata_b(), t = c(toptab_b), int = c("int")))
      }
    } else {
      if (input$graphcov_exp_urb==FALSE) {
        plot <- plotGraphcov_exp(dataGraphcov_exp(d = deciledata_b(), d2 = totaldata_b(), t = c(toptab_b)))
      } else {
        plot <- plotGraphcov_exp_urb(dataGraphcov_exp_urb(d = deciledata_b(), d2 = totaldata_b(), t = c(toptab_b)))
      }
    }
      return(plot)
    }) 
  output$graphcov_exp <- renderPlotly({
    if (input$graphcov_exp_urb==FALSE) {
      legend = FALSE
    } else {
      legend = TRUE
    }
    ggplotly(plot_graphcov_exp(), tooltip = c("text")) %>%
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
  
  output$datavalues <- DT::renderDataTable({
    if (intended_category()==1) {
      data1 <- dataGraphcov_exp_urb(d = deciledata_b(), d2 = totaldata_b(), t = c(toptab_b), int = c("int"))
      data2 <- dataGraphcov_exp(d = deciledata_b(), d2 = totaldata_b(), t = c(toptab_b), int = c("int"))
    } else {
      data1 <- dataGraphcov_exp_urb(d = deciledata_b(), d2 = totaldata_b(), t = c(toptab_b))
      data2 <- dataGraphcov_exp(d = deciledata_b(), d2 = totaldata_b(), t = c(toptab_b))
    }
    
    if (param_b$country=="Philippines" || param_b$country=="Maldives") {
      data <- data.frame(
        Deciles = data2$Deciles,
        Total = data2$Coverage
      )
      target <- c(1)
    } else {
      data <- data.frame(
        Deciles = data2$Deciles,
        Total = data2$Coverage,
        Urban = data1[data1$Area=="Urban", c("Coverage")],
        Rural = data1[data1$Area=="Rural", c("Coverage")]
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
                                      filename = 'Coverage-decile-ScnB'),
                                 list(extend='excel',
                                      filename = 'Coverage-decile-ScnB',
                                      title = "Coverage by deciles",
                                      messageBottom = caption_text_b())))
      ),
      class = "display",
      escape = FALSE
    )
  })
  
  output$showdatatable <- renderUI({
  if (input$graphcov_data==FALSE) {
        tagList(br())
      } else {
          DT::dataTableOutput(ns("datavalues")) %>% withSpinner(color = "#003972")
      }
        })
  
  #by household type
  output$text_graphcov_hhtype <- renderText({
    data <- hhtypedata_b()
    text <-
      paste0(
        "The figure below shows the simulated impact of the reforms on coverage by different household types. It shows that ",
        round(data[data$hhtype3=="Couple household, with children" & data$female_head==2 & data$rural==2,  c(paste0("meancov_", toptab_b))]),
        " per cent of couple households with children would be covered, while ",
        round(data[data$hhtype3=="Couple household, with no children" & data$female_head==2 & data$rural==2,  c(paste0("meancov_", toptab_b))]),
        " per cent of couple households with no children are covered. About ",
        round(data[data$hhtype3=="One-person household, 60+ years" & data$female_head==2 & data$rural==2,  c(paste0("meancov_", toptab_b))]),
        " per cent of one-person household (60+ years) would be recipients."
      )
    return(text)
  })
  plot_graphcov_hhtype <- reactive({
    if (input$graphcov_hhtype_urb==FALSE) {
      plot <- plotGraphcov_hht(dataGraphcov_hht(d = hhtypedata_b(), d2 = totaldata_b(), t = c(toptab_b)))
    } else {
      plot <- plotGraphcov_hht_urb(dataGraphcov_hht_urb(d = hhtypedata_b(), d2 = totaldata_b(), t = c(toptab_b)))
    }
    return(plot)
  }) 
  output$graphcov_hhtype <- renderPlotly({
    if (input$graphcov_hhtype_urb==FALSE) {
      legend = FALSE
    } else {
      legend = TRUE
    }
    ggplotly(plot_graphcov_hhtype(), tooltip = c("text")) %>%
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
  
  output$datavalues_hhtype <- DT::renderDataTable({
    data1 <- dataGraphcov_hht_urb(d = hhtypedata_b(), d2 = totaldata_b(), t = c(toptab_b))
    data2 <- dataGraphcov_hht(d = hhtypedata_b(), d2 = totaldata_b(), t = c(toptab_b))
    
    if (param_b$country=="Philippines" || param_b$country=="Maldives") {
      data <- data.frame(
        Type = data2$Type,
        Total = data2$Coverage
      )
      target <- c(1)
    } else {
      data <- data.frame(
        Type = data2$Type,
        Total = data2$Coverage,
        Urban = data1[data1$Area=="Urban", c("Coverage")],
        Rural = data1[data1$Area=="Rural", c("Coverage")]
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
                                      filename = 'Coverage-hhtype-ScnB'),
                                 list(extend='excel',
                                      filename = 'Coverage-hhtype-ScnB',
                                      title = "Coverage by deciles",
                                      messageBottom = caption_text_b())))
      ),
      class = "display",
      escape = FALSE
    )
  })
  
  output$showdatatable_hhtype <- renderUI({
    if (input$graphcov_data_hhtype==FALSE) {
      tagList(br())
    } else {
      DT::dataTableOutput(ns("datavalues_hhtype")) %>% withSpinner(color = "#003972")
    }
  })
  
  output$uitabcov <- renderUI({
    #if (toptab_b=="A") {
    #  tagList(p("")) 
    #} else {
      tagList(
        h4("Coverage with existing schemes and post reforms"),
        tableOutput(ns("tabcov")) %>% withSpinner(color = "#003972")
      )
   # }
  })
  
  output$tabcov <- renderTable({
    data  <- impact_data_b() 
    
    if (toptab_b == "A" | toptab_b == "B") {
      weight2 <- data$weight
      name <- paste0("Among all households")
    } else if (toptab_b == "matA") {
      weight2 <- data$weight_mat
      name <- paste0("Among mothers of newborns")
      } else if (toptab_b == "childA") {
      weight2 <- data$weight_children
      name <- paste0("Among children")
    } else if (toptab_b == "disabA") {
      weight2 <- data$weight_disab
      name <- paste0("Among persons with disabilities")
    } else {
      weight2 <- data$weight_elderly
      name <- paste0("Among older perons")
    } 
    
    colnames(data)[which(names(data) == "current_motherA")] <- "current_matA"

    data$current_A <- pmax(data$current_B, data$current_matA, data$current_childA, data$current_disabA, data$current_oldA)
    
    before1 <-
      weighted.mean(data[[paste0("current_", toptab_b)]], data$weight)
    before1 <- before1*100
    after1 <-
      weighted.mean(data[[paste0("cov_", toptab_b)]], data$weight)
    
    if (before1==0) {
      reduction1 <- NA
    } else {
      reduction1 <- (after1 - before1 ) * 100 / before1
    }
    
    before2 <-
      weighted.mean(data[[paste0("current_", toptab_b)]], weight2)
    before2 <- before2*100
    after2 <-
      weighted.mean(data[[paste0("cov_", toptab_b)]], weight2)
    
    if (before2==0) {
      reduction2 <- NA
    } else {
      reduction2 <- (after2 - before2 ) * 100 / before2
    }
    
    before <- c(before1, before2)
    after <- c(after1, after2)
    reduction <-
      c(reduction1, reduction2)
    
    data <- data.frame(
      Line = c(
        "Whole population",
        name
      ),
      Baseline = round(before, 2),
      After = round(after, 2),
      Change = round(reduction,2)
    )
    
    if (toptab_b == "B") {
      data <- data[data$Line!="Whole population",]
    }
    
    colnames(data) <-
      c("",
        "With existing schemes",
        "Post reforms", 
        "Change (%)")
    return(data)
  }, align = 'lrrr', hover = T, rownames = FALSE)
  
  
}  