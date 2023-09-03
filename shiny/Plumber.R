# plumber.R

library(feather)
# library(shinyWidgets)
library(dplyr)
# library(rlang)
library(readr)
library(stringr)
# library(ggthemes)
library(lubridate)
library(openssl)

input <<- list()
source("./R/data_methods/params_non_reactive.R", local = TRUE)
source("./R/data_methods/dataServer_non_reactive.R", local = TRUE)

source("./R/3_functions/ineqFunctions.R", local = TRUE)

source("./R/data_methods/dataCosts_non_reactive.R", local = TRUE)

source("./R/data_methods/dataImpact_non_reactive.R", local = TRUE)

source("./R/data_methods/format_data.R", local = TRUE)

source("./R/data_methods/http_request.R", local = TRUE)
api_base <- 'https://spp.thinkbluedata.com/api/v1'

benefit_levels = as.data.frame(http_get('/analysis-benefit-level-taxonomies',api_base,''))
countries = as.data.frame(http_get('/analysis-country-taxonomies',api_base,''))
# # print(countries[18,]$name)
countries$name[countries$tid=="50018"]<-"Turkey"
countries$name[countries$tid=="50022"]<-"Lao"
# # print(countries)
indicators = as.data.frame(http_get('/analysis-indicator-taxonomies',api_base,''))
labels = as.data.frame(http_get('/analysis-label-taxonomies',api_base,''))
schemes = as.data.frame(http_get('/analysis-scheme-taxonomies',api_base,''))
types_of_result = as.data.frame(http_get('/analysis-type-of-result-taxonomies',api_base,''))
value_types = as.data.frame(http_get('/analysis-value-type-taxonomies',api_base,''))
poverty_mean_tested_tax = as.data.frame(http_get('/analysis-poverty-mean-tested-taxonomies',api_base,''))

# inputL = list()
# inputL[["country"]] = "Cambodia"
# 
# childPercentage=5
# disabilityPercentage=0
# oldagePercentage=0
# 
# gdppc2018 <- econ()$gdppc
#   
# inputL[["childbenefit"]]=TRUE
# inputL[["disabilitybenefit"]]=FALSE
# inputL[["oldagebenefit"]]=FALSE
# inputL[["childageA"]]=c(0,17)
# inputL[["disabageA"]]=c(0,64)
# inputL[["oldageA"]]=c(65,100)
# inputL[["childmeansA"]]=FALSE
# inputL[["disabmeansA"]]=FALSE
# inputL[["oldmeansA"]]=FALSE
# inputL[["childcovA"]]=0
# inputL[["disabcovA"]]=0
# inputL[["oldcovA"]]=0
# inputL[["childtransferA"]]=as.numeric(childPercentage) * gdppc2018[1] / 100 / 12
# inputL[["disabtransferA"]]=as.numeric(disabilityPercentage) * gdppc2018[1] / 100 / 12
# inputL[["oldtransferA"]]=as.numeric(oldagePercentage) * gdppc2018[1] / 100 / 12
# inputL[["child_admin"]]=5
# inputL[["disab_admin"]]=5
# inputL[["old_admin"]]=5
# inputL[["pensiontest"]]=FALSE
# inputL[["meanstested"]]=FALSE
# 
# input <<- inputL
# 
# paramL = list()
# cparamL = list()
# dparamL = list()
# oparamL = list()
# paramL$country <- inputL[["country"]] 
# 
# # child benefit (cparam) ####
# cparamL$child <- inputL[["childbenefit"]]
# cparamL$childAge <- inputL[["childageA"]]
# cparamL$childTrans <- inputL[["childtransferA"]]
# cparamL$childAdmin <- inputL[["child_admin"]]
# cparamL$childMeans <- inputL[["childmeansA"]]
# cparamL$childCov <- inputL[["childcovA"]]
# 
# # disability benefit (dparam) ####
# dparamL$disab <- inputL[["disabilitybenefit"]]
# dparamL$disabAge <- inputL[["disabageA"]]
# dparamL$disabTrans <- inputL[["disabtransferA"]]
# dparamL$disabAdmin <- inputL[["disab_admin"]]
# dparamL$disabMeans <- inputL[["disabmeansA"]]
# dparamL$disabCov <- inputL[["disabcovA"]]
# 
# # old age benefit (oparam) ####
# oparamL$old <- inputL[["oldagebenefit"]]
# oparamL$oldAge <- inputL[["oldageA"]]
# oparamL$oldTrans <- inputL[["oldtransferA"]]
# oparamL$oldAdmin <- inputL[["old_admin"]]
# oparamL$oldMeans <- inputL[["oldmeansA"]]
# oparamL$oldcovA <- inputL[["oldcovA"]]
# oparamL$oldPension <- inputL[["pensiontest"]]
# 
# param <<- paramL
# cparam <<- cparamL
# dparam <<- dparamL
# oparam <<- oparamL
# 
# cdata <- costs_data()
# 
# fdata <- fin_data()
# 
# idata <- impact_data()
# 
# ddata <- deciledata()
# 
# hdata <- hhtypedata()

dummy_country = "Simulation Country"
dummy_country_id = 50020
is_dummy_country = FALSE

