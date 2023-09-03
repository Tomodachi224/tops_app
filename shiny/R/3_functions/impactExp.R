## Plot functions for impact on consumption expenditure

#graphexp_all
plotGraphexp_all <- function(d, d2, t = c("A"), int = c("")) {
  
  data <- d
  data <- data[data$rural==2 & data$female_head==2,]
  total <- d2
  total <- total[total$rural==2,]
  data <- data.frame(
    Deciles = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total"),
    Exp.Increase = round(c(data[[paste0("meanexp", int, "_", t)]], total[[paste0("meanexp", int, "_", t)]]), 1)
  )
  
  data$Deciles <-
    factor(
      data$Deciles,
      levels = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total")
    )
  
  plot <-
    ggplot(data, aes(
      x = Deciles,
      y = Exp.Increase,
      fill=factor(ifelse(Deciles=="Total","National average","Deciles")),
      text = paste(
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
      alpha = 1
    ) +
    ylab("Increase in per capita \n consumption expenditure (%)")  +
    scale_fill_manual(name = "Deciles", values=c("#8EA9DB","#203764"))+
    scale_x_discrete(
      name = "Deciles",
      limits = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total")
    ) +
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
      plot.margin = unit(c(1, 1, 3, 1), "cm"),
      axis.line.x = element_line(colour = "black"),
      axis.line.y = element_line(colour = "black")
    )
}

#graphexp_ben
plotGraphexp_ben <- function(d, d2, t = c("A")) {
  
  data <- d
  data <- data[data$rural==2 & data$female_head==2,]
  total <- d2
  total <- total[total$rural==2,]
  data <- data.frame(
    Deciles = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total"),
    Exp.Increase = round(c(data[[paste0("meanbenexp_", t)]], total[[paste0("meanbenexp_", t)]]), 1)
  )

  data$Deciles <-
    factor(
      data$Deciles,
      levels = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total")
    )
  
  plot <-
    ggplot(data, aes(
      x = Deciles,
      y = Exp.Increase,
      fill=factor(ifelse(Deciles=="Total","National average","Deciles")),
      text = paste(
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
      alpha = 1
    ) +
    ylab("Increase in per capita \n consumption expenditure (%)") +
    scale_fill_manual(name = "Deciles", values=c("#8EA9DB","#203764"))+
    scale_x_discrete(
      name = "Deciles",
      limits = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total")
    ) +
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
      plot.margin = unit(c(1, 1, 3, 1), "cm"),
      axis.line.x = element_line(colour = "black"),
      axis.line.y = element_line(colour = "black")
    )
}

#graphexp_hhtype
plotGraphexp_hht <- function(d, d2, t = c("A")) {
  
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
    Exp.Increase = round(c(data[[paste0("meanbenexp_", t)]], total[[paste0("meanbenexp_", t)]]), 1)
  )
  
  data$Type <-
    factor(
      data$Type,
      levels = c("Couple household, with children", "Couple household, with no children", "Single parent/caregiver (<60 years)", "One-person household, 60+ years", "One-person household, 18-59 years", "Three generation household", "Skipped generation", "Other household types", "Total"),
    )
  
  plot <-
    ggplot(data, aes(
      x = Type,
      y = Exp.Increase,
      fill=factor(ifelse(Type=="Total","National average","Deciles")),
      text = paste(
        "Type:",
        Type,
        "<br>",
        "Consumption Increase:",
        Exp.Increase
      )
    )) +
    geom_bar(
      stat = "identity",
      size = .2,
      alpha = 1
    ) +
    ylab("Increase in per capita \n consumption expenditure (%)") +
    scale_fill_manual(name = "Deciles", values=c("#8EA9DB","#203764"))+
    scale_x_discrete(
      name = "Household type",
      labels = function(x) str_wrap(c("Couple household, with children", "Couple household, with no children", "Single parent/caregiver (<60 years)", "One-person household, 60+ years", "One-person household, 18-59 years", "Three generation household", "Skipped generation", "Other household types", "Total"), width = 5)
      ) +
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
      plot.margin = unit(c(1, 1, 3, 1), "cm"),
      axis.line.x = element_line(colour = "black"),
      axis.line.y = element_line(colour = "black")
    )
}

