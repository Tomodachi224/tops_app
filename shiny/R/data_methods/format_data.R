API_ENDPOINT = '/spp-data-upsert';
API_BASE_URL = 'http://localhost/rapi/v1';
KEY = ''

format_data_ind1n4n5 <- function(deciledata, parameters, ind_id='') {
  formatted_output = data.frame(parameter = numeric(),
                                country = character(),
                                indicator = numeric(),
                                type_of_result = character(),
                                scheme = character(),
                                value_type = character(),
                                label = character(),
                                benefit_level = character(),
                                poverty_mean_tested = character(),
                                special_cov = logical(),
                                pension_tested = logical(),
                                value = numeric(),
                                stringsAsFactors = FALSE)
  formatted_output_hh = data.frame(parameter = numeric(),
                                   country = character(),
                                   indicator = numeric(),
                                   type_of_result = character(),
                                   scheme = character(),
                                   value_type = character(),
                                   label = character(),
                                   benefit_level = character(),
                                   poverty_mean_tested = character(),
                                   special_cov = logical(),
                                   pension_tested = logical(),
                                   value = numeric(),
                                   stringsAsFactors = FALSE)
  formatted_output_hh4 = data.frame(parameter = numeric(),
                                    country = character(),
                                    indicator = numeric(),
                                    type_of_result = character(),
                                    scheme = character(),
                                    value_type = character(),
                                    label = character(),
                                    benefit_level = character(),
                                    poverty_mean_tested = character(),
                                    special_cov = logical(),
                                    pension_tested = logical(),
                                    value = numeric(),
                                    stringsAsFactors = FALSE)
  countryT = filter(countries, name == input$country)
  type_of_result1 = filter(types_of_result, name == "Coverage")
  type_of_result2 = filter(types_of_result, name == "Household Consumption")
  if (!is.null(parameters$scheme_id)) {
    scheme <- list()
    scheme[['tid']] <- parameters$scheme_id
  } else {
    scheme = filter(schemes, name == parameters$scheme)
  }

  benefit_level = filter(benefit_levels, name == parameters$benefit_level)
  poverty_mean_tested = filter(poverty_mean_tested_tax, name == parameters$poverty_mean_tested)
  ind_id1 = '40001'
  ind_id4 = '40004'
  ind_id5 = '40005'

  counter = 1
  data <- deciledata[order(deciledata$rural),]
  data_urban <- data[data$rural ==0 & is.na(data$female_head),]
  data_rural <- data[data$rural ==1 & is.na(data$female_head),]
  data_total <- data[data$rural ==2 & data$female_head==2,]
  total <- totaldata()
  # print(total)
  # if (input$country=="Philippines" || input$country=="Maldives") {
  #   total_urban <- total[total$rural==1,]
  # } else {
    total_urban <- total[total$rural==0,]
  # }
  total_rural <- total[total$rural==1,]
  total_total <- total[total$rural==2,]
  # print('tur')
  # print(total_urban)
  # print(nrow(total_urban))
  # print('tru')
  # print(total_rural)
  # print(nrow(total_rural))
  # print('tt')
  # print(total_total)
  # print(nrow(total_total))
  cov_key = 'meancov_A'
  exp_key = 'meanexp_A'
  if (input$specialCov) {
    if (scheme$tid == "70001") {
      cov_key = "meancovint_childA"
      exp_key = "meanexpint_childA"
    } else if (scheme$tid == "70002") {
      cov_key = "meancovint_disabA"
      exp_key = "meanexpint_disabA"
    } else if (scheme$tid == "70003") {
      cov_key = "meancovint_oldA"
      exp_key = "meanexpint_oldA"
    } else if (scheme$tid == "70004") {
      cov_key = "meancovint_matA"
      exp_key = "meanexpint_matA"
    }
  }
  # print('specialCov')
  # print(cov_key)
  # print(exp_key)
  # print(data_rural)
  # print(data_total)
  # print(total)
  # print(total[total$rural==2, c(cov_key)])
  # print(total[total$rural==0, c(cov_key)])
  if (nrow(total_total) > 0) {
    cov_value = round(c(data_total[[cov_key]], total[total$rural==2, c(cov_key)]),1);
    # if (identical(cov_value,c(0,0,0,0,0,0,0,0,0,0,0))) {
    #   cov_value = round(c(data_total[['meancov_childA']], total[total$rural==2, c('meancov_childA')]),1);
    # }
    # if (identical(cov_value,c(0,0,0,0,0,0,0,0,0,0,0))) {
    #   cov_value = round(c(data_total[['meancov_disabA']], total[total$rural==2, c('meancov_disabA')]),1);
    # }
    # if (identical(cov_value,c(0,0,0,0,0,0,0,0,0,0,0))) {
    #   cov_value = round(c(data_total[['meancov_oldA']], total[total$rural==2, c('meancov_oldA')]),1);
    # }
    # print(cov_value)
    # print(round(c(data_total[[exp_key]], total[total$rural==2, c(exp_key)]),1))
    # print(round(c(data_total[['meanbenexp_A']], total[total$rural==2, c('meanbenexp_A')]),1))
    datat <- data.frame(
      decile = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total (decile)"),
      ind1_value = cov_value,
      ind4_value = round(c(data_total[[exp_key]], total[total$rural==2, c(exp_key)]),1),
      ind5_value = round(c(data_total[['meanbenexp_A']], total[total$rural==2, c('meanbenexp_A')]),1)
    )
    datat$type = filter(value_types, name == "Total")$tid
  } else {
    datat <- data.frame(matrix(ncol = 12, nrow = 0))
  }
  # # print(datat$ind1_value[0])
  # # print(identical(datat$ind1_value,c(0,0,0,0,0,0,0,0,0,0,0)))
  if (nrow(total_urban) > 0) {
    cov_value = round(c(data_urban[[cov_key]], total[total$rural==0, c(cov_key)]),1);
    # if (identical(cov_value,c(0,0,0,0,0,0,0,0,0,0,0))) {
    #   cov_value = round(c(data_urban[['meancov_childA']], total[total$rural==0, c('meancov_childA')]),1);
    # }
    # if (identical(cov_value,c(0,0,0,0,0,0,0,0,0,0,0))) {
    #   cov_value = round(c(data_urban[['meancov_disabA']], total[total$rural==0, c('meancov_disabA')]),1);
    # }
    # if (identical(cov_value,c(0,0,0,0,0,0,0,0,0,0,0))) {
    #   cov_value = round(c(data_urban[['meancov_oldA']], total[total$rural==0, c('meancov_oldA')]),1);
    # }
    # print('datau')
    datau <- data.frame(
      decile = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total (decile)"),
      ind1_value = cov_value,
      ind4_value = round(c(data_urban[[exp_key]], total[total$rural==0, c(exp_key)]),1),
      ind5_value = round(c(data_urban[['meanbenexp_A']], total[total$rural==0, c('meanbenexp_A')]),1)
    )
    datau$type = filter(value_types, name == "Urban")$tid
  } else {
    datau <- data.frame(matrix(ncol = 12, nrow = 0))
  }
  if (nrow(total_rural) > 0) {
    cov_value = round(c(data_rural[[cov_key]], total[total$rural==1, c(cov_key)]),1);
    # if (identical(cov_value,c(0,0,0,0,0,0,0,0,0,0,0))) {
    #   cov_value = round(c(data_rural[['meancov_childA']], total[total$rural==1, c('meancov_childA')]),1);
    # }
    # if (identical(cov_value,c(0,0,0,0,0,0,0,0,0,0,0))) {
    #   cov_value = round(c(data_rural[['meancov_disabA']], total[total$rural==1, c('meancov_disabA')]),1);
    # }
    # if (identical(cov_value,c(0,0,0,0,0,0,0,0,0,0,0))) {
    #   cov_value = round(c(data_rural[['meancov_oldA']], total[total$rural==1, c('meancov_oldA')]),1);
    # }
    # print('datar')
    # print(cov_value)
    # print(round(c(data_rural[[exp_key]], total[total$rural==1, c(exp_key)]),1))
    # print(round(c(data_rural[['meanbenexp_A']], total[total$rural==1, c('meanbenexp_A')]),1))
    datar <- data.frame(
      decile = c("Lowest", "2", "3", "4", "5", "6", "7", "8", "9", "Highest", "Total (decile)"),
      ind1_value = cov_value,
      ind4_value = round(c(data_rural[[exp_key]], total[total$rural==1, c(exp_key)]),1),
      ind5_value = round(c(data_rural[['meanbenexp_A']], total[total$rural==1, c('meanbenexp_A')]),1)
    )
    datar$type = filter(value_types, name == "Rural")$tid
  } else {
    datar <- data.frame(matrix(ncol = 12, nrow = 0))
  }
  # ### # print(datat)
  # ### # print(datau)
  # ### # print(datar)
  combine_data <- rbind(datat, datau, datar)
  # ### # print(combine_data)
  for (i in 1:nrow(combine_data)) {
    # ### # print(deciledata[i,]);
    d = combine_data[i,];
    # ### # print(d);
    # ### # print(d$decile)
    # ### # print(d$rural)
    # ### # print(typeof(d$rural))
    # ### # print(d$rural[1])
    # parameter	country	indicator	type_of_result	scheme
    label = filter(labels, name == as.character(d$decile))
    fo = c();
    fo = append(fo, parameters$id);
    fo = append(fo, countryT$tid);
    fo = append(fo, ind_id1);
    fo = append(fo, type_of_result1$tid);
    fo = append(fo, scheme$tid);
    fo = append(fo, d$type);
    fo = append(fo, label$tid);
    fo = append(fo, benefit_level$tid);
    fo = append(fo, poverty_mean_tested$tid);
    fo = append(fo, parameters$special_cov);
    fo = append(fo, parameters$pension_tested);
    fo = append(fo, round(d$ind1_value,1));
    formatted_output[counter, ] <- fo;

    fohh = c();
    fohh = append(fohh, parameters$id);
    fohh = append(fohh, countryT$tid);
    fohh = append(fohh, ind_id5);
    fohh = append(fohh, type_of_result2$tid);
    fohh = append(fohh, scheme$tid);
    fohh = append(fohh, d$type);
    fohh = append(fohh, label$tid);
    fohh = append(fohh, benefit_level$tid);
    fohh = append(fohh, poverty_mean_tested$tid);
    fohh = append(fohh, parameters$special_cov);
    fohh = append(fohh, parameters$pension_tested);
    fohh = append(fohh, round(d$ind5_value,1));
    # fohh2 = append(fohh2, d$meanexp_A);
    formatted_output_hh[counter, ] <- fohh;

    fohh2 = c();
    fohh2 = append(fohh2, parameters$id);
    fohh2 = append(fohh2, countryT$tid);
    fohh2 = append(fohh2, ind_id4);
    fohh2 = append(fohh2, type_of_result2$tid);
    fohh2 = append(fohh2, scheme$tid);
    fohh2 = append(fohh2, d$type);
    fohh2 = append(fohh2, label$tid);
    fohh2 = append(fohh2, benefit_level$tid);
    fohh2 = append(fohh2, poverty_mean_tested$tid);
    fohh2 = append(fohh2, parameters$special_cov);
    fohh2 = append(fohh2, parameters$pension_tested);
    fohh2 = append(fohh2, round(d$ind4_value,1));
    formatted_output_hh4[counter, ] <- fohh2;

    counter<-counter+1
  }
  # formatted_output <- formatted_output[order(formatted_output$value_type),]
  # formatted_output <- append(formatted_output, formatted_output_hh);
  # write.csv(formatted_output, "./csv_output/formatted_ind1.csv")
  # write.csv(formatted_output_hh, "./csv_output/formatted_ind5.csv")
  # write.csv(formatted_output_hh4, "./csv_output/formatted_ind4.csv")
  # write.csv(deciledata, "./csv_output/deciledata.csv")

  fdata = rbind(formatted_output,formatted_output_hh,formatted_output_hh4);
  # fdata = rbind(formatted_output,formatted_output_hh4);

  # http_post(API_ENDPOINT,fdata,API_BASE_URL,KEY)
  if (ind_id == '40001') {
    return(formatted_output)
  } else if (ind_id == '40005') {
    return(formatted_output_hh)
  } else if (ind_id == '40004') {
    return(formatted_output_hh4)
  } else {
    return(fdata);
  }
}

