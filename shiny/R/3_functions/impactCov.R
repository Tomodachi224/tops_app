## Data and plot functions for impact on coverage

# graphcov_exp - coverage graph: quantiles by sex
dataGraphcov_exp <- function(d, d2, t = c("A"), int = c("")) {
  data <- d
  data <- data[data$rural==2 & data$female_head==2,]
  total <- d2
  total <- total[total$rural==2,]
  data <- data.frame(
    Deciles = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total"),
    Coverage = round(c(data[[paste0("meancov", int, "_", t)]], total[[paste0("meancov", int, "_", t)]]), 1)
  )
  
  data$Deciles <-
    factor(
      data$Deciles,
      levels = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total")
    )

  
  return(data)
}
plotGraphcov_exp <- function(data) {
  plot <-
    ggplot(
      data,
      aes(
        x = Deciles,
        y = Coverage,
        fill=factor(ifelse(Deciles=="Total","National average","Deciles")),
        text = paste(
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
      alpha = 1
    ) +
    labs(y = "Coverage (%)") +
    scale_fill_manual(name = "Deciles", values=c("#8EA9DB","#203764"))+
    scale_x_discrete(
      name = "Deciles",
      limits = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total")
    ) +
    ylim(0, 100) +
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
      axis.text.x = element_text(size = 10),
      plot.margin = unit(c(1, 1, 2, 1), "cm"),
      axis.line.x = element_line(colour = "black"),
      axis.line.y = element_line(colour = "black")
    )
    return(plot)
}

#graphcov_age - coverage graph: 5-year age groups by sex
dataGraphcov_age <- function(d, t = c("A")) {
  data <- d
  data <- data[is.na(data$rural),]
  data <- data[order(data$female_head),]
  data <- data.frame(
    Age5yrs = rep(c(
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
    ), times = 2),
    Coverage = round(c(data[[paste0("meancov_", t)]]), 1),
    Sex = rep(c("Male", "Female"), each = 17)
  )
  
  data$Age5yrs <-
    factor(
      data$Age5yrs,
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
  
  data$Sex <-
    factor(data$Sex, levels = c("Male", "Female"))
  
  return(data)
}
plotGraphcov_age <- function(data) {
  plot <-
    ggplot(data, aes(
      x = Age5yrs,
      y = Coverage,
      group = Sex,
      fill = Sex,
      text = paste(Sex, "<br>","Age Groups:", Age5yrs, "<br>", "Coverage:", Coverage)
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
      name = "Age Group",
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
        "80+"
      )
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
      axis.text.x = element_text(
        size = 12,
        angle = 90,
        hjust = 1
      ),
      plot.margin = unit(c(1, 1, 1.85, 1), "cm"),
      axis.line.x = element_line(colour = "black"),
      axis.line.y = element_line(colour = "black")
    )
}

# graphcov_exp - coverage graph: quantiles by rural
dataGraphcov_exp_urb <- function(d, d2, t = c("A"), int = c("")) {
  data <- d
  data <- data[is.na(data$female_head),]
  data <- data[order(data$rural),]
  data_urban <- data[data$rural ==0,]
  data_rural <- data[data$rural ==1,]
  total <- d2
  total <- total[total$rural!=2,]
  data <- data.frame(
    Deciles = rep(c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total"), times = 2),
    Coverage = round(c(data_urban[[paste0("meancov", int, "_", t)]], total[total$rural==0, c(paste0("meancov", int, "_", t))], data_rural[[paste0("meancov", int, "_", t)]], total[total$rural==1, c(paste0("meancov", int, "_", t))] ), 1),
    Area = rep(c("Urban", "Rural"), each = 11)
  )
  
  data$Deciles <-
    factor(
      data$Deciles,
      levels = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total")
    )
  
  data$Area <-
    factor(data$Area, levels = c("Urban", "Rural"))
  
  return(data)
}
plotGraphcov_exp_urb <- function(data) {
  plot <-
    ggplot(
      data,
      aes(
        x = Deciles,
        y = Coverage,
        group = Area,
        fill = Area,
        text = paste(
          Area,
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
      limits = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total")
    ) +
    ylim(0, 100) +
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
      plot.margin = unit(c(1, 1, 2, 1), "cm"),
      axis.line.x = element_line(colour = "black"),
      axis.line.y = element_line(colour = "black")
    )
}

#graphcov_hhtype - coverage graph: hhtype groups by sex
dataGraphcov_hht <- function(d, d2, t = c("A")) {
  data <- d
  data <- data[data$rural==2 & data$female_head==2,]
  total <- d2
  total <- total[total$rural==2,]
  data <- data.frame(
    Type = c("Couple household, with children",
                 "Couple household, with no children",
                 "One-person household, 18-59 years",
                 "One-person household, 60+ years",
                 "Other household types",
                 "Single parent/caregiver (<60 years)",
                 "Skipped generation",
                 "Three generation household", "Total"),
    Coverage = round(c(data[[paste0("meancov_", t)]], total[[paste0("meancov_", t)]]), 1)
  )
  
  data$Type <-
    factor(
      data$Type,
      levels = c("Couple household, with children", "Couple household, with no children", "Single parent/caregiver (<60 years)", "One-person household, 60+ years", "One-person household, 18-59 years", "Three generation household", "Skipped generation", "Other household types", "Total"),
    )

  return(data)
}
plotGraphcov_hht <- function(data) {
  plot <-
    ggplot(data, aes(
      x = Type,
      y = Coverage,
      fill=factor(ifelse(Type=="Total","National average","Deciles")),
      text = paste("Type:", Type, "<br>", "Coverage:", Coverage)
    )) +
    geom_bar(
      stat = "identity",
      size = .2,
      alpha = 1
    ) +
    labs(y = "Coverage (%)") +
    scale_fill_manual(name = "Type", values=c("#8EA9DB","#203764"))+
    scale_x_discrete(
      name = "Household Type",
      labels = function(x) str_wrap(c("Couple household, with children", "Couple household, with no children", "Single parent/caregiver (<60 years)", "One-person household, 60+ years", "One-person household, 18-59 years", "Three generation household", "Skipped generation", "Other household types", "Total"), width = 5)
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
}

#graphcov_hhtype - coverage graph: hhtype groups by rural
dataGraphcov_hht_urb <- function(d, d2, t = c("A")) {
  data <- d
  data <- data[is.na(data$female_head),]
  data <- data[order(data$rural),]
  data_urban <- data[data$rural ==0,]
  data_rural <- data[data$rural ==1,]
  total <- d2
  total <- total[total$rural!=2,]
  data <- data.frame(
    Type = rep(c("Couple household, with children",
                 "Couple household, with no children",
                 "One-person household, 18-59 years",
                 "One-person household, 60+ years",
                 "Other household types",
                 "Single parent/caregiver (<60 years)",
                 "Skipped generation",
                 "Three generation household", "Total"), times = 2),
    Coverage = round(c(data_urban[[paste0("meancov_", t)]], total[total$rural==0, c(paste0("meancov_", t))], data_rural[[paste0("meancov_", t)]], total[total$rural==1, c(paste0("meancov_", t))] ), 1),
    Area = rep(c("Urban", "Rural"), each = 9)
  )

  data$Type <-
    factor(
      data$Type,
      levels = c("Couple household, with children", "Couple household, with no children", "Single parent/caregiver (<60 years)", "One-person household, 60+ years", "One-person household, 18-59 years", "Three generation household", "Skipped generation", "Other household types", "Total")
    )
  
  data$Area <-
    factor(data$Area, levels = c("Urban", "Rural"))
  
  return(data)
}
plotGraphcov_hht_urb <- function(data) {
  plot <-
    ggplot(data, aes(
      x = Type,
      y = Coverage,
      group = Area,
      fill = Area,
      text = paste(Area, "<br>", "Type:", Type, "<br>", "Coverage:", Coverage)
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
      labels = function(x) str_wrap(c("Couple household, with children", "Couple household, with no children", "Single parent/caregiver (<60 years)", "One-person household, 60+ years", "One-person household, 18-59 years", "Three generation household", "Skipped generation", "Other household types", "Total"), width = 10)
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
}