# The indicator ids which have issues for zero input value: 1,2,8,10
#* To process data
#* @param
#* @get /process
function(from_cache=TRUE,param_id="999",ind_id="40012",country="Cambodia",childbenefit=TRUE,childMinAge=0,childMaxAge=17,disabilitybenefit=FALSE,disabMinAge=0,disabMaxAge=64,oldagebenefit=FALSE,oldMinAge=65,oldMaxAge=100,matbenefit=FALSE,matLength=18,childPercentage=5,disabilityPercentage=0,oldagePercentage=0,matPercentage=0,childLocalCur=0,disabilityLocalCur=0,oldageLocalCur=0,matLocalCur=0,childAdmin=5,disabAdmin=5,oldAdmin=5,matAdmin=5,scheme_id="70001",benefit_level="Other benefit",childcovA=100,disabcovA=100,oldcovA=100,matcovA=0,oldPensionTest=FALSE,special_cov=FALSE) {
  # id,country,childbenefit,disabilitybenefit,oldagebenefit,childPercentage,disabilityPercentage,oldagePercentage,scheme_id,benefit_level,childmeansA,disabmeansA,oldmeansA,childcovA,disabcovA,oldcovA,poverty_mean_tested
  # 1,Cambodia,TRUE,FALSE,FALSE,5,0,0,70001,Other benefit,FALSE,FALSE,FALSE,0,0,0,No
  # list(msg = paste0("The message is: '", msg, "'"))
  if (country == dummy_country) {
    country = "Cambodia"
    is_dummy_country = TRUE
  }
  if (country == "Lao PDR") {
    country = "Lao"
  }
  plumber_start_time <- Sys.time()
  inputL = list()
  inputL[["country"]] = country
  input <<- inputL
  gdppc2018 <- econ()$gdppc

  # print(gdppc2018)
  
  childmeansA=FALSE
  disabmeansA=FALSE
  oldmeansA=FALSE
  matmeansA=FALSE
  
  if(as.numeric(childcovA) < 100) {
    childmeansA = TRUE
  }
  
  if(as.numeric(disabcovA) < 100) {
    disabmeansA = TRUE
  }
  
  if(as.numeric(oldcovA) < 100) {
    oldmeansA = TRUE
  }
  
  if(as.numeric(matcovA) < 100) {
    matmeansA = TRUE
  }
  
  # print(childPercentage)
  if (as.numeric(childPercentage) > 0) {
    childLocalCur=as.numeric(childPercentage) * gdppc2018[1] / 100 / 12
  } else if (as.numeric(childLocalCur) > 0) {
    childPercentage=c((as.numeric(childLocalCur) * 12) * 100 / gdppc2018[1])
  } else {
    childLocalCur=0
    childPercentage=0
  }
  # print(childLocalCur)
  # print(childPercentage)
  
  if (as.numeric(disabilityPercentage) > 0) {
    disabilityLocalCur=as.numeric(disabilityPercentage) * gdppc2018[1] / 100 / 12
  } else if (as.numeric(disabilityLocalCur) > 0) {
    disabilityPercentage=c((as.numeric(disabilityLocalCur) * 12) * 100 / gdppc2018[1])
  }
  
  if (as.numeric(oldagePercentage) > 0) {
    oldageLocalCur=as.numeric(oldagePercentage) * gdppc2018[1] / 100 / 12
  } else if (as.numeric(oldageLocalCur) > 0) {
    oldagePercentage=c((as.numeric(oldageLocalCur) * 12) * 100 / gdppc2018[1])
  }
  
  if (as.numeric(matPercentage) > 0) {
    matLocalCur=as.numeric(matPercentage) * gdppc2018[1] / 100 / 12
  } else if (as.numeric(matLocalCur) > 0) {
    matPercentage=c((as.numeric(matLocalCur) * 12) * 100 / gdppc2018[1])
  }
  
  # if (as.logical(special_cov)) {
  #   hashV = md5(paste0(ind_id,country,childbenefit,childMinAge,childMaxAge,disabilitybenefit,disabMinAge,disabMaxAge,oldagebenefit,oldMinAge,oldMaxAge,childPercentage,disabilityPercentage,oldagePercentage,childAdmin,disabAdmin,oldAdmin,scheme_id,benefit_level,childcovA,disabcovA,oldcovA,oldPensionTest,special_cov))
  # } else {
    # hashV = paste0(filter(countries, name == country)$tid,'_',ind_id,'_',md5(paste0(ind_id,country,childbenefit,childMinAge,childMaxAge,disabilitybenefit,disabMinAge,disabMaxAge,oldagebenefit,oldMinAge,oldMaxAge,childPercentage,disabilityPercentage,oldagePercentage,childAdmin,disabAdmin,oldAdmin,scheme_id,benefit_level,childcovA,disabcovA,oldcovA,oldPensionTest,special_cov)))
    hashV = md5(paste0(ind_id,country,childbenefit,childMinAge,childMaxAge,disabilitybenefit,disabMinAge,disabMaxAge,oldagebenefit,oldMinAge,oldMaxAge,childPercentage,disabilityPercentage,oldagePercentage,childAdmin,disabAdmin,oldAdmin,scheme_id,benefit_level,childcovA,disabcovA,oldcovA,oldPensionTest,special_cov))
  # }
  # print(hashV)
  inputL[["childbenefit"]]=as.logical(childbenefit)
  inputL[["disabilitybenefit"]]=as.logical(disabilitybenefit)
  inputL[["oldagebenefit"]]=as.logical(oldagebenefit)
  inputL[["matbenefit"]]=as.logical(matbenefit)
  inputL[["childageA"]]=c(as.numeric(childMinAge),as.numeric(childMaxAge))
  inputL[["disabageA"]]=c(as.numeric(disabMinAge),as.numeric(disabMaxAge))
  inputL[["oldageA"]]=c(as.numeric(oldMinAge),as.numeric(oldMaxAge))
  inputL[["matlengthA"]]=as.numeric(matLength)
  inputL[["childmeansA"]]=as.logical(childmeansA)
  inputL[["disabmeansA"]]=as.logical(disabmeansA)
  inputL[["oldmeansA"]]=as.logical(oldmeansA)
  inputL[["matmeansA"]]=as.logical(matmeansA)
  inputL[["childcovA"]]=as.numeric(childcovA)
  inputL[["disabcovA"]]=as.numeric(disabcovA)
  inputL[["oldcovA"]]=as.numeric(oldcovA)
  inputL[["matcovA"]]=as.numeric(matcovA)
  inputL[["childtransferA"]]=as.numeric(childLocalCur)
  inputL[["disabtransferA"]]=as.numeric(disabilityLocalCur)
  inputL[["oldtransferA"]]=as.numeric(oldageLocalCur)
  inputL[["mattransferA"]]=as.numeric(matLocalCur)
  inputL[["child_admin"]]=as.numeric(childAdmin)
  inputL[["disab_admin"]]=as.numeric(disabAdmin)
  inputL[["old_admin"]]=as.numeric(oldAdmin)
  inputL[["mat_admin"]]=as.numeric(matAdmin)
  inputL[["pensiontest"]]=as.logical(oldPensionTest)
  inputL[["meanstested"]]=FALSE
  inputL[["specialCov"]]=as.logical(special_cov)

  input <<- inputL
  # # print(inputL)
  
  poverty_mean_tested="No"

  parameters_info <- list()

  parameters_info[['id']] <- param_id
  parameters_info[['scheme_id']] <- scheme_id
  parameters_info[['benefit_level']] <- benefit_level
  parameters_info[['poverty_mean_tested']] <- poverty_mean_tested
  parameters_info[['special_cov']] <- special_cov
  parameters_info[['pension_tested']] <- oldPensionTest

  paramL = list()
  cparamL = list()
  dparamL = list()
  oparamL = list()
  mparamL = list()
  paramL$country <- country

  # child benefit (cparam) ####
  cparamL$child <- inputL[["childbenefit"]]
  cparamL$childAge <- inputL[["childageA"]]
  cparamL$childTrans <- inputL[["childtransferA"]]
  cparamL$childAdmin <- inputL[["child_admin"]]
  cparamL$childMeans <- inputL[["childmeansA"]]
  cparamL$childCov <- inputL[["childcovA"]]

  # disability benefit (dparam) ####
  dparamL$disab <- inputL[["disabilitybenefit"]]
  dparamL$disabAge <- inputL[["disabageA"]]
  dparamL$disabTrans <- inputL[["disabtransferA"]]
  dparamL$disabAdmin <- inputL[["disab_admin"]]
  dparamL$disabMeans <- inputL[["disabmeansA"]]
  dparamL$disabCov <- inputL[["disabcovA"]]

  # old age benefit (oparam) ####
  oparamL$old <- inputL[["oldagebenefit"]]
  oparamL$oldAge <- inputL[["oldageA"]]
  oparamL$oldTrans <- inputL[["oldtransferA"]]
  oparamL$oldAdmin <- inputL[["old_admin"]]
  oparamL$oldMeans <- inputL[["oldmeansA"]]
  oparamL$oldcovA <- inputL[["oldcovA"]]
  oparamL$oldPension <- inputL[["pensiontest"]]
  
  # Maternity benefit (mparam) ####
  mparamL$mat <- inputL[["matbenefit"]]
  mparamL$matLength <- inputL[["matlengthA"]]
  mparamL$matTrans <- inputL[["mattransferA"]]
  mparamL$matAdmin <- inputL[["mat_admin"]]
  mparamL$matMeans <- inputL[["matmeansA"]]
  mparamL$matCov <- inputL[["matcovA"]]
  
  param <<- paramL
  cparam <<- cparamL
  dparam <<- dparamL
  oparam <<- oparamL
  mparam <<- mparamL

  to_fetch_from_cache = TRUE
  if(!as.logical(from_cache)) {
    to_fetch_from_cache = FALSE
  }
  # print(ind_id)
  # print(as.logical(childbenefit))
  # print(as.numeric(childLocalCur))
  # if ((ind_id=='40001' || ind_id=='40002') && ((as.logical(childbenefit) && as.numeric(childLocalCur) <= 0) || (as.logical(disabilitybenefit) && as.numeric(disabilityLocalCur) <= 0) || (as.logical(oldagebenefit) && as.numeric(oldageLocalCur) <= 0))) {
  #   to_fetch_from_cache = FALSE
  # }
  # if (country == "Maldives") {
  #   to_fetch_from_cache = FALSE
  # }
  # if ((ind_id=='40001' || ind_id=='40004') && as.logical(oldagebenefit) && as.logical(special_cov)) {
  #   to_fetch_from_cache = FALSE
  # }
  # To update years range (2022 - 2031), disable the cache of cost data for a few days
  # For Monogolia's poverty and inequality updates
  # if (country == "Mongolia" && (ind_id=='40007' || ind_id=='40008' || ind_id=='40009' || ind_id=='40010')) {
  #   to_fetch_from_cache = FALSE
  # }
  if (country == "Georgia") {
    to_fetch_from_cache = FALSE
  }
  if (file.exists(paste0("./cache_data/",hashV,".csv")) && to_fetch_from_cache) {
    formatted_data <- read.csv(paste0("./cache_data/",hashV,".csv"))
    if (nrow(formatted_data) > 0) {
      formatted_data$X <- NULL
      formatted_data$parameter<-paste0("",formatted_data$parameter,"")
      formatted_data$country<-paste0("",formatted_data$country,"")
      formatted_data$indicator<-paste0("",formatted_data$indicator,"")
      formatted_data$type_of_result<-paste0("",formatted_data$type_of_result,"")
      formatted_data$scheme<-paste0("",formatted_data$scheme,"")
      formatted_data$value_type<-paste0("",formatted_data$value_type,"")
      formatted_data$label<-paste0("",formatted_data$label,"")
      formatted_data$benefit_level<-paste0("",formatted_data$benefit_level,"")
      formatted_data$poverty_mean_tested<-paste0("",formatted_data$poverty_mean_tested,"")
      
      formatted_data$value<-paste0("",formatted_data$value,"")
      formatted_data$value[formatted_data$value=="NA"]<-"NaN"
      # formatted_data$X.1 <- NULL
    } else {
      formatted_data <- data.frame(matrix(ncol = 11, nrow = 0))
    }
  } else if (ind_id == '40012') {
    # if (refreshData) {
    #   cdata <- costs_data()
    # }
    cdata <- costs_data()
    formatted_data=format_cost_data_ind12(cdata, parameters_info)
    # formatted_data <- read.csv("./csv_output/formatted_cost12_4_14_16.csv")
  } else if (ind_id == '40014')  {
    # if (refreshData) {
    #   cdata <- costs_data()
    # }
    cdata <- costs_data()
    formatted_data=format_cost_data_ind14(cdata, parameters_info)
  } else if (ind_id == '40013')  {
    # if (refreshData) {
    #   fdata <- fin_data()
    # }
    fdata <- fin_data()
    formatted_data=format_cost_data_ind13(fdata, parameters_info)
  } else if (ind_id == '40015')  {
    # if (refreshData) {
    #   fdata <- fin_data()
    # }
    fdata <- fin_data()
    formatted_data=format_cost_data_ind15(fdata, parameters_info)
  } else if (ind_id == '40007' || ind_id == '40008' || ind_id == '40009' || ind_id == '40010')  {
    # if (refreshData) {
    #   idata <- impact_data()
    # }
    idata <- impact_data()
    # write.csv(idata, "./csv_output/impact_data.csv")
    formatted_data=format_cost_data_ind7n8n9n10(idata, parameters_info, ind_id)
  } else if (ind_id == '40011')  {
    # if (refreshData) {
    #   idata <- impact_data()
    # }
    idata <- impact_data()
    formatted_data=format_cost_data_ind11(idata, parameters_info)
  } else if (ind_id == '40001' || ind_id == '40004' || ind_id == '40005')  {
    # if (refreshData) {
    #   ddata <- deciledata()
    # }
    ddata <- deciledata()
    formatted_data=format_data_ind1n4n5(ddata, parameters_info,ind_id)
  } else if (ind_id == '40002' || ind_id == '40006')  {
    # if (refreshData) {
    #   start_time <- Sys.time()
    #   hdata <- hhtypedata()
    #   end_time <- Sys.time()
    #   
    #   # print('hhtypedata processing: ')
    #   # print(end_time - start_time)
    # }
    hdata <- hhtypedata()
    formatted_data=format_data_ind2n6(hdata, parameters_info,ind_id)
  } else if (ind_id == '40003')  {
    if (str_length(scheme_id) == 5) {
      idata <- impact_data()
      formatted_data=format_cost_data_ind3(idata, parameters_info)
    } else {
      formatted_data <- data.frame(matrix(ncol = 11, nrow = 0))
    }
  }
  
  plumber_end_time <- Sys.time()
  
  # print('Plumber API processing time: ')
  # print(plumber_end_time - plumber_start_time)
  
  if (!file.exists(paste0("./cache_data/",hashV,".csv")) && nrow(formatted_data) > 0) {
    write.csv(formatted_data, paste0("./cache_data/",hashV,".csv"))
  }
  else if (to_fetch_from_cache == FALSE) {
    write.csv(formatted_data, paste0("./cache_data/",hashV,".csv"))
  }
  
  formatted_data$value[formatted_data$value == 'NaN'] <- 'null'
  formatted_data$value[formatted_data$value == 'NA'] <- 'null'
  
  if (is_dummy_country && nrow(formatted_data) > 0 && "country" %in% colnames(formatted_data)) {
    formatted_data$country <- dummy_country_id
  }
  
  toJSON(formatted_data)
}