format_data_ind2n6 <- function(hhtype, parameters, ind_id='') {
  formatted_hhtype2 = data.frame(parameter = numeric(),
                                 country = character(),
                                 indicator = numeric(),
                                 type_of_result = character(),
                                 scheme = character(),
                                 value_type = character(),
                                 label = character(),
                                 benefit_level = character(),
                                 poverty_mean_tested = character(),
                                 special_cov = logical(),
                                 pension_tested = logical(),
                                 value = numeric(),
                                 stringsAsFactors = FALSE)
  formatted_hhtype6 = data.frame(parameter = numeric(),
                                 country = character(),
                                 indicator = numeric(),
                                 type_of_result = character(),
                                 scheme = character(),
                                 value_type = character(),
                                 label = character(),
                                 benefit_level = character(),
                                 poverty_mean_tested = character(),
                                 special_cov = logical(),
                                 pension_tested = logical(),
                                 value = numeric(),
                                 stringsAsFactors = FALSE)
  countryT = filter(countries, name == input$country)
  type_of_result1 = filter(types_of_result, name == "Coverage")
  type_of_result2 = filter(types_of_result, name == "Household Consumption")
  if (!is.null(parameters$scheme_id)) {
    scheme <- list()
    scheme[['tid']] <- parameters$scheme_id
  } else {
    scheme = filter(schemes, name == parameters$scheme)
  }
  benefit_level = filter(benefit_levels, name == parameters$benefit_level)
  poverty_mean_tested = filter(poverty_mean_tested_tax, name == parameters$poverty_mean_tested)
  ind_id2 = '40002'
  ind_id6 = '40006'

  counter = 1
  data <- hhtype[order(hhtype$rural),]
  data_urban <- data[data$rural ==0 & is.na(data$female_head),]
  data_rural <- data[data$rural ==1 & is.na(data$female_head),]
  data_total <- data[data$rural ==2 & data$female_head==2,]
  total <- totaldata()
  
  cov_key = 'meancov_A'
  # if (input$specialCov) {
  #   if (scheme$tid == "70001") {
  #     cov_key = "meancovint_childA"
  #   } else if (scheme$tid == "70002") {
  #     cov_key = "meancovint_disabA"
  #   } else if (scheme$tid == "70003") {
  #     cov_key = "meancovint_oldA"
  #   }
  # }
  # print('specialCov')
  # print(cov_key)

  if (nrow(data_total) > 0) {
    cov_value = round(c(data_total[[cov_key]], total[total$rural==2, c(cov_key)]),1);
    # if (identical(cov_value,c(0,0,0,0,0,0,0,0,0,0,0))) {
    #   cov_value = round(c(data_total[['meancov_childA']], total[total$rural==2, c('meancov_childA')]),1);
    # }
    # if (identical(cov_value,c(0,0,0,0,0,0,0,0,0,0,0))) {
    #   cov_value = round(c(data_total[['meancov_disabA']], total[total$rural==2, c('meancov_disabA')]),1);
    # }
    # if (identical(cov_value,c(0,0,0,0,0,0,0,0,0,0,0))) {
    #   cov_value = round(c(data_total[['meancov_oldA']], total[total$rural==2, c('meancov_oldA')]),1);
    # }
    datat <- data.frame(
      decile = c("Couple household, with children",
                           "Couple household, with no children",
                           "One-person household, 18-59 years",
                           "One-person household, 60+ years",
                           "Other household types",
                           "Single parent/caregiver (<60 years)",
                           "Skipped generation",
                           "Three generation household", "Total (types of households)"),
      ind2_value = cov_value,
      ind6_value = round(c(data_total[['meanbenexp_A']], total[total$rural==2, c('meanbenexp_A')]),1)
    )
    datat$type = filter(value_types, name == "Total")$tid
  } else {
    datat <- data.frame(matrix(ncol = 9, nrow = 0))
  }
  if (nrow(data_urban) > 0) {
    cov_value = round(c(data_urban[[cov_key]], total[total$rural==0, c(cov_key)]),1);
    # if (identical(cov_value,c(0,0,0,0,0,0,0,0,0,0,0))) {
    #   cov_value = round(c(data_urban[['meancov_childA']], total[total$rural==0, c('meancov_childA')]),1);
    # }
    # if (identical(cov_value,c(0,0,0,0,0,0,0,0,0,0,0))) {
    #   cov_value = round(c(data_urban[['meancov_disabA']], total[total$rural==0, c('meancov_disabA')]),1);
    # }
    # if (identical(cov_value,c(0,0,0,0,0,0,0,0,0,0,0))) {
    #   cov_value = round(c(data_urban[['meancov_oldA']], total[total$rural==0, c('meancov_oldA')]),1);
    # }
    datau <- data.frame(
      decile = c("Couple household, with children",
                 "Couple household, with no children",
                 "One-person household, 18-59 years",
                 "One-person household, 60+ years",
                 "Other household types",
                 "Single parent/caregiver (<60 years)",
                 "Skipped generation",
                 "Three generation household", "Total (types of households)"),
      ind2_value = round(c(data_urban[[cov_key]], total[total$rural==0, c(cov_key)]),1),
      ind6_value = round(c(data_urban[['meanbenexp_A']], total[total$rural==0, c('meanbenexp_A')]),1)
    )
    datau$type = filter(value_types, name == "Urban")$tid
  } else {
    datau <- data.frame(matrix(ncol = 9, nrow = 0))
  }
  if (nrow(data_rural) > 0) {
    cov_value = round(c(data_rural[[cov_key]], total[total$rural==1, c(cov_key)]),1);
    # if (identical(cov_value,c(0,0,0,0,0,0,0,0,0,0,0))) {
    #   cov_value = round(c(data_rural[['meancov_childA']], total[total$rural==1, c('meancov_childA')]),1);
    # }
    # if (identical(cov_value,c(0,0,0,0,0,0,0,0,0,0,0))) {
    #   cov_value = round(c(data_rural[['meancov_disabA']], total[total$rural==1, c('meancov_disabA')]),1);
    # }
    # if (identical(cov_value,c(0,0,0,0,0,0,0,0,0,0,0))) {
    #   cov_value = round(c(data_rural[['meancov_oldA']], total[total$rural==1, c('meancov_oldA')]),1);
    # }
    datar <- data.frame(
      decile = c("Couple household, with children",
                          "Couple household, with no children",
                          "One-person household, 18-59 years",
                          "One-person household, 60+ years",
                          "Other household types",
                          "Single parent/caregiver (<60 years)",
                          "Skipped generation",
                          "Three generation household", "Total (types of households)"),
      ind2_value = round(c(data_rural[[cov_key]], total[total$rural==1, c(cov_key)]),1),
      ind6_value = round(c(data_rural[['meanbenexp_A']], total[total$rural==1, c('meanbenexp_A')]),1)
    )
    datar$type = filter(value_types, name == "Rural")$tid
  } else {
    datar <- data.frame(matrix(ncol = 9, nrow = 0))
  }
  # ### # print(datat)
  combine_data <- rbind(datat, datau, datar)
  # ### # print(combine_data)
  for (i in 1:nrow(combine_data)) {
    # ### # print(deciledata[i,]);
    d = combine_data[i,];
    # ### # print(d);
    # ### # print(d$decile)
    # ### # print(d$rural)
    # ### # print(typeof(d$rural))
    # ### # print(d$rural[1])
    # parameter	country	indicator	type_of_result	scheme
    label = filter(labels, name == as.character(d$decile))
    fo = c();
    fo = append(fo, parameters$id);
    fo = append(fo, countryT$tid);
    fo = append(fo, ind_id2);
    fo = append(fo, type_of_result1$tid);
    fo = append(fo, scheme$tid);
    fo = append(fo, d$type);
    fo = append(fo, label$tid);
    fo = append(fo, benefit_level$tid);
    fo = append(fo, poverty_mean_tested$tid);
    fo = append(fo, parameters$special_cov);
    fo = append(fo, parameters$pension_tested);
    fo = append(fo, round(d$ind2_value,1));
    formatted_hhtype2[counter, ] <- fo;

    fohh = c();
    fohh = append(fohh, parameters$id);
    fohh = append(fohh, countryT$tid);
    fohh = append(fohh, ind_id6);
    fohh = append(fohh, type_of_result2$tid);
    fohh = append(fohh, scheme$tid);
    fohh = append(fohh, d$type);
    fohh = append(fohh, label$tid);
    fohh = append(fohh, benefit_level$tid);
    fohh = append(fohh, poverty_mean_tested$tid);
    fohh = append(fohh, parameters$special_cov);
    fohh = append(fohh, parameters$pension_tested);
    fohh = append(fohh, round(d$ind6_value,1));
    formatted_hhtype6[counter, ] <- fohh;

    counter <- counter+1
  }
  # write.csv(formatted_hhtype2, "./csv_output/formatted_ind2.csv")
  # write.csv(formatted_hhtype6, "./csv_output/formatted_ind6.csv")

  # write.csv(hhtype, "./csv_output/hhtypedata.csv")

  fdata = rbind(formatted_hhtype2,formatted_hhtype6);

  # http_post(API_ENDPOINT,fdata,API_BASE_URL,KEY)
  if (ind_id == '40002') {
    return(formatted_hhtype2)
  } else if (ind_id == '40006') {
    return(formatted_hhtype6)
  } else {
    return(fdata);
  }
}

