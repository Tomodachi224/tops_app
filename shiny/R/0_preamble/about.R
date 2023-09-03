## Data and information required for about page

# Country availables in the tool
countrylist <-
  c("Armenia",
    "Bangladesh",
    "Bhutan",
    "Cambodia",
    "Cook Islands",
    "Georgia",
    "India",
    "Indonesia",
    "Kiribati",
    "Kyrgyzstan",
    "Lao",
    "Maldives",
    "Marshall Islands",
    "Micronesia",
    "Mongolia",
    "Myanmar",
    "Nepal",
    "Pakistan",
    "Philippines",
    "Sri Lanka",
    "Thailand",
    "Turkey",
    "Uzbekistan",
    "Viet Nam")

# information on existing programmes
existingProg <- read.csv("./documentation/existingProg.csv", header = TRUE)
names(existingProg) <- c("progtype", countrylist)

# survey reference
datasetsSurveys <- data.frame(
  Armenia = c("HILCS (2020)"),
  Bangladesh = c("HIES (2016)"),
  Bhutan = c("BLSS(2017)"),
  Cambodia = c("CSES (2019)"),
  CookIslands = c("HIES (2015)"),
  Georgia = c("WMS (2015)"),
  India = c("IHDS (2012)"),
  Indonesia = c("SUSENAS (2017)"),
  Kiribati = c("HIES (2019-2020)"),
  Kyrgyz = c("KHS (2018)"),
  Lao = c("LECS6 (2018-2019)"),
  Maldives = c("HIES (2019)"),
  MarshallIslands = c("HIES (2019-2020)"),
  Micronesia = c("HIES (2013)"),
  Mongolia = c("HSES (2018)"),
  Myanmar = c("MPLCS (2014-2015)"),
  Nepal = c("AHS (2015-2016)"),
  Pakistan = c("HIES (2015-2016)"),
  Philippines = c("APIS (2019)"),
  SriLanka = c("HIES 2016"),
  Thailand = c("SES (2018)"),
  Turkey = c("HHBA (2019)"),
  Uzbekistan =c("L2CU (2018)"),
  Vietnam = c("VHLSS (2016)")
)
names(datasetsSurveys) <- c(countrylist)