#* Return the information about 
#* @param country The country to get info
#* @get /existing_schema
function(country="Cambodia") {
  if (country == dummy_country) {
    country = "Cambodia"
    is_dummy_country = TRUE
  }
  if (country == "Lao PDR") {
    country = "Lao"
  }
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
  ### Existing programmes ####
  output = list()
  for(i in c("childA", "disabA", "oldA", "B")) {
    col <- match(country, countrylist) + 1
    # # print(i)
    # # print(col)
    # # print(paste(existingProg[existingProg$progtype == i, col]))
    output[[paste0("existing_", i)]] = paste(existingProg[existingProg$progtype == i, col])
    # # print(output)
  }
  formatted = list();
  formatted[["existing_child"]] = output[["existing_childA"]]
  formatted[["existing_disab"]] = output[["existing_disabA"]]
  formatted[["existing_old"]] = output[["existing_oldA"]]
  formatted[["existing_household"]] = output[["existing_B"]]
  toJSON(formatted)
}

#* Return the information about income threshold and exclusion error
#* @param country The country to get info
#* @get /exclusion_errors
function(country="Cambodia",childMinAge=0,childMaxAge=17,disabMinAge=0,disabMaxAge=64,oldMinAge=65,oldMaxAge=100,childMeans=FALSE,disabMeans=FALSE,oldMeans=FALSE,childcovA=100,disabcovA=100,oldcovA=100) {
  # id,country,childbenefit,disabilitybenefit,oldagebenefit,childPercentage,disabilityPercentage,oldagePercentage,scheme_id,benefit_level,childmeansA,disabmeansA,oldmeansA,childcovA,disabcovA,oldcovA,poverty_mean_tested
  # 1,Cambodia,TRUE,FALSE,FALSE,5,0,0,70001,Other benefit,FALSE,FALSE,FALSE,0,0,0,No
  # list(msg = paste0("The message is: '", msg, "'"))
  if (country == dummy_country) {
    country = "Cambodia"
    is_dummy_country = TRUE
  }
  if (country == "Lao PDR") {
    country = "Lao"
  }
  plumber_start_time <- Sys.time()
  inputL = list()
  inputL[["country"]] = country
  input <<- inputL
  
  childmeansA=childMeans
  disabmeansA=disabMeans
  oldmeansA=oldMeans
  
  hashV = md5(paste0('exclusion_errors_',childMinAge,childMaxAge,disabMinAge,disabMaxAge,oldMinAge,oldMaxAge,childMeans,disabMeans,oldMeans,childcovA,disabcovA,oldcovA))
  if (file.exists(paste0("./cache_data/",hashV,".csv"))) {
    formatted_data <- read.csv(paste0("./cache_data/",hashV,".csv"))
    output = list()
    if (nrow(formatted_data) > 0) {
      formatted_data$X <- NULL
      output['child_consumption_expenditure']<-paste0("",formatted_data$child_consumption_expenditure,"")
      output['child_exclusion_error']<-paste0("",formatted_data$child_exclusion_error,"")
      output['disab_consumption_expenditure']<-paste0("",formatted_data$disab_consumption_expenditure,"")
      output['disab_exclusion_error']<-paste0("",formatted_data$disab_exclusion_error,"")
      output['old_consumption_expenditure']<-paste0("",formatted_data$old_consumption_expenditure,"")
      output['old_exclusion_error']<-paste0("",formatted_data$old_exclusion_error,"")
      output['text_child']<-paste0("",formatted_data$text_child,"")
      output['text_disab']<-paste0("",formatted_data$text_disab,"")
      output['text_old']<-paste0("",formatted_data$text_old,"")
    }
  } else {
    # if(as.numeric(childcovA) < 100) {
    #   childmeansA = TRUE
    # }
    # 
    # if(as.numeric(disabcovA) < 100) {
    #   disabmeansA = TRUE
    # }
    # 
    # if(as.numeric(oldcovA) < 100) {
    #   oldmeansA = TRUE
    # }
  
    inputL[["childbenefit"]]=TRUE
    inputL[["disabilitybenefit"]]=TRUE
    inputL[["oldagebenefit"]]=TRUE
    inputL[["childageA"]]=c(as.numeric(childMinAge),as.numeric(childMaxAge))
    inputL[["disabageA"]]=c(as.numeric(disabMinAge),as.numeric(disabMaxAge))
    inputL[["oldageA"]]=c(as.numeric(oldMinAge),as.numeric(oldMaxAge))
    inputL[["childmeansA"]]=as.logical(childmeansA)
    inputL[["disabmeansA"]]=as.logical(disabmeansA)
    inputL[["oldmeansA"]]=as.logical(oldmeansA)
    inputL[["childcovA"]]=as.numeric(childcovA)
    inputL[["disabcovA"]]=as.numeric(disabcovA)
    inputL[["oldcovA"]]=as.numeric(oldcovA)
    inputL[["childtransferA"]]=0
    inputL[["disabtransferA"]]=0
    inputL[["oldtransferA"]]=0
    inputL[["child_admin"]]=5
    inputL[["disab_admin"]]=5
    inputL[["old_admin"]]=5
    # inputL[["pensiontest"]]=as.logical(oldPensionTest)
    inputL[["meanstested"]]=FALSE
    inputL[["specialCov"]]=FALSE
    
    input <<- inputL
    # # print(inputL)
    
    paramL = list()
    cparamL = list()
    dparamL = list()
    oparamL = list()
    paramL$country <- country
    
    # child benefit (cparam) ####
    cparamL$child <- inputL[["childbenefit"]]
    cparamL$childAge <- inputL[["childageA"]]
    cparamL$childTrans <- inputL[["childtransferA"]]
    cparamL$childAdmin <- inputL[["child_admin"]]
    cparamL$childMeans <- inputL[["childmeansA"]]
    cparamL$childCov <- inputL[["childcovA"]]
    
    # disability benefit (dparam) ####
    dparamL$disab <- inputL[["disabilitybenefit"]]
    dparamL$disabAge <- inputL[["disabageA"]]
    dparamL$disabTrans <- inputL[["disabtransferA"]]
    dparamL$disabAdmin <- inputL[["disab_admin"]]
    dparamL$disabMeans <- inputL[["disabmeansA"]]
    dparamL$disabCov <- inputL[["disabcovA"]]
    
    # old age benefit (oparam) ####
    oparamL$old <- inputL[["oldagebenefit"]]
    oparamL$oldAge <- inputL[["oldageA"]]
    oparamL$oldTrans <- inputL[["oldtransferA"]]
    oparamL$oldAdmin <- inputL[["old_admin"]]
    oparamL$oldMeans <- inputL[["oldmeansA"]]
    oparamL$oldCov<- inputL[["oldcovA"]]
    oparamL$oldPension <- FALSE # inputL[["pensiontest"]]
    
    param <<- paramL
    cparam <<- cparamL
    dparam <<- dparamL
    oparam <<- oparamL
    
    # print(input)
    
    output = list()
    idata <- impact_data()
    if (cparamL$childMeans && cparam$childCov > 0) {
      data1 <- idata
      data1<- data1[(data1$age>=input$childageA[1] & data1$age<=input$childageA[2]), ]
      
      data1$excluded = (data1$rank_childA > input$childcovA) * 100
      data1 <- data1[order(data1$adj_welfare),]
      
      data1$cumul <-(100 * cumsum(data1$weight) / sum(data1$weight))
      data1 <- data1[data1$cumul < input$childcovA, ]
      
      data1$exclusionrate <- weighted.mean(data1$excluded, data1$weight)
      error <- round(data1$exclusionrate[1], 1)
      
      sum <- round(max(data1$adj_welfare), 0)
      
      textchildA <-
        paste(
          "Means-tested programmes often apply a proxy means test to determine eligibility. The selected coverage determines that only children aged ",
          cparam$childAge[1],
          " to ",
          cparam$childAge[2],
          " years with a household consumption expenditure below ",
          econ()$cur,
          " ",
          format(sum, nsmall = 0 , big.mark = ","),
          " per month per capita are eligible. ",
          "Once applying a regression-based proxy means test and restricting coverage, up to ",
          format(error, nsmall = 0 , big.mark = ","),
          "% of eligible children are likely to be excluded from the programme due to targeting errors. For more information about the applied proxy means test, see the About page.",
          sep = ""
        )
      output[['child_consumption_expenditure']] = format(sum, nsmall = 0 , big.mark = ",")
      output[['child_exclusion_error']] = format(error, nsmall = 0 , big.mark = ",")
    } else {
      textchildA <- ""
      output[['child_consumption_expenditure']] = 0
      output[['child_exclusion_error']] = 0
    }
    
    if (dparamL$disabMeans && dparam$disabCov > 0) {
      
      
      data2 <- idata
      data2 <- data2[(data2$disab==1 & data2$age>=input$disabageA[1] & data2$age<=input$disabageA[2]), ]
      
      data2$excluded = (data2$rank_disabA > input$disabcovA) * 100
      data2 <- data2[order(data2$adj_welfare),]
      
      data2$cumul <-(100 * cumsum(data2$weight) / sum(data2$weight))
      data2 <- data2[data2$cumul < input$disabcovA, ]
      
      data2$exclusionrate <- weighted.mean(data2$excluded, data2$weight)
      error <- round(data2$exclusionrate[1], 1)
      
      sum <- round(max(data2$adj_welfare), 0)
      
      textdisabA <-
        paste(
          "Means-tested programmes often apply a proxy means test to determine eligibility. The selected coverage determines that only persons with severe disabilities aged ",
          dparam$disabAge[1],
          " to ",
          dparam$disabAge[2],
          " years with a household consumption expenditure below ",
          econ()$cur,
          " ",
          format(sum, nsmall = 0 , big.mark = ","),
          " per month per capita are eligible. ",
          "Once applying a regression-based proxy means test and restricting coverage, up to ",
          format(error, nsmall = 0 , big.mark = ","),
          "% of eligible persons with severe disabilities are likely to be excluded from the programme due to targeting errors. For more information about the applied proxy means test, see the About page.",
          sep = ""
        )
      output[['disab_consumption_expenditure']] = format(sum, nsmall = 0 , big.mark = ",")
      output[['disab_exclusion_error']] = format(error, nsmall = 0 , big.mark = ",")
    } else {
      textdisabA <- ""
      output[['disab_consumption_expenditure']] = 0
      output[['disab_exclusion_error']] = 0
    }
    
    if (oparamL$oldMeans && oparam$oldCov > 0) {
      
      data3 <- idata
      
      if (oparam$oldPension==TRUE) {
        data3 <- data3[(data3$pension==0 & data3$age>=input$oldageA[1] & data3$age<=input$oldageA[2]), ]
      } else {
        data3 <- data3[(data3$age>=input$oldageA[1] & data3$age<=input$oldageA[2]), ]
      }
  
      data3$excluded = (data3$rank_oldA > input$oldcovA) * 100
      data3 <- data3[order(data3$adj_welfare),]
  
      data3$cumul <-(100 * cumsum(data3$weight) / sum(data3$weight))
      data3 <- data3[data3$cumul < input$oldcovA, ]
  
      data3$exclusionrate <- weighted.mean(data3$excluded, data3$weight)
      error <- round(data3$exclusionrate[1], 1)
  
      sum <- round(max(data3$adj_welfare), 0)
  
      textoldA <-
        paste(
          "Means-tested programmes often apply a proxy means test to determine eligibility. The selected coverage determines that only older people aged ",
          oparam$oldAge[1],
          " + ",
          "years with a household consumption expenditure below ",
          econ()$cur,
          " ",
          format(sum, nsmall = 0 , big.mark = ","),
          " per month per capita are eligible. ",
          "Once applying a regression-based proxy means test and restricting coverage, up to ",
          format(error, nsmall = 0 , big.mark = ","),
          "% of eligible older people are likely to be excluded from the programme due to targeting errors. For more information about the applied proxy means test, see the About page.",
          sep = ""
        )
      output[['old_consumption_expenditure']] = format(sum, nsmall = 0 , big.mark = ",")
      output[['old_exclusion_error']] = format(error, nsmall = 0 , big.mark = ",")
      # textoldA <- ""
    } else {
      textoldA <- ""
      output[['old_consumption_expenditure']] = 0
      output[['old_exclusion_error']] = 0
    }
    
    # formatted = list();
    output[["text_child"]] = textchildA
    output[["text_disab"]] = textdisabA
    output[["text_old"]] = textoldA
    
    if (!file.exists(paste0("./cache_data/",hashV,".csv"))) {
      write.csv(output, paste0("./cache_data/",hashV,".csv"))
    }
  }
  plumber_end_time <- Sys.time()
  
  print('Plumber exclusion_errors API processing time: ')
  print(plumber_end_time - plumber_start_time)
  toJSON(output, auto_unbox = TRUE)
}


