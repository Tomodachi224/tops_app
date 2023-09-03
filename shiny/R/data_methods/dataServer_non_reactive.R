svydata <- function(){
  if (is.null(input$country) || input$country ==''){
    data <- read_feather(paste0("data/", 'Georgia', " data.feather")) 
  } else {
    data <- read_feather(paste0("data/", input$country, " data.feather"))
  }
  return(data)
}

# sdata<-svydata()
# print(sdata)

# Population, disability and household size projections
prevalencesData <- read_csv("data/disability/disability_prevalences.csv")

demo <- function(){
  disab_data <- prevalencesData
  
  if (is.null(input$country) || input$country ==''){
    file <- paste0("data/", "Georgia", " data pop.csv")
    disab_data <- disab_data[disab_data$Country == "Georgia", ]
  } else {
    file <- paste0("data/", input$country, " data pop.csv")
    disab_data <- disab_data[disab_data$Country == input$country, ]
  }
  data <- read_csv(file)
  data <- data %>% filter(year >=2022 & year<=2031)
  hhsize_indata <- mean(svydata()$hhsize)
  tot_pop_proj <- c(rowSums(data[ , c(2:102)], na.rm = TRUE))
  tot_adults <- c(rowSums(data[ , c(20:80)], na.rm = TRUE))
  share_adults <- tot_adults / tot_pop_proj
  hhsize_proj <- unlist(lapply(c(1:10), function(x) hhsize_indata * (1 / (share_adults[x] / share_adults[1]))))
  tot_hh_proj <- tot_pop_proj / hhsize_proj
  
  disab_data <- as.data.frame(lapply(disab_data, rep, 10))
  disab_data[1] <- data$year / data$year
  disab_data <- disab_data * data
  colnames(disab_data)[1] <- c("year")
  
  return(
    list(
      data  = data,
      hhsize = hhsize_proj,
      tot_hh = tot_hh_proj,
      tot_pop = tot_pop_proj,
      disab = disab_data
    )
  )
  
}

# Economic data
economicData <- read_csv("data/economic_data.csv")
econ <- function(){
  # print('inside econ')
  # print(input)
  data <- economicData
  if (is.null(input$country) || input$country ==''){
    data <- data[data$Country == "Georgia", ]
  } else {
    data <- data[data$Country == input$country, ]
  }
  growth_rate <- data$gdpgrowth
  
  gdp <-
    unlist(lapply(c(1:10), function(x)
      data$gdp2022 * ((1 + gdpparam$gdp/100) ^ (x - 1))))
  gdppc <- c((gdp * 10 ^ 9) / (demo()$tot_pop * 1000))
  
  return(
    list(
      growth = growth_rate * 100, 
      gdp = gdp,
      gdppc = gdppc,
      cur = paste0(data$currency),
      rev = data$govrev2022/100,
      ppp = data$ppp11,
      usd = data$usd, 
      cpi11 = data$cpi11,
      cpi_sy = data$cpi_sy,
      cpi22 = data$cpi22,
      natpline = data$nationalpline,
      intpline1 = 1.9 * 365 / (12),
      intpline2 = 3.2 * 365 / (12),
      intpline3 = 5.5 * 365 / (12),
      steps = data$steps*1
    )
  )
}

# Gov. current expenditure data and tax burden
govfinData <- read_csv("data/govfin.csv")
govfin <- function(){
  data <- govfinData
  if (is.null(input$country) || input$country ==''){
    govfin <- data[data$country == 'Georgia', c(2:14)]
  } else {
    govfin <- data[data$country == input$country, c(2:14)]
  }
  # glimpse(govfin)
  return(govfin)
}