format_cost_data_ind3 <- function(data, parameters) {
  formatted_ind3 = data.frame(parameter = character(),
                                country = character(),
                                indicator = character(),
                                type_of_result = character(),
                                scheme = character(),
                                value_type = character(),
                                label = character(),
                                benefit_level = character(),
                                poverty_mean_tested = character(),
                                special_cov = logical(),
                                pension_tested = logical(),
                                value = numeric(),
                                stringsAsFactors = FALSE)

  countryT = filter(countries, name == input$country)
  type_of_result = filter(types_of_result, name == "Coverage")
  if (!is.null(parameters$scheme_id)) {
    scheme <- list()
    scheme[['tid']] <- parameters$scheme_id
  } else {
    scheme = filter(schemes, name == parameters$scheme)
  }
  benefit_level = filter(benefit_levels, name == parameters$benefit_level)
  poverty_mean_tested = filter(poverty_mean_tested_tax, name == parameters$poverty_mean_tested)
  vtype1 = filter(value_types, name == "With existing schemes")
  vtype2 = filter(value_types, name == "Post reform")
  vtype3 = filter(value_types, name == "Change (%)")
  ind_id = '40003'

  if (scheme$tid == "70001") {
    weight2 <- data$weight_children
    namel <- paste0("Among children")
    toptab = "childA"
  } else if (scheme$tid == "70002") {
    weight2 <- data$weight_disab
    namel <- paste0("Among persons with disabilities")
    toptab = "disabA"
  } else if (scheme$tid == "70003") {
    weight2 <- data$weight_elderly
    namel <- paste0("Among older persons")
    toptab = "oldA"
  } else if (scheme$tid == "70004") {
    weight2 <- data$weight_mat
    namel <- paste0("Among mothers of newborns")
    toptab = "matA"
  } else {
    weight2 <- data$weight
    toptab = "A"
  }
  # print(toptab)
  
  colnames(data)[which(names(data) == "current_motherA")] <- "current_matA"
  
  data$current_A <- pmax(data$current_B, data$current_matA, data$current_childA, data$current_disabA, data$current_oldA)

  # print(data[[paste0("current_", toptab)]])
  # print(data$weight)
  before1 <-
    weighted.mean(data[[paste0("current_", toptab)]], data$weight)
  before1 <- before1*100
  after1 <-
    weighted.mean(data[[paste0("cov_", toptab)]], data$weight)

  if (before1==0) {
    reduction1 <- NaN
  } else {
    reduction1 <- (after1 - before1 ) * 100 / before1
  }

  before2 <-
    weighted.mean(data[[paste0("current_", toptab)]], weight2)
  before2 <- before2*100
  after2 <-
    weighted.mean(data[[paste0("cov_", toptab)]], weight2)

  if (before2==0) {
    reduction2 <- NaN
  } else {
    reduction2 <- (after2 - before2 ) * 100 / before2
  }
  # ### # print(before1)
  # ### # print(after1)
  # ### # print(reduction1)
  # ### # print(before2)
  # ### # print(after2)
  # ### # print(reduction2)
  label = filter(labels, name == as.character("Whole population"))
  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype1$tid);
  fo = append(fo, label$tid);
  fo = append(fo, benefit_level$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, before1);
  # ### # print(fo);
  formatted_ind3[1, ] <- fo;

  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype2$tid);
  fo = append(fo, label$tid);
  fo = append(fo, benefit_level$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, after1);
  # ### # print(fo);
  formatted_ind3[2, ] <- fo;

  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype3$tid);
  fo = append(fo, label$tid);
  fo = append(fo, benefit_level$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, reduction1);
  # ### # print(fo);
  formatted_ind3[3, ] <- fo;

  label = filter(labels, name == as.character(namel))
  # ### # print(labels)
  # ### # print(namel)
  # ### # print(label)
  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype1$tid);
  fo = append(fo, label$tid);
  fo = append(fo, benefit_level$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, before2);
  # ### # print(fo)
  formatted_ind3[4, ] <- fo;

  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype2$tid);
  fo = append(fo, label$tid);
  fo = append(fo, benefit_level$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, after2);
  # ### # print(fo)
  formatted_ind3[5, ] <- fo;

  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype3$tid);
  fo = append(fo, label$tid);
  fo = append(fo, benefit_level$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, reduction2);
  # ### # print(fo)
  formatted_ind3[6, ] <- fo;

  # http_post(API_ENDPOINT,formatted_ind3,API_BASE_URL,KEY)

  # write.csv(formatted_ind3, "./csv_output/formatted_ind3.csv")

  return(formatted_ind3);
}