#* Return the information about income threshold and exclusion error
#* @param country The country to get info
#* @get /exclusion_errors_deciles
function(country="Cambodia",childMinAge=0,childMaxAge=17,disabMinAge=0,disabMaxAge=64,oldMinAge=65,oldMaxAge=100,childMeans=FALSE,disabMeans=FALSE,oldMeans=FALSE,childcovA=100,disabcovA=100,oldcovA=100) {
  # id,country,childbenefit,disabilitybenefit,oldagebenefit,childPercentage,disabilityPercentage,oldagePercentage,scheme_id,benefit_level,childmeansA,disabmeansA,oldmeansA,childcovA,disabcovA,oldcovA,poverty_mean_tested
  # 1,Cambodia,TRUE,FALSE,FALSE,5,0,0,70001,Other benefit,FALSE,FALSE,FALSE,0,0,0,No
  # list(msg = paste0("The message is: '", msg, "'"))
  if (country == dummy_country) {
    country = "Cambodia"
    is_dummy_country = TRUE
  }
  if (country == "Lao PDR") {
    country = "Lao"
  }
  plumber_start_time <- Sys.time()
  inputL = list()
  inputL[["country"]] = country
  input <<- inputL
  
  childmeansA=childMeans
  disabmeansA=disabMeans
  oldmeansA=oldMeans
  
  # if(as.numeric(childcovA) < 100) {
  #   childmeansA = TRUE
  # }
  # 
  # if(as.numeric(disabcovA) < 100) {
  #   disabmeansA = TRUE
  # }
  # 
  # if(as.numeric(oldcovA) < 100) {
  #   oldmeansA = TRUE
  # }
  
  inputL[["childbenefit"]]=TRUE
  inputL[["disabilitybenefit"]]=TRUE
  inputL[["oldagebenefit"]]=TRUE
  inputL[["childageA"]]=c(as.numeric(childMinAge),as.numeric(childMaxAge))
  inputL[["disabageA"]]=c(as.numeric(disabMinAge),as.numeric(disabMaxAge))
  inputL[["oldageA"]]=c(as.numeric(oldMinAge),as.numeric(oldMaxAge))
  inputL[["childmeansA"]]=as.logical(childmeansA)
  inputL[["disabmeansA"]]=as.logical(disabmeansA)
  inputL[["oldmeansA"]]=as.logical(oldmeansA)
  inputL[["childcovA"]]=as.numeric(childcovA)
  inputL[["disabcovA"]]=as.numeric(disabcovA)
  inputL[["oldcovA"]]=as.numeric(oldcovA)
  inputL[["childtransferA"]]=0
  inputL[["disabtransferA"]]=0
  inputL[["oldtransferA"]]=0
  inputL[["child_admin"]]=5
  inputL[["disab_admin"]]=5
  inputL[["old_admin"]]=5
  # inputL[["pensiontest"]]=as.logical(oldPensionTest)
  inputL[["meanstested"]]=FALSE
  inputL[["specialCov"]]=FALSE
  
  input <<- inputL
  # # print(inputL)
  
  paramL = list()
  cparamL = list()
  dparamL = list()
  oparamL = list()
  paramL$country <- country
  
  # child benefit (cparam) ####
  cparamL$child <- inputL[["childbenefit"]]
  cparamL$childAge <- inputL[["childageA"]]
  cparamL$childTrans <- inputL[["childtransferA"]]
  cparamL$childAdmin <- inputL[["child_admin"]]
  cparamL$childMeans <- inputL[["childmeansA"]]
  cparamL$childCov <- inputL[["childcovA"]]
  
  # disability benefit (dparam) ####
  dparamL$disab <- inputL[["disabilitybenefit"]]
  dparamL$disabAge <- inputL[["disabageA"]]
  dparamL$disabTrans <- inputL[["disabtransferA"]]
  dparamL$disabAdmin <- inputL[["disab_admin"]]
  dparamL$disabMeans <- inputL[["disabmeansA"]]
  dparamL$disabCov <- inputL[["disabcovA"]]
  
  # old age benefit (oparam) ####
  oparamL$old <- inputL[["oldagebenefit"]]
  oparamL$oldAge <- inputL[["oldageA"]]
  oparamL$oldTrans <- inputL[["oldtransferA"]]
  oparamL$oldAdmin <- inputL[["old_admin"]]
  oparamL$oldMeans <- inputL[["oldmeansA"]]
  oparamL$oldCov<- inputL[["oldcovA"]]
  oparamL$oldPension <- FALSE # inputL[["pensiontest"]]
  
  param <<- paramL
  cparam <<- cparamL
  dparam <<- dparamL
  oparam <<- oparamL
  
  # print(input)
  
  output = list()
  idata <- impact_data()
  if (cparamL$childMeans && cparam$childCov > 0) {
    data1 <- idata
    data1<- data1[(data1$age>=input$childageA[1] & data1$age<=input$childageA[2]), ]
    
    data1$excluded = (data1$rank_childA > input$childcovA) * 100
    data1 <- data1[order(data1$adj_welfare),]
    
    data1$cumul <-(100 * cumsum(data1$weight) / sum(data1$weight))
    data1 <- data1[data1$cumul < input$childcovA, ]
    
    data1$exclusionrate <- weighted.mean(data1$excluded, data1$weight)
    error <- round(data1$exclusionrate[1], 1)
    
    sum <- round(max(data1$adj_welfare), 0)
    
    textchildA <-
      paste(
        "Means-tested programmes often apply a proxy means test to determine eligibility. The selected coverage determines that only children aged ",
        cparam$childAge[1],
        " to ",
        cparam$childAge[2],
        " years with a household consumption expenditure below ",
        econ()$cur,
        " ",
        format(sum, nsmall = 0 , big.mark = ","),
        " per month per capita are eligible. ",
        "Once applying a regression-based proxy means test and restricting coverage, up to ",
        format(error, nsmall = 0 , big.mark = ","),
        "% of eligible children are likely to be excluded from the programme due to targeting errors. For more information about the applied proxy means test, see the About page.",
        sep = ""
      )
    output[['child_consumption_expenditure']] = format(sum, nsmall = 0 , big.mark = ",")
    output[['child_exclusion_error']] = format(error, nsmall = 0 , big.mark = ",")
  } else {
    textchildA <- ""
    output[['child_consumption_expenditure']] = 0
    output[['child_exclusion_error']] = 0
  }
  
  if (dparamL$disabMeans && dparam$disabCov > 0) {
    
    
    data2 <- idata
    data2 <- data2[(data2$disab==1 & data2$age>=input$disabageA[1] & data2$age<=input$disabageA[2]), ]
    
    data2$excluded = (data2$rank_disabA > input$disabcovA) * 100
    data2 <- data2[order(data2$adj_welfare),]
    
    data2$cumul <-(100 * cumsum(data2$weight) / sum(data2$weight))
    data2 <- data2[data2$cumul < input$disabcovA, ]
    
    data2$exclusionrate <- weighted.mean(data2$excluded, data2$weight)
    error <- round(data2$exclusionrate[1], 1)
    
    sum <- round(max(data2$adj_welfare), 0)
    
    textdisabA <-
      paste(
        "Means-tested programmes often apply a proxy means test to determine eligibility. The selected coverage determines that only persons with severe disabilities aged ",
        dparam$disabAge[1],
        " to ",
        dparam$disabAge[2],
        " years with a household consumption expenditure below ",
        econ()$cur,
        " ",
        format(sum, nsmall = 0 , big.mark = ","),
        " per month per capita are eligible. ",
        "Once applying a regression-based proxy means test and restricting coverage, up to ",
        format(error, nsmall = 0 , big.mark = ","),
        "% of eligible persons with severe disabilities are likely to be excluded from the programme due to targeting errors. For more information about the applied proxy means test, see the About page.",
        sep = ""
      )
    output[['disab_consumption_expenditure']] = format(sum, nsmall = 0 , big.mark = ",")
    output[['disab_exclusion_error']] = format(error, nsmall = 0 , big.mark = ",")
  } else {
    textdisabA <- ""
    output[['disab_consumption_expenditure']] = 0
    output[['disab_exclusion_error']] = 0
  }
  
  if (oparamL$oldMeans && oparam$oldCov > 0) {
    
    data3 <- idata
    
    if (oparam$oldPension==TRUE) {
      data3 <- data3[(data3$pension==0 & data3$age>=input$oldageA[1] & data3$age<=input$oldageA[2]), ]
    } else {
      data3 <- data3[(data3$age>=input$oldageA[1] & data3$age<=input$oldageA[2]), ]
    }
    
    data3$excluded = (data3$rank_oldA > input$oldcovA) * 100
    data3 <- data3[order(data3$adj_welfare),]
    
    data3$cumul <-(100 * cumsum(data3$weight) / sum(data3$weight))
    data3 <- data3[data3$cumul < input$oldcovA, ]
    
    data3$exclusionrate <- weighted.mean(data3$excluded, data3$weight)
    error <- round(data3$exclusionrate[1], 1)
    
    sum <- round(max(data3$adj_welfare), 0)
    
    textoldA <-
      paste(
        "Means-tested programmes often apply a proxy means test to determine eligibility. The selected coverage determines that only older people aged ",
        oparam$oldAge[1],
        " + ",
        "years with a household consumption expenditure below ",
        econ()$cur,
        " ",
        format(sum, nsmall = 0 , big.mark = ","),
        " per month per capita are eligible. ",
        "Once applying a regression-based proxy means test and restricting coverage, up to ",
        format(error, nsmall = 0 , big.mark = ","),
        "% of eligible older people are likely to be excluded from the programme due to targeting errors. For more information about the applied proxy means test, see the About page.",
        sep = ""
      )
    output[['old_consumption_expenditure']] = format(sum, nsmall = 0 , big.mark = ",")
    output[['old_exclusion_error']] = format(error, nsmall = 0 , big.mark = ",")
    # textoldA <- ""
  } else {
    textoldA <- ""
    output[['old_consumption_expenditure']] = 0
    output[['old_exclusion_error']] = 0
  }
  data_decile <- data.frame(
    decile = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total (decile)"),
    exclusion_errors = output
  )
  # formatted = list();
  output[["text_child"]] = textchildA
  output[["text_disab"]] = textdisabA
  output[["text_old"]] = textoldA
  plumber_end_time <- Sys.time()
  
  print('Plumber exclusion_errors API processing time: ')
  print(plumber_end_time - plumber_start_time)
  toJSON(output, auto_unbox = TRUE)
}