#graphexp_all
plotGraphexp_all_urb <- function(d, d2, t = c("A"), int = c("")) {
  
  data <- d
  data <- data[is.na(data$female_head),]
  data <- data[order(data$rural),]
  data_urban <- data[data$rural ==0,]
  data_rural <- data[data$rural ==1,]
  total <- d2
  total <- total[total$rural!=2,]
  data <- data.frame(
    Deciles = rep(c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total"), times = 2),
    Exp.Increase = round(c(data_urban[[paste0("meanexp", int, "_", t)]], total[total$rural==0, c(paste0("meanexp", int, "_", t))], data_rural[[paste0("meanexp", int, "_", t)]], total[total$rural==1, c(paste0("meanexp", int, "_", t))] ), 1),
    Area = rep(c("Urban", "Rural"), each = 11)
  )
  
  data$Deciles <-
    factor(
      data$Deciles,
      levels = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total")
    )
  
  data$Area <-
    factor(data$Area, levels = c("Urban", "Rural"))
  
  plot <-
    ggplot(data, aes(
      x = Deciles,
      y = Exp.Increase,
      group = Area,
      fill = Area,
      text = paste(
        Area,
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
      limits = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total")
    ) +
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
      plot.margin = unit(c(1, 1, 3, 1), "cm"),
      axis.line.x = element_line(colour = "black"),
      axis.line.y = element_line(colour = "black")
    )
}

#graphexp_ben
plotGraphexp_ben_urb <- function(d, d2, t = c("A")) {
  
  data <- d
  data <- data[is.na(data$female_head),]
  data <- data[order(data$rural),]
  data_urban <- data[data$rural ==0,]
  data_rural <- data[data$rural ==1,]
  total <- d2
  total <- total[total$rural!=2,]
  data <- data.frame(
    Deciles = rep(c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total"), times = 2),
    Exp.Increase = round(c(data_urban[[paste0("meanbenexp_", t)]], total[total$rural==0, c(paste0("meanbenexp_", t))], data_rural[[paste0("meanbenexp_", t)]], total[total$rural==1, c(paste0("meanbenexp_", t))] ), 1),
    Area = rep(c("Urban", "Rural"), each = 11)
  )
  
  data$Deciles <-
    factor(
      data$Deciles,
      levels = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total")
    )
  
  data$Area <-
    factor(data$Area, levels = c("Urban", "Rural"))
  
  plot <-
    ggplot(data, aes(
      x = Deciles,
      y = Exp.Increase,
      group = Area,
      fill = Area,
      text = paste(
        Area,
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
      limits = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total")
    ) +
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
      plot.margin = unit(c(1, 1, 3, 1), "cm"),
      axis.line.x = element_line(colour = "black"),
      axis.line.y = element_line(colour = "black")
    )
}

#graphexp_hhtype
plotGraphexp_hht_urb <- function(d, d2, t = c("A")) {
  
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
    Exp.Increase = round(c(data_urban[[paste0("meanbenexp_", t)]], total[total$rural==0, c(paste0("meanbenexp_", t))], data_rural[[paste0("meanbenexp_", t)]], total[total$rural==1, c(paste0("meanbenexp_", t))] ), 1),
    Area = rep(c("Urban", "Rural"), each = 9)
  )
  
  data$Type <-
    factor(
      data$Type,
      levels = c("Couple household, with children", "Couple household, with no children", "Single parent/caregiver (<60 years)", "One-person household, 60+ years", "One-person household, 18-59 years", "Three generation household", "Skipped generation", "Other household types", "Total"),
    )
  
  data$Area <-
    factor(data$Area, levels = c("Urban", "Rural"))
  
  plot <-
    ggplot(data, aes(
      x = Type,
      y = Exp.Increase,
      group = Area,
      fill = Area,
      text = paste(
        Area,
        "<br>",
        "Type:",
        Type,
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
      name = "Household type",
      labels = function(x) str_wrap(c("Couple household, with children", "Couple household, with no children", "Single parent/caregiver (<60 years)", "One-person household, 60+ years", "One-person household, 18-59 years", "Three generation household", "Skipped generation", "Other household types", "Total"), width = 5)
    ) +
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
      plot.margin = unit(c(1, 1, 3, 1), "cm"),
      axis.line.x = element_line(colour = "black"),
      axis.line.y = element_line(colour = "black")
    )
}