format_cost_data_ind7n8n9n10 <- function(data, parameters, ind_id) {
  formatted_ind7 = data.frame(parameter = character(),
                              country = character(),
                              indicator = character(),
                              type_of_result = character(),
                              scheme = character(),
                              value_type = character(),
                              label = character(),
                              benefit_level = character(),
                              poverty_mean_tested = character(),
                              special_cov = logical(),
                              pension_tested = logical(),
                              value = numeric(),
                              stringsAsFactors = FALSE)
  # print(parameters)
  # print(input)
  countryT = filter(countries, name == input$country)
  type_of_result = filter(types_of_result, name == "Poverty and Inequality")
  if (!is.null(parameters$scheme_id)) {
    scheme <- list()
    scheme[['tid']] <- parameters$scheme_id
  } else {
    scheme = filter(schemes, name == parameters$scheme)
  }
  benefit_level = filter(benefit_levels, name == parameters$benefit_level)
  benefit_level2 = filter(benefit_levels, name == "With no schemes")
  benefit_level3 = filter(benefit_levels, name == "With existing schemes")
  poverty_mean_tested = filter(poverty_mean_tested_tax, name == parameters$poverty_mean_tested)
  vtype1 = filter(value_types, name == "With no schemes")
  vtype2 = filter(value_types, name == parameters$benefit_level)
  vtype3 = filter(value_types, name == "With existing schemes")
  # ind_id = '40007'

  if (scheme$tid == "70001") {
    toptab = "childA"
  } else if (scheme$tid == "70002") {
    toptab = "disabA"
  } else if (scheme$tid == "70003") {
    toptab = "oldA"
  } else if (scheme$tid == "70004") {
    toptab = "matA"
  } else {
    weight2 <- data$weight
    toptab = "A"
  }

  # print(toptab)
  # print(ind_id)
  # # print(data[[paste0("current_", toptab)]])
  # # print(data$weight)
  if (ind_id == '40008' | ind_id == '40010') {
    is.na(data[[paste0("transfer_", toptab)]]) <-
      data[[paste0("transfer_", toptab)]] == 0
    data <- data[!is.na(data[[paste0("transfer_", toptab)]]),]
  }

  if (ind_id == '40009' | ind_id == '40010') {
    # print('9_10')
    # print(ind_id)
    current1 <-
      weighted.mean(data$gap, data$weight )
    before1 <-
      weighted.mean(data[[paste0("pre_gap_", toptab)]], data$weight )
    after1 <-
      weighted.mean(data[[paste0("post_gap_", toptab)]], data$weight )
    reduction1 <- (current1 - after1) * 100 / current1

    current2 <-
      weighted.mean(data$gapI1, data$weight )
    before2 <-
      weighted.mean(data[[paste0("pre_gapI1_", toptab)]], data$weight )
    after2 <-
      weighted.mean(data[[paste0("post_gapI1_", toptab)]], data$weight )
    reduction2 <- (current2 - after2) * 100 / current2

    current3 <-
      weighted.mean(data$gapI2, data$weight )
    before3 <-
      weighted.mean(data[[paste0("pre_gapI2_", toptab)]], data$weight )
    after3 <-
      weighted.mean(data[[paste0("post_gapI2_", toptab)]], data$weight )
    reduction3 <- (current3 - after3) * 100 / current3

    current4 <-
      weighted.mean(data$gapI3, data$weight )
    before4 <-
      weighted.mean(data[[paste0("pre_gapI3_", toptab)]], data$weight )
    after4 <-
      weighted.mean(data[[paste0("post_gapI3_", toptab)]], data$weight )
    reduction4 <- (current4 - after4) * 100 / current4
  } else {
    # print('not_9_10')
    # print(ind_id)
    current1 <-
      weighted.mean(data$pov, data$weight )
    before1 <-
      weighted.mean(data[[paste0("pre_pov_", toptab)]], data$weight )
    after1 <-
      weighted.mean(data[[paste0("post_pov_", toptab)]], data$weight )
    # print(after1)
    reduction1 <- (current1 - after1) * 100 / current1

    current2 <-
      weighted.mean(data$povI1, data$weight )
    before2 <-
      weighted.mean(data[[paste0("pre_povI1_", toptab)]], data$weight )
    after2 <-
      weighted.mean(data[[paste0("post_povI1_", toptab)]], data$weight )
    # print(after2)
    reduction2 <- (current2 - after2) * 100 / current2

    current3 <-
      weighted.mean(data$povI2, data$weight )
    before3 <-
      weighted.mean(data[[paste0("pre_povI2_", toptab)]], data$weight )
    after3 <-
      weighted.mean(data[[paste0("post_povI2_", toptab)]], data$weight )
    # print(after3)
    reduction3 <- (current3 - after3) * 100 / current3

    current4 <-
      weighted.mean(data$povI3, data$weight )
    before4 <-
      weighted.mean(data[[paste0("pre_povI3_", toptab)]], data$weight )
    after4 <-
      weighted.mean(data[[paste0("post_povI3_", toptab)]], data$weight )
    # print(after4)
    paste(data[[paste0("post_povI3_", toptab)]], data$weight )
    reduction4 <- (current4 - after4) * 100 / current4
  }
  # print(paste(current1, current2, current3, current4))
  # print(paste(before1, before2, before3, before4))
  # print(paste(after1, after2, after3, after4))
  label1 = filter(labels, name == as.character("National"))
  label2 = filter(labels, name == as.character("International (PPP $1.9)"))
  label3 = filter(labels, name == as.character("International (PPP $3.2)"))
  label4 = filter(labels, name == as.character("International (PPP $5.5)"))

  # if (parameters$id == 5 | parameters$id == 6 | parameters$id == 7 | parameters$id == 11) {

  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype1$tid);
  fo = append(fo, label1$tid);
  fo = append(fo, benefit_level2$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, round(before1,2));
  formatted_ind7[1, ] <- fo;

  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype1$tid);
  fo = append(fo, label2$tid);
  fo = append(fo, benefit_level2$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, round(before2,2));
  formatted_ind7[2, ] <- fo;

  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype1$tid);
  fo = append(fo, label3$tid);
  fo = append(fo, benefit_level2$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, round(before3,2));
  formatted_ind7[3, ] <- fo;

  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype1$tid);
  fo = append(fo, label4$tid);
  fo = append(fo, benefit_level2$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, round(before4,2));
  formatted_ind7[4, ] <- fo;

  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype2$tid);
  fo = append(fo, label1$tid);
  fo = append(fo, benefit_level$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, round(after1,2));
  formatted_ind7[5, ] <- fo;

  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype2$tid);
  fo = append(fo, label2$tid);
  fo = append(fo, benefit_level$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, round(after2,2));
  formatted_ind7[6, ] <- fo;

  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype2$tid);
  fo = append(fo, label3$tid);
  fo = append(fo, benefit_level$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, round(after3,2));
  formatted_ind7[7, ] <- fo;

  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype2$tid);
  fo = append(fo, label4$tid);
  fo = append(fo, benefit_level$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, round(after4,2));
  formatted_ind7[8, ] <- fo;

  if ((!is.nan(before1) && !is.nan(current1) && before1 != current1) | (!is.nan(before2) && !is.nan(current2) && before2 != current2) | (!is.nan(before3) && !is.nan(current3) && before3 != current3) | (!is.nan(before4) && !is.nan(current4) && before4 != current4)) {
    fo = c();
    fo = append(fo, parameters$id);
    fo = append(fo, countryT$tid);
    fo = append(fo, ind_id);
    fo = append(fo, type_of_result$tid);
    fo = append(fo, scheme$tid);
    fo = append(fo, vtype3$tid);
    fo = append(fo, label1$tid);
    fo = append(fo, benefit_level3$tid);
    fo = append(fo, poverty_mean_tested$tid);
    fo = append(fo, parameters$special_cov);
    fo = append(fo, parameters$pension_tested);
    fo = append(fo, round(current1,2));
    formatted_ind7[9, ] <- fo;

    fo = c();
    fo = append(fo, parameters$id);
    fo = append(fo, countryT$tid);
    fo = append(fo, ind_id);
    fo = append(fo, type_of_result$tid);
    fo = append(fo, scheme$tid);
    fo = append(fo, vtype3$tid);
    fo = append(fo, label2$tid);
    fo = append(fo, benefit_level3$tid);
    fo = append(fo, poverty_mean_tested$tid);
    fo = append(fo, parameters$special_cov);
    fo = append(fo, parameters$pension_tested);
    fo = append(fo, round(current2,2));
    formatted_ind7[10, ] <- fo;

    fo = c();
    fo = append(fo, parameters$id);
    fo = append(fo, countryT$tid);
    fo = append(fo, ind_id);
    fo = append(fo, type_of_result$tid);
    fo = append(fo, scheme$tid);
    fo = append(fo, vtype3$tid);
    fo = append(fo, label3$tid);
    fo = append(fo, benefit_level3$tid);
    fo = append(fo, poverty_mean_tested$tid);
    fo = append(fo, parameters$special_cov);
    fo = append(fo, parameters$pension_tested);
    fo = append(fo, round(current3,2));
    formatted_ind7[11, ] <- fo;

    fo = c();
    fo = append(fo, parameters$id);
    fo = append(fo, countryT$tid);
    fo = append(fo, ind_id);
    fo = append(fo, type_of_result$tid);
    fo = append(fo, scheme$tid);
    fo = append(fo, vtype3$tid);
    fo = append(fo, label4$tid);
    fo = append(fo, benefit_level3$tid);
    fo = append(fo, poverty_mean_tested$tid);
    fo = append(fo, parameters$special_cov);
    fo = append(fo, parameters$pension_tested);
    fo = append(fo, round(current4,2));
    formatted_ind7[12, ] <- fo;
  }

  if (ind_id == '40008') {
    # write.csv(formatted_ind7, "./csv_output/formatted_ind8.csv")
  } else if (ind_id == '40009') {
    # write.csv(formatted_ind7, "./csv_output/formatted_ind9.csv")
  } else if (ind_id == '40010') {
    # write.csv(formatted_ind7, "./csv_output/formatted_ind10.csv")
  } else {
    # write.csv(formatted_ind7, "./csv_output/formatted_ind7.csv")
  }

  # http_post(API_ENDPOINT,formatted_ind7,API_BASE_URL,KEY)
  return(formatted_ind7);
}

