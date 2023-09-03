# library(feather)
# # library(shinyWidgets)
# library(dplyr)
# # library(rlang)
# library(readr)
# library(stringr)
# # library(ggthemes)
# library(lubridate)
# 
# 
# source("./R/data_methods/params_non_reactive.R", local = TRUE)
# source("./R/data_methods/dataServer_non_reactive.R", local = TRUE)
# 
# source("./R/3_functions/ineqFunctions.R", local = TRUE)
# 
# source("./R/data_methods/dataCosts_non_reactive.R", local = TRUE)
# 
# source("./R/data_methods/dataImpact_non_reactive.R", local = TRUE)
# 
# source("./R/data_methods/format_data.R", local = TRUE)
# 
# source("./R/data_methods/http_request.R", local = TRUE)
# api_base <- 'https://spp.thinkbluedata.com/api/v1'
# 
# benefit_levels = as.data.frame(http_get('/analysis-benefit-level-taxonomies',api_base,''))
# countries = as.data.frame(http_get('/analysis-country-taxonomies',api_base,''))
# countries$name[countries$tid=="50018"]<-"Turkey"
# countries$name[countries$tid=="50022"]<-"Lao"
# indicators = as.data.frame(http_get('/analysis-indicator-taxonomies',api_base,''))
# labels = as.data.frame(http_get('/analysis-label-taxonomies',api_base,''))
# schemes = as.data.frame(http_get('/analysis-scheme-taxonomies',api_base,''))
# types_of_result = as.data.frame(http_get('/analysis-type-of-result-taxonomies',api_base,''))
# value_types = as.data.frame(http_get('/analysis-value-type-taxonomies',api_base,''))
# poverty_mean_tested_tax = as.data.frame(http_get('/analysis-poverty-mean-tested-taxonomies',api_base,''))
# 
# # ### print(benefit_levels)
# # ### print(countries)
# # ### print(indicators)
# # ### print(labels)
# # ### print(schemes)
# # ### print(types_of_result)
# # ### print(value_types)
# 
# # gdppc2018 <- econ()$gdppc
# # transfchild_gdppc <- 5.16
# #   # c((input$childtransferA * 12) * 100 / gdppc2018[1])
# # childtransferA <- transfchild_gdppc * gdppc2018[1] / 100 / 12
# # ### print(childtransferA)
# 
# params <- data.frame(read.csv("./R/params_mat.csv", header = TRUE, sep = ","))
# # for(idx in 207:nrow(params)) {
# #   pa=params[idx,]
# #   ### print(pa$id)
# # }
# # for(idx in 521:nrow(params)) {
# for(idx in 784:784) {
# # for(idx in 1123:1430) {
#   pa=params[idx,]
#   print(pa)
#   ### print(pa$childbenefit)
#   ### print(typeof(pa$childbenefit))
# 
#   # if (!pa$disabilitybenefit) {
#   #   next
#   # }
#   # print(pa$id)
# 
#   # if (!pa$oldagebenefit) {
#   #   next
#   # }
#   # print(pa$id)
# 
#   # if (pa$scheme_id != "70001_70003" && pa$scheme_id != "70002_70003") {
#   #   # print(pa$id)
#   #   next
#   # }
# 
#   country=pa$country
# 
# 
#   input = list()
#   input[["country"]] = pa$country
# 
#   gdppc2018 <- econ()$gdppc
# 
#   input[["childbenefit"]]=pa$childbenefit
#   input[["disabilitybenefit"]]=pa$disabilitybenefit
#   input[["oldagebenefit"]]=pa$oldagebenefit
#   input[["matbenefit"]]=as.logical(pa$matbenefit)
#   input[["childageA"]]=c(0,17)
#   input[["disabageA"]]=c(0,100)
#   input[["oldageA"]]=c(65,100)
#   input[["matlengthA"]]=18
#   input[["childmeansA"]]=pa$childmeansA
#   input[["disabmeansA"]]=pa$disabmeansA
#   input[["oldmeansA"]]=pa$oldmeansA
#   input[["matmeansA"]]=as.logical(pa$matmeansA)
#   input[["childcovA"]]=pa$childcovA
#   input[["disabcovA"]]=pa$disabcovA
#   input[["oldcovA"]]=pa$oldcovA
#   input[["matcovA"]]=as.numeric(pa$matcovA)
#   input[["childtransferA"]]=pa$childPercentage * gdppc2018[1] / 100 / 12
#   input[["disabtransferA"]]=pa$disabilityPercentage * gdppc2018[1] / 100 / 12
#   input[["oldtransferA"]]=pa$oldagePercentage * gdppc2018[1] / 100 / 12
#   input[["mattransferA"]]=pa$matPercentage * gdppc2018[1] / 100 / 12
#   input[["child_admin"]]=5
#   input[["disab_admin"]]=5
#   input[["old_admin"]]=5
#   input[["mat_admin"]]=5
#   input[["pensiontest"]]=FALSE
#   input[["meanstested"]]=FALSE
#   input[["graphcov_exp_int"]]=TRUE
#   input[["specialCov"]]=as.logical(pa$special_cov)
#   input[["pensiontest"]]=as.logical(pa$pension_tested)
#   print(input)
# 
#   parameters_info <- list()
# 
#   parameters_info[['id']] <- pa$id
#   parameters_info[['scheme_id']] <- pa$scheme_id
#   parameters_info[['benefit_level']] <- pa$benefit_level
#   parameters_info[['poverty_mean_tested']] <- pa$poverty_mean_tested
#   parameters_info[['special_cov']] <- pa$special_cov
#   parameters_info[['pension_tested']] <- pa$pension_tested
# 
#   param$country <- country
# 
#   # child benefit (cparam) ####
#   cparam$child <- input[["childbenefit"]]
#   cparam$childAge <- input[["childageA"]]
#   cparam$childTrans <- input[["childtransferA"]]
#   cparam$childAdmin <- input[["child_admin"]]
#   cparam$childMeans <- input[["childmeansA"]]
#   cparam$childCov <- input[["childcovA"]]
# 
#   # disability benefit (dparam) ####
#   dparam$disab <- input[["disabilitybenefit"]]
#   dparam$disabAge <- input[["disabageA"]]
#   dparam$disabTrans <- input[["disabtransferA"]]
#   dparam$disabAdmin <- input[["disab_admin"]]
#   dparam$disabMeans <- input[["disabmeansA"]]
#   dparam$disabCov <- input[["disabcovA"]]
# 
#   # old age benefit (oparam) ####
#   oparam$old <- input[["oldagebenefit"]]
#   oparam$oldAge <- input[["oldageA"]]
#   oparam$oldTrans <- input[["oldtransferA"]]
#   oparam$oldAdmin <- input[["old_admin"]]
#   oparam$oldMeans <- input[["oldmeansA"]]
#   oparam$oldcovA <- input[["oldcovA"]]
#   
#   # Maternity benefit (mparam) ####
#   mparam$mat <- input[["matbenefit"]]
#   mparam$matLength <- input[["matlengthA"]]
#   mparam$matTrans <- input[["mattransferA"]]
#   mparam$matAdmin <- input[["mat_admin"]]
#   mparam$matMeans <- input[["matmeansA"]]
#   mparam$matCov <- input[["matcovA"]]
# 
#   cdata <- costs_data()
#   formatted_data12=format_cost_data_ind12(cdata, parameters_info)
#   formatted_data14=format_cost_data_ind14(cdata, parameters_info)
#   # # # # ### print(cdata)
#   # # # #
#   fdata <- fin_data()
#   formatted_data13=format_cost_data_ind13(fdata, parameters_info)
#   formatted_data15=format_cost_data_ind15(fdata, parameters_info)
#   #
#   # #
#   idata <- impact_data()
#   # # ### print(idata)
#   # # write.csv(idata, "./csv_output/impact_data.csv")
#   if (str_length(pa$scheme_id) == 5) {
#     formatted_data3=format_cost_data_ind3(idata, parameters_info)
#   } else {
#     formatted_data3 <- data.frame(matrix(ncol = 12, nrow = 0))
#   }
#   formatted_data7=format_cost_data_ind7n8n9n10(idata, parameters_info, '40007')
#   formatted_data8=format_cost_data_ind7n8n9n10(idata, parameters_info, '40008')
#   formatted_data9=format_cost_data_ind7n8n9n10(idata, parameters_info, '40009')
#   formatted_data10=format_cost_data_ind7n8n9n10(idata, parameters_info, '40010')
#   #
#   formatted_data11=format_cost_data_ind11(idata, parameters_info)
#   #
#   ddata <- deciledata()
#   ### print(ddata)
#   formatted_data1n4n5=format_data_ind1n4n5(ddata, parameters_info)
#   hdata <- hhtypedata()
#   formatted_data2n6=format_data_ind2n6(hdata, parameters_info)
# 
#   # formatted_data = rbind(formatted_data1n4n5,formatted_data2n6,formatted_data3,formatted_data7,formatted_data8,formatted_data9,formatted_data10,formatted_data11,formatted_data12,formatted_data13);
#   # write.csv(formatted_data, paste0("./csv_output/formatted_data_",country,"_",parameters_info[['id']],".csv"))
#   # gc()
# }
# #
# # country="Cambodia"
# #
# # input = list()
# # input[["country"]] = country
# # input[["childbenefit"]]=TRUE
# # input[["disabilitybenefit"]]=TRUE
# # input[["oldagebenefit"]]=TRUE
# # input[["childageA"]]=c(0,17)
# # input[["disabageA"]]=c(0,100)
# # input[["oldageA"]]=c(65,100)
# # input[["childmeansA"]]=FALSE
# # input[["disabmeansA"]]=FALSE
# # input[["oldmeansA"]]=FALSE
# # input[["childcovA"]]=100
# # input[["disabcovA"]]=100
# # input[["oldcovA"]]=100
# # input[["childtransferA"]]=28010
# # input[["disabtransferA"]]=94000
# # input[["oldtransferA"]]=94000
# # input[["child_admin"]]=5
# # input[["disab_admin"]]=5
# # input[["old_admin"]]=5
# # input[["pensiontest"]]=FALSE
# # input[["meanstested"]]=FALSE
# #
# # param$country <- country
# #
# # # child benefit (cparam) ####
# # cparam$child <- input[["childbenefit"]]
# # cparam$childAge <- input[["childageA"]]
# # cparam$childTrans <- input[["childtransferA"]]
# # cparam$childAdmin <- input[["child_admin"]]
# # cparam$childMeans <- input[["childmeansA"]]
# # cparam$childCov <- input[["childcovA"]]
# #
# # # disability benefit (dparam) ####
# # dparam$disab <- input[["disabilitybenefit"]]
# # dparam$disabAge <- input[["disabageA"]]
# # dparam$disabTrans <- input[["disabtransferA"]]
# # dparam$disabAdmin <- 5
# # dparam$disabMeans <- input[["disabmeansA"]]
# #
# # # old age benefit (oparam) ####
# # oparam$old <- input[["oldagebenefit"]]
# # oparam$oldAge <- input[["oldageA"]]
# # oparam$oldTrans <- input[["oldtransferA"]]
# # oparam$oldAdmin <- 5
# # oparam$oldPension <- FALSE
# # oparam$oldMeans <- FALSE
# #
# #
# #
# # # a <- filter(value_types, name == "Total")$id
# # # ### print(a)
# #
# # parameters_info <- list()
# # # parameters_info[['id']] <- '1'
# # # parameters_info[['scheme']] <- 'Child Benefit'
# # # parameters_info[['benefit_level']] <- 'Other benefit'
# #
# # # parameters_info[['id']] <- '2'
# # # parameters_info[['scheme']] <- 'Disability Benefit'
# # # parameters_info[['benefit_level']] <- 'Other benefit'
# #
# # # parameters_info[['id']] <- '3'
# # # parameters_info[['scheme']] <- 'Old Age Benefit'
# # # parameters_info[['benefit_level']] <- 'Other benefit'
# #
# # parameters_info[['id']] <- '4'
# # parameters_info[['scheme_id']] <- '70001_70002_70003'
# # parameters_info[['benefit_level']] <- 'Other benefit'
# #
# # cdata <- costs_data()
# # formatted_data12=format_cost_data_ind12(cdata, parameters_info)
# # # ### print(cdata)
# # #
# # fdata <- fin_data()
# # formatted_data13=format_cost_data_ind13(fdata, parameters_info)
# #
# # #
# # idata <- impact_data()
# # # ### print(idata)
# # write.csv(idata, "./csv_output/impact_data.csv")
# # # formatted_data3=format_cost_data_ind3(idata, parameters_info)
# # formatted_data7=format_cost_data_ind7n8n9n10(idata, parameters_info, '40007')
# # formatted_data8=format_cost_data_ind7n8n9n10(idata, parameters_info, '40008')
# # formatted_data9=format_cost_data_ind7n8n9n10(idata, parameters_info, '40009')
# # formatted_data10=format_cost_data_ind7n8n9n10(idata, parameters_info, '40010')
# #
# # formatted_data11=format_cost_data_ind11(idata, parameters_info)
# #
# # ddata <- deciledata()
# # # ### print(ddata)
# # formatted_data1n4n5=format_data_ind1n4n5(ddata, parameters_info)
# # hdata <- hhtypedata()
# # formatted_data2n6=format_data_ind2n6(hdata, parameters_info)
# #
# # formatted_data = rbind(formatted_data1n4n5,formatted_data2n6,formatted_data7,formatted_data8,formatted_data9,formatted_data10,formatted_data11,formatted_data12,formatted_data13);
# # write.csv(formatted_data, paste0("./csv_output/formatted_data_",parameters_info[['id']],".csv"))
# 
# 
