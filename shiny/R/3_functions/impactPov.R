## Plot functions for poverty headcount and gap index by 5-year age groups

#graphpov
plotGraphpov <- function(d, t = c("A")) {
  data <- d
  data <- data[(data$rural==2) & !is.na(data$rural),]
  
  data <- data.frame(
    age5years = rep(
      c(
        "0-4 years",
        "5-9 years",
        "10-14 years",
        "15-19 years",
        "20-24 years",
        "25-29 years",
        "30-34 years",
        "35-39 years",
        "40-44 years",
        "45-49 years",
        "50-54 years",
        "55-59 years",
        "60-64 years",
        "65-69 years",
        "70-74 years",
        "75-79 years",
        "80+ years"
      ),
      times = 2
    ),
    poverty = c(
      round(data$meanpov, 1),
      round(data[[paste0("meanpov_", t)]], 1)
    ),
    Pov.Reduction = rep(c("Current", "Post reforms"), each = 17)
  )
  
  data$age5years <-
    factor(
      data$age5years,
      levels = c(
        "0-4 years",
        "5-9 years",
        "10-14 years",
        "15-19 years",
        "20-24 years",
        "25-29 years",
        "30-34 years",
        "35-39 years",
        "40-44 years",
        "45-49 years",
        "50-54 years",
        "55-59 years",
        "60-64 years",
        "65-69 years",
        "70-74 years",
        "75-79 years",
        "80+ years"
      )
    )
  
  data$Pov.Reduction <-
    factor(data$Pov.Reduction, levels = c("Current", "Post reforms"))
  
  plot <-
    ggplot(
      data,
      aes(
        x = age5years,
        y = poverty,
        group = Pov.Reduction,
        fill = Pov.Reduction,
        text = paste(
          Pov.Reduction,
          "<br>",
          "Age group:",
          age5years,
          "<br>",
          "Poverty (%):",
          poverty
        )
      )
    ) +
    geom_bar(
      stat = "identity",
      size = .2,
      alpha = 1,
      position = position_dodge2(width = 0.1, preserve = "single")
    ) +
    labs(y = "Poverty rate (%)", fill = "") +
    scale_x_discrete(
      name = "Five-year age groups",
      labels = c(
        "0-4",
        "5-9",
        "10-14",
        "15-19",
        "20-24",
        "25-29",
        "30-34",
        "35-39",
        "40-44",
        "45-49",
        "50-54",
        "55-59",
        "60-64",
        "65-69",
        "70-74",
        "75-79",
        "80 +"
      )
    ) +
    scale_fill_manual(values = c("#203764", "#8EA9DB") ) +
    theme(
      plot.background = element_rect(fill = "white"),
      panel.border = element_blank(),
      panel.background = element_rect(fill = "white"),
      legend.background = element_rect(fill = "white"),
      legend.text = element_text(size = 10),
      legend.title = element_blank(),
      axis.title.y = element_text(size = 12),
      axis.title.x = element_text(size = 12),
      axis.text.y = element_text(size = 10),
      axis.text.x = element_text(size = 10, angle = 90, hjust = 1),
      plot.margin = unit(c(1, 1, 2, 1), "cm"),
      axis.line.x = element_line(colour = "black"),
      axis.line.y = element_line(colour = "black")
    )
}

