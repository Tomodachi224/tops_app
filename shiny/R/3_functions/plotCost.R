## plot for cost tab

plotCost <-
  function(d,
           c = c("Maternity Benefit", 
                 "Child Benefit",
                 "Disability Benefit",
                 "Old Age Benefit",
                 "Household Benefit")
  ) {
    data1 <- d
    data1 <- data1[data1$year==2022 | data1$year==2024 | data1$year==2028 | data1$year==2031, ]
    category <- rep(c, each = 4)
    
    costs_gdp <- c(-1)
    hex <- c("")
    
    if (is.element("Maternity Benefit", c)) {
      costs_gdp <- c(costs_gdp, data1$costsmatA_gdp)
      hex <- c(hex,"#E4EAF5" )
    }
    
    if (is.element("Child Benefit", c)) {
      costs_gdp <- c(costs_gdp, data1$costschildA_gdp)
      hex <- c(hex,"#D9E1F2" )
    }
    
    if (is.element("Disability Benefit", c)) {
      costs_gdp <- c(costs_gdp, data1$costsdisabA_gdp)
      hex <- c(hex,"#8EA9DB" )
    }
    
    if (is.element("Old Age Benefit", c)) {
      costs_gdp <- c(costs_gdp, data1$costsoldA_gdp)
      hex <- c(hex,"#305496" )
    }
    
    if (is.element("Household Benefit", c)) {
      costs_gdp <- c(costs_gdp, data1$costsB_gdp)
      hex <- c(hex,"#203764" )
    }
    
    costs_gdp <- costs_gdp[costs_gdp != -1]
    hex <- hex[hex != ""]
    
    data <- data.frame(
      Year = rep(c("2022", "2024", "2028", "2031"), times = length(c)),
      Costs = costs_gdp,
      Programme = category
    )
    data$Programme <- factor(data$Programme, levels = c)
    
    plot <- ggplot(data, aes(x = Year, y = Costs, fill = Programme)) +
      geom_bar(
        stat = "identity",
        size = .2,
        alpha = 1,
        position = "stack") +
      ylab("Spending (as % of GDP)") +
      scale_x_discrete(name = "Year", limits = c("2022", "2024", "2028", "2031")) +
      scale_fill_manual(values = hex) +
      theme(
        plot.background = element_rect(fill = "white"),
        panel.border = element_blank(),
        panel.background = element_rect(fill = "white"),
        legend.background = element_rect(fill = "white"),
        legend.title = element_blank(),
        legend.text = element_text(size = ),
        axis.title.y = element_text(size = 14),
        axis.title.x = element_text(size = 14),
        axis.text.y = element_text(size = 14),
        axis.text.x = element_text(size = 14),
        plot.margin = unit(c(1, 1, 1.85, 1), "cm"),
        axis.line.x = element_line(colour = "black"),
        axis.line.y = element_line(colour = "black")
      )
  }



## plot or summary

plotCost_c <- function(d) {

    d <- with(d, d[order(year, prog, Scenario),])
    data <- d[(d$year==2022 | d$year==2024 | d$year==2028 | d$year==2031), ]
    
    hex <- c("#D9E1F2", "#8EA9DB", "#305496", "#203764")
    
    plot <- ggplot(data, aes(x = Scenario, y = costs, fill = prog)) +
      geom_bar(
        stat = "identity",
        size = .2,
        alpha = 1) +
      facet_grid(~year) +
      ylab("Costs (as % of GDP)") +
      scale_fill_manual(values = hex) +
      theme(
        plot.background = element_rect(fill = "white"),
        panel.border = element_blank(),
        panel.background = element_rect(fill = "white"),
        legend.background = element_rect(fill = "white"),
        legend.title = element_blank(),
        legend.text = element_text(size = ),
        axis.title.y = element_text(size = 14),
        axis.title.x = element_blank(),
        axis.text.y = element_text(size = 12),
        axis.text.x = element_text(size = 12),
        plot.margin = unit(c(1, 1.5, 3, 1.5), "cm"),
        axis.line.x = element_line(colour = "black"),
        axis.line.y = element_line(colour = "black")
      )
  }