format_cost_data_ind11 <- function(data, parameters) {
  formatted_ind7 = data.frame(parameter = character(),
                              country = character(),
                              indicator = character(),
                              type_of_result = character(),
                              scheme = character(),
                              value_type = character(),
                              label = character(),
                              benefit_level = character(),
                              poverty_mean_tested = character(),
                              special_cov = logical(),
                              pension_tested = logical(),
                              value = numeric(),
                              stringsAsFactors = FALSE)

  countryT = filter(countries, name == input$country)
  type_of_result = filter(types_of_result, name == "Poverty and Inequality")
  if (!is.null(parameters$scheme_id)) {
    scheme <- list()
    scheme[['tid']] <- parameters$scheme_id
  } else {
    scheme = filter(schemes, name == parameters$scheme)
  }
  benefit_level = filter(benefit_levels, name == parameters$benefit_level)
  benefit_level2 = filter(benefit_levels, name == "With no schemes")
  benefit_level3 = filter(benefit_levels, name == "With existing schemes")
  poverty_mean_tested = filter(poverty_mean_tested_tax, name == parameters$poverty_mean_tested)
  vtype1 = filter(value_types, name == "With no schemes")
  vtype2 = filter(value_types, name == parameters$benefit_level)
  vtype3 = filter(value_types, name == "With existing schemes")
  ind_id = '40011'

  if (scheme$tid == "70001") {
    toptab = "childA"
  } else if (scheme$tid == "70002") {
    toptab = "disabA"
  } else if (scheme$tid == "70003") {
    toptab = "oldA"
  } else if (scheme$tid == "70004") {
    toptab = "matA"
  } else {
    weight2 <- data$weight
    toptab = "A"
  }
  # ### # print(data[[paste0("current_", toptab)]])
  # ### # print(data$weight)

  check <- sum(data[[paste0("cov_", toptab)]])

  if (check>0) {
    data$after <-
      data$adj_welfare - data[[paste0("value_", toptab)]] + data[[paste0("transfer_", toptab)]]
  } else {
    data$after <-
      data$adj_welfare
  }

  data$before <-
    data$adj_welfare - data[[paste0("value_", toptab)]]

  data$weight_pop <- data$weight

  current1 <- gini(data$adj_welfare, data$weight_pop)
  before1 <- gini(data$before, data$weight_pop)
  after1 <- gini(data$after, data$weight_pop)
  reduction1 <- (current1 - after1) * 100 / current1

  #palma ratio
  current2 <- palmaratio(data$adj_welfare, data$weight_pop)
  before2 <- palmaratio(data$before, data$weight_pop)
  after2 <- palmaratio(data$after, data$weight_pop)
  reduction2 <- (current2 - after2) * 100 / current2

  #20:20 ratio
  current3 <-
    quintileratio(data$adj_welfare, data$weight_pop)
  before3 <- quintileratio(data$before, data$weight_pop)
  after3 <- quintileratio(data$after, data$weight_pop)
  reduction3 <- (current3 - after3) * 100 / current3

  label1 = filter(labels, name == as.character("Gini index"))
  label2 = filter(labels, name == as.character("Palma ratio"))
  label3 = filter(labels, name == as.character("Quintile Ratio"))

  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype1$tid);
  fo = append(fo, label1$tid);
  fo = append(fo, benefit_level2$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, round(before1,3));
  formatted_ind7[1, ] <- fo;

  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype1$tid);
  fo = append(fo, label2$tid);
  fo = append(fo, benefit_level2$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, round(before2,3));
  formatted_ind7[2, ] <- fo;

  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype1$tid);
  fo = append(fo, label3$tid);
  fo = append(fo, benefit_level2$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, round(before3,3));
  formatted_ind7[3, ] <- fo;

  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype2$tid);
  fo = append(fo, label1$tid);
  fo = append(fo, benefit_level$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, round(after1,3));
  formatted_ind7[4, ] <- fo;

  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype2$tid);
  fo = append(fo, label2$tid);
  fo = append(fo, benefit_level$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, round(after2,3));
  formatted_ind7[5, ] <- fo;

  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype2$tid);
  fo = append(fo, label3$tid);
  fo = append(fo, benefit_level$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, round(after3,3));
  formatted_ind7[6, ] <- fo;

  if ((!is.nan(before1) && !is.nan(current1) && before1 != current1) | (!is.nan(before2) && !is.nan(current2) && before2 != current2) | (!is.nan(before3) && !is.nan(current3) && before3 != current3)) {
    fo = c();
    fo = append(fo, parameters$id);
    fo = append(fo, countryT$tid);
    fo = append(fo, ind_id);
    fo = append(fo, type_of_result$tid);
    fo = append(fo, scheme$tid);
    fo = append(fo, vtype3$tid);
    fo = append(fo, label1$tid);
    fo = append(fo, benefit_level3$tid);
    fo = append(fo, poverty_mean_tested$tid);
    fo = append(fo, parameters$special_cov);
    fo = append(fo, parameters$pension_tested);
    fo = append(fo, round(current1,3));
    formatted_ind7[7, ] <- fo;

    fo = c();
    fo = append(fo, parameters$id);
    fo = append(fo, countryT$tid);
    fo = append(fo, ind_id);
    fo = append(fo, type_of_result$tid);
    fo = append(fo, scheme$tid);
    fo = append(fo, vtype3$tid);
    fo = append(fo, label2$tid);
    fo = append(fo, benefit_level3$tid);
    fo = append(fo, poverty_mean_tested$tid);
    fo = append(fo, parameters$special_cov);
    fo = append(fo, parameters$pension_tested);
    fo = append(fo, round(current2,3));
    formatted_ind7[8, ] <- fo;

    fo = c();
    fo = append(fo, parameters$id);
    fo = append(fo, countryT$tid);
    fo = append(fo, ind_id);
    fo = append(fo, type_of_result$tid);
    fo = append(fo, scheme$tid);
    fo = append(fo, vtype3$tid);
    fo = append(fo, label3$tid);
    fo = append(fo, benefit_level3$tid);
    fo = append(fo, poverty_mean_tested$tid);
    fo = append(fo, parameters$special_cov);
    fo = append(fo, parameters$pension_tested);
    fo = append(fo, round(current3,3));
    formatted_ind7[9, ] <- fo;
  }

  # write.csv(formatted_ind7, "./csv_output/formatted_ind11.csv")

  # http_post(API_ENDPOINT,formatted_ind7,API_BASE_URL,KEY)
  return(formatted_ind7);
}