#* Return the information about 
#* @param country The country to get info
#* @get /local_currency
function(country="Cambodia", inputCurrency=0, inputPercentage=0) {
  if (country == dummy_country) {
    country = "Cambodia"
    is_dummy_country = TRUE
  }
  if (country == "Lao PDR") {
    country = "Lao"
  }
  inputL = list()
  inputL[["country"]] = country
  input <<- inputL
  
  econData <- econ()
  gdppc2018 <- econData$gdppc[1]
  
  output = list()
  output[["gdppc"]] <- as.numeric(gdppc2018)
  output[["cur"]] <- as.character(econData$cur)
  output[["min_child"]] <- 0
  output[["max_child"]] <- as.numeric(round(gdppc2018 * 0.04 / 12, -1)*4)
  output[["min_disab"]] <- 0
  output[["max_disab"]] <- as.numeric(round(gdppc2018 * 0.10 / 12, -1)*4)
  output[["min_old"]] <- 0
  output[["max_old"]] <- as.numeric(round(gdppc2018 * 0.10 / 12, -1)*4)
  
  inputCur = as.numeric(inputCurrency)
  inputPer = as.numeric(inputPercentage)
  if (inputCur > 0) {
    outputPercent <- c((inputCur * 12) * 100 / gdppc2018)
    ppp_factor <- econData$ppp * econData$cpi22/econData$cpi11
    ppp_equivalent <- round(inputCur/ppp_factor, 0)
    output[["percent"]] <- as.numeric(outputPercent)
    output[["local_currency"]] <- inputCur
    output[["ppp_equivalent"]] <- as.numeric(ppp_equivalent)
  } else if (inputPer > 0) {
    outputCurrency <- as.numeric(inputPer) * gdppc2018 / 100 / 12
    ppp_factor <- econData$ppp * econData$cpi22/econData$cpi11
    ppp_equivalent <- round(outputCurrency/ppp_factor, 0)
    output[["percent"]] <- inputPer
    output[["local_currency"]] <- as.numeric(outputCurrency)
    output[["ppp_equivalent"]] <- as.numeric(ppp_equivalent)
  } else {
    output[["percent"]] <- 0
    output[["local_currency"]] <- 0
    output[["ppp_equivalent"]] <- 0
  }
  
  toJSON(output,auto_unbox = TRUE)
}