#graphgap
plotGraphgap <- function(d, t = c("A")) {
  data <- d
  data <- data[(data$rural==2) & !is.na(data$rural),]
  
  data <- data.frame(
    age5years = rep(
      c(
        "0-4 years",
        "5-9 years",
        "10-14 years",
        "15-19 years",
        "20-24 years",
        "25-29 years",
        "30-34 years",
        "35-39 years",
        "40-44 years",
        "45-49 years",
        "50-54 years",
        "55-59 years",
        "60-64 years",
        "65-69 years",
        "70-74 years",
        "75-79 years",
        "80+ years"
      ),
      times = 2
    ),
    gap = c(
      round(c(data$meangap), 1),
      round(c(data[[paste0("meangap_", t)]]), 1)
    ),
    Gap.Reduction = rep(c("Current", "Post reforms"), each = 17)
  )
  
  data$age5years <-
    factor(
      data$age5years,
      levels = c(
        "0-4 years",
        "5-9 years",
        "10-14 years",
        "15-19 years",
        "20-24 years",
        "25-29 years",
        "30-34 years",
        "35-39 years",
        "40-44 years",
        "45-49 years",
        "50-54 years",
        "55-59 years",
        "60-64 years",
        "65-69 years",
        "70-74 years",
        "75-79 years",
        "80+ years"
      )
    )
  data$Gap.Reduction <-
    factor(data$Gap.Reduction, levels = c("Current", "Post reforms"))
  
  plot <-
    ggplot(
      data,
      aes(
        x = age5years,
        y = gap,
        group = Gap.Reduction,
        fill = Gap.Reduction,
        text = paste(
          Gap.Reduction,
          "<br>",
          "Age group:",
          age5years,
          "<br>",
          "Poverty gap (%):",
          gap
        )
      )
    ) +
    geom_bar(
      stat = "identity",
      alpha = 1,
      position = position_dodge2(width = 0.3, preserve = "single")
    ) +
    labs(y = "Poverty gap (%)", fill = "") +
    scale_x_discrete(
      name = "Five-year age groups",
      labels = c(
        "0-4",
        "5-9",
        "10-14",
        "15-19",
        "20-24",
        "25-29",
        "30-34",
        "35-39",
        "40-44",
        "45-49",
        "50-54",
        "55-59",
        "60-64",
        "65-69",
        "70-74",
        "75-79",
        "80 +"
      )
    ) +
    scale_fill_manual(values = c("#203764", "#8EA9DB") ) +
    theme(
      plot.background = element_rect(fill = "white"),
      panel.border = element_blank(),
      panel.background = element_rect(fill = "white"),
      legend.background = element_rect(fill = "white"),
      legend.text = element_text(size = 10),
      legend.title = element_blank(),
      axis.title.y = element_text(size = 12),
      axis.title.x = element_text(size = 12),
      axis.text.y = element_text(size = 10),
      axis.text.x = element_text(size = 10, angle = 90, hjust = 1),
      plot.margin = unit(c(1, 1, 2, 1.2), "cm"),
      axis.line.x = element_line(colour = "black"),
      axis.line.y = element_line(colour = "black")
    )
}

#graphpov - summary (reduction)
plotGraphpov_c <- function(d, t = c("A")) {
  data <- d
  data <- data[(data$rural==2) & !is.na(data$rural),]
  
  data <- data.frame(
    age5years = rep(
      c(
        "0-4 years",
        "5-9 years",
        "10-14 years",
        "15-19 years",
        "20-24 years",
        "25-29 years",
        "30-34 years",
        "35-39 years",
        "40-44 years",
        "45-49 years",
        "50-54 years",
        "55-59 years",
        "60-64 years",
        "65-69 years",
        "70-74 years",
        "75-79 years",
        "80+ years"
      ),
      times = 2
    ),
    poverty = c(
      round(c(data[[paste0("pov_reduction_", t)]]), 1)
    ),
    Scenario = c(data[[paste0("Scenario")]])
  )
  
  data$age5years <-
    factor(
      data$age5years,
      levels = c(
        "0-4 years",
        "5-9 years",
        "10-14 years",
        "15-19 years",
        "20-24 years",
        "25-29 years",
        "30-34 years",
        "35-39 years",
        "40-44 years",
        "45-49 years",
        "50-54 years",
        "55-59 years",
        "60-64 years",
        "65-69 years",
        "70-74 years",
        "75-79 years",
        "80+ years"
      )
    )
  
  data$Scenario <-
    factor(data$Scenario, levels = c("Scenario A", "Scenario B"))
  
  plot <-
    ggplot(
      data,
      aes(
        x = age5years,
        y = poverty,
        group = Scenario,
        fill = Scenario,
        text = paste(
          Scenario,
          "<br>",
          "Age group:",
          age5years,
          "<br>",
          "Reduction (%):",
          poverty
        )
      )
    ) +
    geom_bar(
      stat = "identity",
      size = .2,
      alpha = 1,
      position = position_dodge2(width = 0.1, preserve = "single")
    ) +
    labs(y = "Poverty rate reduction (%)", fill = "") +
    scale_x_discrete(
      name = "Five-year age groups",
      labels = c(
        "0-4",
        "5-9",
        "10-14",
        "15-19",
        "20-24",
        "25-29",
        "30-34",
        "35-39",
        "40-44",
        "45-49",
        "50-54",
        "55-59",
        "60-64",
        "65-69",
        "70-74",
        "75-79",
        "80 +"
      )
    ) +
    scale_fill_manual(values = c("#203764", "#8EA9DB") ) +
    theme(
      plot.background = element_rect(fill = "white"),
      panel.border = element_blank(),
      panel.background = element_rect(fill = "white"),
      legend.background = element_rect(fill = "white"),
      legend.text = element_text(size = 10),
      legend.title = element_blank(),
      axis.title.y = element_text(size = 12),
      axis.title.x = element_text(size = 12),
      axis.text.y = element_text(size = 10),
      axis.text.x = element_text(size = 10, angle = 90, hjust = 1),
      plot.margin = unit(c(1, 1, 2, 1), "cm"),
      axis.line.x = element_line(colour = "black"),
      axis.line.y = element_line(colour = "black")
    )
}