format_cost_data_ind12 <- function(data, parameters) {
  formatted_cost12_rec = data.frame(parameter = character(),
                                    country = character(),
                                    indicator = character(),
                                    type_of_result = character(),
                                    scheme = character(),
                                    value_type = character(),
                                    label = character(),
                                    benefit_level = character(),
                                    poverty_mean_tested = character(),
                                    special_cov = logical(),
                                    pension_tested = logical(),
                                    value = numeric(),
                                    stringsAsFactors = FALSE)
  formatted_cost12_spe = data.frame(parameter = character(),
                                    country = character(),
                                    indicator = character(),
                                    type_of_result = character(),
                                    scheme = character(),
                                    value_type = character(),
                                    label = character(),
                                    benefit_level = character(),
                                    poverty_mean_tested = character(),
                                    special_cov = logical(),
                                    pension_tested = logical(),
                                    value = numeric(),
                                    stringsAsFactors = FALSE)
  formatted_cost12_spe_per = data.frame(parameter = character(),
                                        country = character(),
                                        indicator = character(),
                                        type_of_result = character(),
                                        scheme = character(),
                                        value_type = character(),
                                        label = character(),
                                        benefit_level = character(),
                                        poverty_mean_tested = character(),
                                        special_cov = logical(),
                                        pension_tested = logical(),
                                        value = numeric(),
                                        stringsAsFactors = FALSE)

  countryT = filter(countries, name == input$country)
  type_of_result = filter(types_of_result, name == "Costs")
  if (!is.null(parameters$scheme_id)) {
    scheme <- list()
    scheme[['tid']] <- parameters$scheme_id
  } else {
    scheme = filter(schemes, name == parameters$scheme)
  }
  benefit_level = filter(benefit_levels, name == parameters$benefit_level)
  poverty_mean_tested = filter(poverty_mean_tested_tax, name == parameters$poverty_mean_tested)
  vtype1 = filter(value_types, name == "Recipients (thousands)")
  vtype2 = filter(value_types, name == "Spending (billions)")
  vtype3 = filter(value_types, name == "Spending (percent of GDP)")
  ind_id = '40012'
  counter = 1
  for (i in 1:nrow(data)) {
    # ### # print(deciledata[i,]);
    d = data[i,];
    # ### # print(d);
    label = filter(labels, name == as.character(d$year))
    fo = c();
    fo = append(fo, parameters$id);
    fo = append(fo, countryT$tid);
    fo = append(fo, ind_id);
    fo = append(fo, type_of_result$tid);
    fo = append(fo, scheme$tid);
    fo = append(fo, vtype1$tid);
    fo = append(fo, label$tid);
    fo = append(fo, benefit_level$tid);
    fo = append(fo, poverty_mean_tested$tid);
    fo = append(fo, parameters$special_cov);
    fo = append(fo, parameters$pension_tested);
    fo = append(fo, as.numeric(gsub(",", "", d$recA)));
    # ### # print(fo)
    formatted_cost12_rec[counter, ] <- fo;

    fohh = c();
    fohh = append(fohh, parameters$id);
    fohh = append(fohh, countryT$tid);
    fohh = append(fohh, ind_id);
    fohh = append(fohh, type_of_result$tid);
    fohh = append(fohh, scheme$tid);
    fohh = append(fohh, if(nrow(vtype2) != 0) vtype2$tid else '0');
    fohh = append(fohh, label$tid);
    fohh = append(fohh, benefit_level$tid);
    fohh = append(fohh, poverty_mean_tested$tid);
    fohh = append(fohh, parameters$special_cov);
    fohh = append(fohh, parameters$pension_tested);
    fohh = append(fohh, round(d$costsA,2));
    # ### # print(fohh)
    formatted_cost12_spe[counter, ] <- fohh;

    fohh2 = c();
    fohh2 = append(fohh2, parameters$id);
    fohh2 = append(fohh2, countryT$tid);
    fohh2 = append(fohh2, ind_id);
    fohh2 = append(fohh2, type_of_result$tid);
    fohh2 = append(fohh2, scheme$tid);
    fohh2 = append(fohh2, vtype3$tid);
    fohh2 = append(fohh2, label$tid);
    fohh2 = append(fohh2, benefit_level$tid);
    fohh2 = append(fohh2, poverty_mean_tested$tid);
    fohh2 = append(fohh2, parameters$special_cov);
    fohh2 = append(fohh2, parameters$pension_tested);
    fohh2 = append(fohh2, round(d$costsA_gdp,2));
    formatted_cost12_spe_per[counter, ] <- fohh2;

    counter <- counter+1

  }
  formatted_data = rbind(formatted_cost12_rec, formatted_cost12_spe, formatted_cost12_spe_per);
  # write.csv(formatted_data, "./csv_output/formatted_cost12.csv")
  # http_post(API_ENDPOINT,formatted_data,API_BASE_URL,KEY)
  # write.csv(data, "./csv_output/costdata.csv")

  return(formatted_data);
}