#* Return the information about benefit_metadata for all countries
#* @param from_cache whether to return from cache data
#* @get /benefit_metadata
function(from_cache = TRUE, child_min_percentage = 0, child_max_percentage = 16, disability_min_percentage = 0, disability_max_percentage = 40, oldage_min_percentage = 0, oldage_max_percentage = 40) {
  plumber_start_time <- Sys.time()
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
      "Viet Nam",
      dummy_country)
  formatted = data.frame(country = character(),
                         gdppc = numeric(),
                         currency = character(),
                         child_min_currency = numeric(),
                         child_max_currency = numeric(),
                         child_min_percentage = numeric(),
                         child_max_percentage = numeric(),
                         disability_min_currency = numeric(),
                         disability_max_currency = numeric(),
                         disability_min_percentage = numeric(),
                         disability_max_percentage = numeric(),
                         oldage_min_currency = numeric(),
                         oldage_max_currency = numeric(),
                         oldage_min_percentage = numeric(),
                         oldage_max_percentage = numeric(),
                         stringsAsFactors = FALSE)

  hashV = md5(paste0('benefit_metadata_',child_min_percentage,child_max_percentage,disability_min_percentage,disability_max_percentage,oldage_min_percentage,oldage_max_percentage))
  # print(hashV)
  if (as.logical(from_cache) && file.exists(paste0("./cache_data/",hashV,".csv"))) {
    formatted_data <- read.csv(paste0("./cache_data/",hashV,".csv"))
    if (nrow(formatted_data) > 0) {
      formatted_data$X <- NULL
      formatted <- formatted_data
    }
  } else {
    idx = 0;
    for(country in countrylist) {
      if (country == dummy_country) {
        country = "Cambodia"
        is_dummy_country = TRUE
      }
      idx <- idx + 1
      inputL = list()
      inputL[["country"]] = country
      input <<- inputL
      
      econData <- econ()
      gdppc2018 <- econData$gdppc[1]
  
      output = c()
      if (is_dummy_country) {
        output = append(output, dummy_country)
      } else {
        output = append(output, country)
      }
      output = append(output, as.numeric(gdppc2018))
      output = append(output, as.character(econData$cur))
      output = append(output, round(as.numeric(child_min_percentage) * gdppc2018 / 100 / 12, -1))
      output = append(output, round(as.numeric(child_max_percentage) * gdppc2018 / 100 / 12, -1))
      output = append(output, as.numeric(child_min_percentage))
      output = append(output, as.numeric(child_max_percentage))
      output = append(output, round(as.numeric(disability_min_percentage) * gdppc2018 / 100 / 12, -1))
      output = append(output, round(as.numeric(disability_max_percentage) * gdppc2018 / 100 / 12, -1))
      output = append(output, as.numeric(disability_min_percentage))
      output = append(output, as.numeric(disability_max_percentage))
      output = append(output, round(as.numeric(oldage_min_percentage) * gdppc2018 / 100 / 12, -1))
      output = append(output, round(as.numeric(oldage_max_percentage) * gdppc2018 / 100 / 12, -1))
      output = append(output, as.numeric(oldage_min_percentage))
      output = append(output, as.numeric(oldage_max_percentage))
      
      formatted[idx,] = output
    }
  }

  plumber_end_time <- Sys.time()
    
  # print('Plumber benefit_metadata API processing time: ')
  # print(plumber_end_time - plumber_start_time)
    
  if (!as.logical(from_cache) || !file.exists(paste0("./cache_data/",hashV,".csv"))) {
    write.csv(formatted, paste0("./cache_data/",hashV,".csv"))
  }

  toJSON(formatted, auto_unbox = TRUE)
}

#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg="") {
  list(msg = paste0("The message is: '", msg, "'"))
}

#* Plot a histogram
#* @serializer png
#* @get /plot
function() {
  rand <- rnorm(100)
  hist(rand)
}

#* Return the sum of two numbers
#* @param a The first number to add
#* @param b The second number to add
#* @post /sum
function(a, b) {
  as.numeric(a) + as.numeric(b)
}