#graphgap - summary (reduction)
plotGraphgap_c <- function(d, t = c("A")) {
  data <- d
  data <- data[(data$rural==2) & !is.na(data$rural),]
  
  data <- data.frame(
    age5years = rep(
      c(
        "0-4 years",
        "5-9 years",
        "10-14 years",
        "15-19 years",
        "20-24 years",
        "25-29 years",
        "30-34 years",
        "35-39 years",
        "40-44 years",
        "45-49 years",
        "50-54 years",
        "55-59 years",
        "60-64 years",
        "65-69 years",
        "70-74 years",
        "75-79 years",
        "80+ years"
      ),
      times = 2
    ),
    gap = c(
      round(c(data[[paste0("gap_reduction_", t)]]), 1)
    ),
    Scenario = c(data[[paste0("Scenario")]])
  )
  
  data$age5years <-
    factor(
      data$age5years,
      levels = c(
        "0-4 years",
        "5-9 years",
        "10-14 years",
        "15-19 years",
        "20-24 years",
        "25-29 years",
        "30-34 years",
        "35-39 years",
        "40-44 years",
        "45-49 years",
        "50-54 years",
        "55-59 years",
        "60-64 years",
        "65-69 years",
        "70-74 years",
        "75-79 years",
        "80+ years"
      )
    )
  data$Scenario <-
    factor(data$Scenario, levels = c("Scenario A", "Scenario B"))
  
  plot <-
    ggplot(
      data,
      aes(
        x = age5years,
        y = gap,
        group = Scenario,
        fill = Scenario,
        text = paste(
          Scenario,
          "<br>",
          "Age group:",
          age5years,
          "<br>",
          "Reduction(%):",
          gap
        )
      )
    ) +
    geom_bar(
      stat = "identity",
      alpha = 1,
      position = position_dodge2(width = 0.3, preserve = "single")
    ) +
    labs(y = "Poverty gap reduction (%)", fill = "") +
    scale_x_discrete(
      name = "Five-year age groups",
      labels = c(
        "0-4",
        "5-9",
        "10-14",
        "15-19",
        "20-24",
        "25-29",
        "30-34",
        "35-39",
        "40-44",
        "45-49",
        "50-54",
        "55-59",
        "60-64",
        "65-69",
        "70-74",
        "75-79",
        "80 +"
      )
    ) +
    scale_fill_manual(values = c("#203764", "#8EA9DB") ) +
    theme(
      plot.background = element_rect(fill = "white"),
      panel.border = element_blank(),
      panel.background = element_rect(fill = "white"),
      legend.background = element_rect(fill = "white"),
      legend.text = element_text(size = 10),
      legend.title = element_blank(),
      axis.title.y = element_text(size = 12),
      axis.title.x = element_text(size = 12),
      axis.text.y = element_text(size = 10),
      axis.text.x = element_text(size = 10, angle = 90, hjust = 1),
      plot.margin = unit(c(1, 1, 2, 1.2), "cm"),
      axis.line.x = element_line(colour = "black"),
      axis.line.y = element_line(colour = "black")
    )
}