format_cost_data_ind13 <- function(data, parameters) {
  formatted_cost13 = data.frame(parameter = character(),
                                        country = character(),
                                        indicator = character(),
                                        type_of_result = character(),
                                        scheme = character(),
                                        value_type = character(),
                                        label = character(),
                                        benefit_level = character(),
                                        poverty_mean_tested = character(),
                                        special_cov = logical(),
                                        pension_tested = logical(),
                                        value = numeric(),
                                        stringsAsFactors = FALSE)

  countryT = filter(countries, name == input$country)
  type_of_result = filter(types_of_result, name == "Costs")
  if (!is.null(parameters$scheme_id)) {
    scheme <- list()
    scheme[['tid']] <- parameters$scheme_id
  } else {
    scheme = filter(schemes, name == parameters$scheme)
  }
  benefit_level = filter(benefit_levels, name == parameters$benefit_level)
  poverty_mean_tested = filter(poverty_mean_tested_tax, name == parameters$poverty_mean_tested)
  vtype = filter(value_types, name == "Percentage of government revenue")
  ind_id = '40013'

  counter = 1
  for (i in 1:nrow(data)) {
    # ### # print(deciledata[i,]);
    d = data[i,];
    # ### # print(d);
    label = filter(labels, name == as.character(d$year))
    fo = c();
    fo = append(fo, parameters$id);
    fo = append(fo, countryT$tid);
    fo = append(fo, ind_id);
    fo = append(fo, type_of_result$tid);
    fo = append(fo, scheme$tid);
    fo = append(fo, vtype$tid);
    fo = append(fo, label$tid);
    fo = append(fo, benefit_level$tid);
    fo = append(fo, poverty_mean_tested$tid);
    fo = append(fo, parameters$special_cov);
    fo = append(fo, parameters$pension_tested);
    fo = append(fo, d$cost_rev_A);
    formatted_cost13[counter, ] <- fo;

    counter <- counter+1

  }
  # write.csv(formatted_cost13, "./csv_output/formatted_cost13.csv")

  # http_post(API_ENDPOINT,formatted_cost13,API_BASE_URL,KEY)

  # write.csv(data, "./csv_output/fin_data.csv")

  return(formatted_cost13);
}

format_cost_data_ind14 <- function(data, parameters) {
  formatted_cost14 = data.frame(parameter = character(),
                                country = character(),
                                indicator = character(),
                                type_of_result = character(),
                                scheme = character(),
                                value_type = character(),
                                label = character(),
                                benefit_level = character(),
                                poverty_mean_tested = character(),
                                special_cov = logical(),
                                pension_tested = logical(),
                                value = numeric(),
                                stringsAsFactors = FALSE)

  data <- data[data$year == 2022,]

  if (!is.null(parameters$scheme_id)) {
    scheme <- list()
    scheme[['tid']] <- parameters$scheme_id
  } else {
    scheme = filter(schemes, name == parameters$scheme)
  }

  if (scheme$tid == "70001") {
    toptab = "childA"
  } else if (scheme$tid == "70002") {
    toptab = "disabA"
  } else if (scheme$tid == "70003") {
    toptab = "oldA"
  } else if (scheme$tid == "70004") {
    toptab = "matA"
  } else {
    toptab = "A"
  }
  # ### # print(scheme)
  # ### # print(toptab)
  # ### # print(data)
  costs_gdp <- data[[paste0("costs", toptab, "_gdp")]]

  line <- c(costs_gdp)

  ### # print('cost gdp')
  ### # print(costs_gdp)
  ### # print(line)

  gdp <- econ()$gdp
  gdp <- rep(gdp[1], times = 10)
  expenses <- govfin()
  expenses_gdp <- round(expenses, 2)

  label_names <-
    c(
      "programmes combined",
      "Maternity Benefit",
      "Child Benefit",
      "Disability Benefit",
      "Old Age Benefit",
      "Household Benefit"
    )
  names(label_names) <-
    c("A", "matA", "childA", "disabA", "oldA", "B")

  text <-
    paste0("Costs of ", label_names[[toptab]], " (", costs_gdp, "%)")

  data <- data.frame(
    Categories = c(
      "General public services",
      "Defence",
      "Public order & safety",
      "Economic Affairs",
      "Environment",
      "Housing",
      "Health",
      "Culture",
      "Education",
      "Social Protection"
    ),
    Expenses = c(
      expenses_gdp$gen,
      expenses_gdp$def,
      expenses_gdp$safety,
      expenses_gdp$econ,
      expenses_gdp$envir,
      expenses_gdp$house,
      expenses_gdp$health,
      expenses_gdp$culture,
      expenses_gdp$educ,
      expenses_gdp$socprot
    )
  )

  data$Categories <-
    factor(
      data$Categories,
      levels = c(
        "General public services",
        "Defence",
        "Public order & safety",
        "Economic Affairs",
        "Environment",
        "Housing",
        "Health",
        "Culture",
        "Education",
        "Social Protection"
      )
    )
  data <- data[!is.na(data$Expenses),]

  ### # print(data)

  countryT = filter(countries, name == input$country)
  type_of_result = filter(types_of_result, name == "Costs")
  # if (!is.null(parameters$scheme_id)) {
  #   scheme <- list()
  #   scheme[['tid']] <- parameters$scheme_id
  # } else {
  #   scheme = filter(schemes, name == parameters$scheme)
  # }
  benefit_level = filter(benefit_levels, name == parameters$benefit_level)
  poverty_mean_tested = filter(poverty_mean_tested_tax, name == parameters$poverty_mean_tested)
  vtype = filter(value_types, name == "Expenditure (% of GDP)")
  vtype2 = filter(value_types, name == "Cost of programme(s) (% of GDP)")
  ind_id = '40014'

  counter = 1
  if (nrow(data) > 0) {
  for (i in 1:nrow(data)) {
    # ### # print(deciledata[i,]);
    d = data[i,];
    ### # print(d);
    label = filter(labels, name == as.character(d$Categories))
    fo = c();
    fo = append(fo, parameters$id);
    fo = append(fo, countryT$tid);
    fo = append(fo, ind_id);
    fo = append(fo, type_of_result$tid);
    fo = append(fo, scheme$tid);
    fo = append(fo, vtype$tid);
    fo = append(fo, label$tid);
    fo = append(fo, benefit_level$tid);
    fo = append(fo, poverty_mean_tested$tid);
    fo = append(fo, parameters$special_cov);
    fo = append(fo, parameters$pension_tested);
    fo = append(fo, d$Expenses);
    formatted_cost14[counter, ] <- fo;

    counter <- counter+1

    fo = c();
    fo = append(fo, parameters$id);
    fo = append(fo, countryT$tid);
    fo = append(fo, ind_id);
    fo = append(fo, type_of_result$tid);
    fo = append(fo, scheme$tid);
    fo = append(fo, vtype2$tid);
    fo = append(fo, label$tid);
    fo = append(fo, benefit_level$tid);
    fo = append(fo, poverty_mean_tested$tid);
    fo = append(fo, parameters$special_cov);
    fo = append(fo, parameters$pension_tested);
    fo = append(fo, costs_gdp);
    formatted_cost14[counter, ] <- fo;

    counter <- counter+1
  }
  }
  # write.csv(formatted_cost14, "./csv_output/formatted_cost14.csv")

  # http_post(API_ENDPOINT,formatted_cost14,API_BASE_URL,KEY)

  return(formatted_cost14);
}

format_cost_data_ind15 <- function(data, parameters) {
  formatted_cost15 = data.frame(parameter = character(),
                                country = character(),
                                indicator = character(),
                                type_of_result = character(),
                                scheme = character(),
                                value_type = character(),
                                label = character(),
                                benefit_level = character(),
                                poverty_mean_tested = character(),
                                special_cov = logical(),
                                pension_tested = logical(),
                                value = numeric(),
                                stringsAsFactors = FALSE)

  countryT = filter(countries, name == input$country)
  type_of_result = filter(types_of_result, name == "Costs")
  if (!is.null(parameters$scheme_id)) {
    scheme <- list()
    scheme[['tid']] <- parameters$scheme_id
  } else {
    scheme = filter(schemes, name == parameters$scheme)
  }
  benefit_level = filter(benefit_levels, name == parameters$benefit_level)
  poverty_mean_tested = filter(poverty_mean_tested_tax, name == parameters$poverty_mean_tested)
  vtype = filter(value_types, name == "Value")
  ind_id = '40015'

  if (scheme$tid == "70001") {
    toptab = "childA"
  } else if (scheme$tid == "70002") {
    toptab = "disabA"
  } else if (scheme$tid == "70003") {
    toptab = "oldA"
  } else if (scheme$tid == "70004") {
    toptab = "matA"
  } else {
    toptab = "A"
  }

  # data <- fin_data()
  value <- round(data[[paste0("cost_rev_", toptab)]] * 100 / govfin()$tax_burden, 1)
  # ### # print(paste0(
  #   "An alternative approach would be to raise government revenues by increasing income and corporate taxes. In ",
  #   param$country,
  #   " the highest personal income tax bracket is ",
  #   govfin()$income_t,
  #   " per cent of net income and capital gains, and corporate tax is ",
  #   govfin()$corporate_t,
  #   " per cent of net profits and capital gains.",
  #   " The total cost of the programme(s) as percentage of tax revenue from income, profits and capital gains is ",
  #   value[1],
  #   " per cent. This illustrates how much more tax revenue government would be required to raise to fully fund the initial levels of investments."
  # ))

  label = filter(labels, name == "Highest personal income tax bracket (per cent of net income and capital gains)")
  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype$tid);
  fo = append(fo, label$tid);
  fo = append(fo, benefit_level$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, govfin()$income_t);
  formatted_cost15[1, ] <- fo;

  label = filter(labels, name == "Corporate tax (per cent of net profits and capital gains)")
  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype$tid);
  fo = append(fo, label$tid);
  fo = append(fo, benefit_level$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, govfin()$corporate_t);
  formatted_cost15[2, ] <- fo;

  label = filter(labels, name == "Total cost of the programme(s) as percentage of tax revenue from income, profits and capital gains (per cent)")
  fo = c();
  fo = append(fo, parameters$id);
  fo = append(fo, countryT$tid);
  fo = append(fo, ind_id);
  fo = append(fo, type_of_result$tid);
  fo = append(fo, scheme$tid);
  fo = append(fo, vtype$tid);
  fo = append(fo, label$tid);
  fo = append(fo, benefit_level$tid);
  fo = append(fo, poverty_mean_tested$tid);
  fo = append(fo, parameters$special_cov);
  fo = append(fo, parameters$pension_tested);
  fo = append(fo, value[1]);
  formatted_cost15[3, ] <- fo;

  # write.csv(formatted_cost15, "./csv_output/formatted_cost15.csv")

  # http_post(API_ENDPOINT,formatted_cost15,API_BASE_URL,KEY)

  # write.csv(data, "./csv_output/fin_data.csv")

  return(formatted_cost15);
}