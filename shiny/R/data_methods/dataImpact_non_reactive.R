## Methods for impact data

## functions in this file:
## 1. impact_data
## 2. deciledata
## 3. age5yrsdata
## 4. totaldata
## 5. caption_text

# impact data ####
impact_data <- function() {
  start_time <- Sys.time()
  data <- svydata()
  
  econData <- econ()
  
  data$adj_welfare <- data$adj_welfare*econData$cpi22/econData$cpi_sy
  # identifying eligible persons
  
  data <- data[order(data$pmt),]
  data$rank_matA <- 100 * cumsum(data$weight*(data$newmother==1)) / sum(data$weight*(data$newmother==1))  
  
  data <- data[order(data$pmt),]
  data$rank_childA <- 100 * cumsum(data$weight*(data$age>=input$childageA[1] & data$age<=input$childageA[2])) / sum(data$weight*(data$age>=input$childageA[1] & data$age<=input$childageA[2]))
  data <- data[order(data$pmt),]
  data$rank_disabA <- 100 * cumsum(data$weight*(data$disab==1 & data$age>=input$disabageA[1] & data$age<=input$disabageA[2])) / sum(data$weight*(data$disab==1 & data$age>=input$disabageA[1] & data$age<=input$disabageA[2]))
  data <- data[order(data$pmt),]
  data$rank_oldA <- 100 * cumsum(data$weight*(data$age>=input$oldageA[1] & data$age<=input$oldageA[2])) / sum(data$weight*(data$age>=input$oldageA[1] & data$age<=input$oldageA[2]))
  
  ## maternity benefit
  if (mparam$mat==TRUE) {
    if (mparam$matMeans==TRUE) {
      data$cov_matA <- ((data$newmother==1) & (data$rank_matA <= input$matcovA))*100
      data$transfer_matA <-  (data$cov_matA/100)*input$mattransferA*(input$matlengthA *7/30/ 12)*data$adj_factor / data$hhsize
    } else {
      data$cov_matA <- (data$newmother==1)*100
      data$transfer_matA <- (data$cov_matA/100)* input$mattransferA*(input$matlengthA *7/30/ 12)*data$adj_factor / data$hhsize
    }
  } else {
    data$transfer_matA <- 0
    data$cov_matA <- 0
    
  }
  
  ## child benefit
  if (cparam$child==TRUE) {
    if (cparam$childMeans==TRUE) {
      data$cov_childA <- ((data$age>=input$childageA[1] & data$age<=input$childageA[2]) & (data$rank_childA <= input$childcovA))*100
      data$transfer_childA <-  (data$cov_childA/100)*input$childtransferA *data$adj_factor / data$hhsize
    } else {
      data$cov_childA <- (data$age>=input$childageA[1] & data$age<=input$childageA[2])*100
      data$transfer_childA <- (data$cov_childA/100)* input$childtransferA *data$adj_factor / data$hhsize
    }
  } else {
    data$transfer_childA <- 0
    data$cov_childA <- 0
    
  }
  ## disab benefit
  if (dparam$disab==TRUE) {
    if (dparam$disabMeans==TRUE) {
      data$cov_disabA <- ((data$disab==1) & (data$age>=input$disabageA[1] & data$age<=input$disabageA[2]) & (data$rank_disabA <= input$disabcovA))*100
      data$transfer_disabA <- (data$cov_disabA/100)*input$disabtransferA *data$adj_factor / data$hhsize
    } else {
      data$cov_disabA <- ((data$disab==1) & (data$age>=input$disabageA[1] & data$age<=input$disabageA[2]))*100
      data$transfer_disabA <- (data$cov_disabA/100)* input$disabtransferA *data$adj_factor / data$hhsize
    }
  } else {
    data$cov_disabA <- 0
    data$transfer_disabA <- 0
  }
  ## old age benefit
  if (oparam$old==TRUE) {
    if (oparam$oldPension==TRUE) {
      data <- data[order(data$pmt),]
      data$rank_oldA <- 100 * cumsum(data$weight*(data$pension==0 & data$age>=input$oldageA[1] & data$age<=input$oldageA[2])) / sum(data$weight*(data$pension==0 & data$pension==0 & data$age>=input$oldageA[1] & data$age<=input$oldageA[2]))
      if (oparam$oldMeans==TRUE) {
        data$cov_oldA <- ((data$pension==0) & (data$age>=input$oldageA[1] & data$age<=input$oldageA[2]) & (data$rank_oldA <= input$oldcovA))*100
        data$transfer_oldA <- (data$cov_oldA/100) * input$oldtransferA *data$adj_factor / data$hhsize
      } else {
        data$cov_oldA <- ((data$age>=input$oldageA[1] & data$age<=input$oldageA[2]))*100
        data$transfer_oldA <- (data$cov_oldA/100) * input$oldtransferA *data$adj_factor / data$hhsize
      }
    } else {
      if (oparam$oldMeans==TRUE) {
        data$cov_oldA <- ((data$age>=input$oldageA[1] & data$age<=input$oldageA[2]) & (data$rank_oldA <= input$oldcovA))*100
        data$transfer_oldA <- (data$cov_oldA/100) * input$oldtransferA *data$adj_factor / data$hhsize
      } else {
        data$cov_oldA <- ((data$age>=input$oldageA[1] & data$age<=input$oldageA[2]))*100
        data$transfer_oldA <- (data$cov_oldA/100) * input$oldtransferA *data$adj_factor / data$hhsize
      }
    }
  } else {
    data$cov_oldA <- 0
    data$transfer_oldA <- 0
  }
  ## household benefit
  if (input$meanstested==TRUE) {
    data <- data[order(data$pmt),]
    data$cov_B <- ((100 * cumsum(data$weight) / sum(data$weight)) <= input$hhcovB)*100
    data$transfer_B <- (data$cov_B/100) * input$hhtransferB *data$adj_factor / data$hhsize
  } else {
    data$cov_B <- 0
    data$transfer_B <- 0
  }
  
  data[is.na(data)] <- 0
  
  data <- data %>% group_by(hhid) %>% mutate(cov_matA = max(cov_matA),
                                             cov_childA = max(cov_childA),
                                             cov_disabA = max(cov_disabA),
                                             cov_oldA = max(cov_oldA),
                                             cov_B = max(cov_B),
                                             transfer_matA = sum(transfer_matA),
                                             transfer_childA = sum(transfer_childA),
                                             transfer_disabA = sum(transfer_disabA),
                                             transfer_oldA = sum(transfer_oldA))
  
  
  data$transfer_A <- data$transfer_matA + data$transfer_childA + data$transfer_disabA + data$transfer_oldA + data$transfer_B
  data$cov_A <- (data$transfer_A>0)*100

  colnames(data)[which(names(data) == "value_motherA")] <- "value_matA"
  
  data$value_A <- data$value_matA * (sum(data$transfer_matA) > 0) +
    data$value_childA * (sum(data$transfer_childA) > 0) + 
    data$value_disabA * (sum(data$transfer_disabA) > 0) + 
    data$value_oldA * (sum(data$transfer_oldA) > 0) + 
    data$value_B * (sum(data$transfer_B) > 0)
  
  for (i in c("A", "matA", "childA", "disabA", "oldA", "B")) {
    # data[[paste0("increase_", i)]] <- ((data[[paste0("transfer_", i)]] - data[[paste0("value_", i)]])*(sum(data[[paste0("transfer_", i)]]) > 0) / (data$adj_welfare)) * 100
    data[[paste0("increase_", i)]] <- ((data[[paste0("transfer_", i)]]) / (data$adj_welfare)) * 100
    
  }
  
  #Current national poverty outcomes
  data$pov <- ((data$adj_welfare) < econData$natpline * econData$cpi22/econData$cpi_sy) * 100
  data$gap <- ((econData$natpline * econData$cpi22/econData$cpi_sy - data$adj_welfare) * (data$pov == 100) / (econData$natpline * econData$cpi22/econData$cpi_sy)) * 100
  data$povI1 <- ((data$adj_welfare) / (econData$ppp * econData$cpi22/econData$cpi11) < econData$intpline1) * 100
  data$povI2 <- ((data$adj_welfare) / (econData$ppp * econData$cpi22/econData$cpi11) < econData$intpline2) * 100
  data$povI3 <- ((data$adj_welfare) / (econData$ppp * econData$cpi22/econData$cpi11) < econData$intpline3) * 100
  data$gapI1 <- ((econData$intpline1 - data$adj_welfare / (econData$ppp * econData$cpi22/econData$cpi11)) * (data$povI1 == 100) / econData$intpline1) * 100
  data$gapI2 <- ((econData$intpline2 - data$adj_welfare / (econData$ppp * econData$cpi22/econData$cpi11)) * (data$povI2 == 100) / econData$intpline2) * 100
  data$gapI3 <- ((econData$intpline3 - data$adj_welfare / (econData$ppp * econData$cpi22/econData$cpi11)) * (data$povI3 == 100) / econData$intpline3) * 100
  
  #Baseline and post national poverty outcomes
  for (i in c("A", "matA", "childA", "disabA", "oldA", "B")) {
    check1 <- sum(data[[paste0("value_", i)]])
    check2 <- sum(data[[paste0("cov_", i)]])
    if (check1 > 0) {
      #Baseline 
      data[[paste0("pre_pov_", i)]] <- ((data$adj_welfare - data[[paste0("value_", i)]]) < econData$natpline * econData$cpi22/econData$cpi_sy) * 100
      data[[paste0("pre_gap_", i)]] <- ((econData$natpline * econData$cpi22/econData$cpi_sy - (data$adj_welfare - data[[paste0("value_", i)]])) * (data[[paste0("pre_pov_", i)]] == 100) / (econData$natpline * econData$cpi22/econData$cpi_sy)) * 100
      data[[paste0("pre_povI1_", i)]] <- ((data$adj_welfare - data[[paste0("value_", i)]]) / (econData$ppp * econData$cpi22/econData$cpi11) < econData$intpline1) * 100
      data[[paste0("pre_povI2_", i)]] <- ((data$adj_welfare - data[[paste0("value_", i)]]) / (econData$ppp * econData$cpi22/econData$cpi11) < econData$intpline2) * 100
      data[[paste0("pre_povI3_", i)]] <- ((data$adj_welfare - data[[paste0("value_", i)]]) / (econData$ppp * econData$cpi22/econData$cpi11) < econData$intpline3) * 100
      data[[paste0("pre_gapI1_", i)]] <- ((econData$intpline1 - (data$adj_welfare - data[[paste0("value_", i)]]) / (econData$ppp * econData$cpi22/econData$cpi11)) * (data[[paste0("pre_povI1_", i)]] == 100) / econData$intpline1) * 100
      data[[paste0("pre_gapI2_", i)]] <- ((econData$intpline2 - (data$adj_welfare - data[[paste0("value_", i)]]) / (econData$ppp * econData$cpi22/econData$cpi11)) * (data[[paste0("pre_povI2_", i)]] == 100) / econData$intpline2) * 100
      data[[paste0("pre_gapI3_", i)]] <- ((econData$intpline3 - (data$adj_welfare - data[[paste0("value_", i)]]) / (econData$ppp * econData$cpi22/econData$cpi11)) * (data[[paste0("pre_povI3_", i)]] == 100) / econData$intpline3) * 100
      
      #Post reforms national poverty outcomes
      if (check2 > 0) {
        data[[paste0("post_pov_", i)]] <- ((data$adj_welfare - data[[paste0("value_", i)]] + data[[paste0("transfer_", i)]]) < econData$natpline * econData$cpi22/econData$cpi_sy) * 100
        data[[paste0("post_gap_", i)]] <- ((econData$natpline * econData$cpi22/econData$cpi_sy  - (data$adj_welfare - data[[paste0("value_", i)]] + data[[paste0("transfer_", i)]])) * (data[[paste0("post_pov_", i)]] == 100) / (econData$natpline * econData$cpi22/econData$cpi_sy)) * 100
        data[[paste0("post_povI1_", i)]] <- ((data$adj_welfare - data[[paste0("value_", i)]] + data[[paste0("transfer_", i)]]) / (econData$ppp * econData$cpi22/econData$cpi11) < econData$intpline1) * 100
        data[[paste0("post_povI2_", i)]] <- ((data$adj_welfare - data[[paste0("value_", i)]] + data[[paste0("transfer_", i)]]) / (econData$ppp * econData$cpi22/econData$cpi11) < econData$intpline2) * 100
        data[[paste0("post_povI3_", i)]] <- ((data$adj_welfare - data[[paste0("value_", i)]] + data[[paste0("transfer_", i)]]) / (econData$ppp * econData$cpi22/econData$cpi11) < econData$intpline3) * 100
        data[[paste0("post_gapI1_", i)]] <- ((econData$intpline1 - (data$adj_welfare - data[[paste0("value_", i)]] + data[[paste0("transfer_", i)]]) /(econData$ppp * econData$cpi22/econData$cpi11)) * (data[[paste0("post_povI1_", i)]] == 100) / econData$intpline1) * 100
        data[[paste0("post_gapI2_", i)]] <- ((econData$intpline2 - (data$adj_welfare - data[[paste0("value_", i)]] + data[[paste0("transfer_", i)]]) /(econData$ppp * econData$cpi22/econData$cpi11)) * (data[[paste0("post_povI2_", i)]] == 100) / econData$intpline2) * 100
        data[[paste0("post_gapI3_", i)]] <- ((econData$intpline3 - (data$adj_welfare - data[[paste0("value_", i)]] + data[[paste0("transfer_", i)]]) / (econData$ppp * econData$cpi22/econData$cpi11)) * (data[[paste0("post_povI3_", i)]] == 100) / econData$intpline3) * 100
      } else {
        data[[paste0("post_pov_", i)]] <- data$pov
        data[[paste0("post_gap_", i)]] <- data$gap
        data[[paste0("post_povI1_", i)]] <- data$povI1
        data[[paste0("post_povI2_", i)]] <- data$povI2
        data[[paste0("post_povI3_", i)]] <- data$povI3
        data[[paste0("post_gapI1_", i)]] <- data$gapI1
        data[[paste0("post_gapI2_", i)]] <- data$gapI2
        data[[paste0("post_gapI3_", i)]] <- data$gapI3
      }
    } else {
      #Baseline national poverty outcomes
      data[[paste0("pre_pov_", i)]] <- data$pov
      data[[paste0("pre_gap_", i)]] <- data$gap
      data[[paste0("pre_povI1_", i)]] <- data$povI1
      data[[paste0("pre_povI2_", i)]] <- data$povI2
      data[[paste0("pre_povI3_", i)]] <- data$povI3
      data[[paste0("pre_gapI1_", i)]] <- data$gapI1
      data[[paste0("pre_gapI2_", i)]] <- data$gapI2
      data[[paste0("pre_gapI3_", i)]] <- data$gapI3
      #Post reforms national poverty outcomes
      if (check2 > 0) {
        data[[paste0("post_pov_", i)]] <-  ((data$adj_welfare + data[[paste0("transfer_", i)]]) < econData$natpline * econData$cpi22/econData$cpi_sy) * 100
        data[[paste0("post_gap_", i)]] <- ((econData$natpline * econData$cpi22/econData$cpi_sy - (data$adj_welfare + data[[paste0("transfer_", i)]])) * (data[[paste0("post_pov_", i)]] == 100) / (econData$natpline * econData$cpi22/econData$cpi_sy)) * 100
        data[[paste0("post_povI1_", i)]] <- ((data$adj_welfare + data[[paste0("transfer_", i)]]) / (econData$ppp * econData$cpi22/econData$cpi11) < econData$intpline1) * 100
        data[[paste0("post_povI2_", i)]] <- ((data$adj_welfare + data[[paste0("transfer_", i)]]) / (econData$ppp * econData$cpi22/econData$cpi11) < econData$intpline2) * 100
        data[[paste0("post_povI3_", i)]] <- ((data$adj_welfare + data[[paste0("transfer_", i)]]) / (econData$ppp * econData$cpi22/econData$cpi11) < econData$intpline3) * 100
        data[[paste0("post_gapI1_", i)]] <- ((econData$intpline1 - (data$adj_welfare + data[[paste0("transfer_", i)]]) / (econData$ppp * econData$cpi22/econData$cpi11)) * (data[[paste0("post_povI1_", i)]] == 100) / econData$intpline1) * 100
        data[[paste0("post_gapI2_", i)]] <- ((econData$intpline2 - (data$adj_welfare + data[[paste0("transfer_", i)]]) / (econData$ppp * econData$cpi22/econData$cpi11)) * (data[[paste0("post_povI2_", i)]] == 100) / econData$intpline2) * 100
        data[[paste0("post_gapI3_", i)]] <- ((econData$intpline3 - (data$adj_welfare + data[[paste0("transfer_", i)]]) / (econData$ppp * econData$cpi22/econData$cpi11)) * (data[[paste0("post_povI3_", i)]] == 100) / econData$intpline3) * 100
      } else {
        data[[paste0("post_pov_", i)]] <- data$pov
        data[[paste0("post_gap_", i)]] <- data$gap
        data[[paste0("post_povI1_", i)]] <- data$povI1
        data[[paste0("post_povI2_", i)]] <- data$povI2
        data[[paste0("post_povI3_", i)]] <- data$povI3
        data[[paste0("post_gapI1_", i)]] <- data$gapI1
        data[[paste0("post_gapI2_", i)]] <- data$gapI2
        data[[paste0("post_gapI3_", i)]] <- data$gapI3
      }
    }
  }    
  
  for (i in c("A", "matA", "childA", "disabA", "oldA", "B")) {
    data[[paste0("wta_", i)]] <- data$weight * data[[paste0("cov_", i)]]
  }
  
  data$weight_mat <- data$weight * (data$newmother==1)
  data$weight_children <- data$weight * (data$age<=17)
  data$weight_disab <- data$weight * (data$disab==1)
  data$weight_workingage <- data$weight * (data$age>=18 & data$age<=59)
  data$weight_elderly <- data$weight * (data$age>=65)
  
  if (input$country=="Maldives") {
    data$rural <- 1
  }
  
  end_time <- Sys.time()
  
  print('impact_data processing: ')
  print(end_time - start_time)
  # return(0)
  # write.csv(data, "./csv_output/impactdata.csv")
  return(data)
}

# summary data
deciledata <- function() {
  # print('inside deciledata');
  # print(input$country)
  # print(input$childageA)
  # print(input$childcovA)
  # print(input$childtransferA)
  # print(input$olageA)
  # print(input$oldcovA)
  # print(input$oldtransferA)
  # print(input$disabageA)
  # print(input$disabcovA)
  # print(input$disabtransferA)
  # print(input)
  
  # input$childtransferA = 27980;
  # replace data with impact_data()
  impactData <- impact_data()
  total <- impactData %>% group_by(decile) %>% summarise(meancov_A = weighted.mean(cov_A, weight), 
                                                         meanexp_A = weighted.mean(increase_A,weight),
                                                         meanbenexp_A = weighted.mean(increase_A,wta_A),
                                                         
                                                         meancov_matA = weighted.mean(cov_matA, weight), 
                                                         meancovint_matA = weighted.mean(cov_matA, weight_mat),
                                                         meanexp_matA = weighted.mean(increase_matA,weight),
                                                         meanexpint_matA = weighted.mean(increase_matA, weight_mat),
                                                         meanbenexp_matA = weighted.mean(increase_matA,wta_matA),
                                                         
                                                         meancov_childA = weighted.mean(cov_childA, weight), 
                                                         meancovint_childA = weighted.mean(cov_childA, weight_children),
                                                         meanexp_childA = weighted.mean(increase_childA,weight),
                                                         meanexpint_childA = weighted.mean(increase_childA, weight_children),
                                                         meanbenexp_childA = weighted.mean(increase_childA,wta_childA),
                                                         
                                                         meancov_disabA = weighted.mean(cov_disabA, weight), 
                                                         meancovint_disabA = weighted.mean(cov_disabA, weight_disab),
                                                         meanexp_disabA = weighted.mean(increase_disabA,weight),
                                                         meanexpint_disabA = weighted.mean(increase_disabA, weight_disab),
                                                         meanbenexp_disabA = weighted.mean(increase_disabA,wta_disabA),
                                                         
                                                         meancov_oldA = weighted.mean(cov_oldA, weight), 
                                                         meancovint_oldA = weighted.mean(cov_oldA, weight_elderly),
                                                         meanexp_oldA = weighted.mean(increase_oldA,weight),
                                                         meanexpint_oldA = weighted.mean(increase_oldA, weight_elderly),
                                                         meanbenexp_oldA = weighted.mean(increase_oldA,wta_oldA),
                                                         
                                                         meancov_B = weighted.mean(cov_B, weight),
                                                         meancovint_B = weighted.mean(cov_B, wta_B), 
                                                         meanexp_B = weighted.mean(increase_B,weight),
                                                         meanexpint_B = weighted.mean(increase_B, wta_B),
                                                         meanbenexp_B = weighted.mean(increase_B,wta_B))
  total$female_head <- 2
  total$rural <- 2
  # print(total)
  female_head <- impactData %>% group_by(decile, female_head) %>% summarise(meancov_A = weighted.mean(cov_A, weight), 
                                                                            meanexp_A = weighted.mean(increase_A,weight),
                                                                            meanbenexp_A = weighted.mean(increase_A,wta_A),
                                                                            
                                                                            meancov_matA = weighted.mean(cov_matA, weight), 
                                                                            meancovint_matA = weighted.mean(cov_matA, weight_mat),
                                                                            meanexp_matA = weighted.mean(increase_matA,weight),
                                                                            meanexpint_matA = weighted.mean(increase_matA, weight_mat),
                                                                            meanbenexp_matA = weighted.mean(increase_matA,wta_matA),
                                                                            
                                                                            meancov_childA = weighted.mean(cov_childA, weight), 
                                                                            meancovint_childA = weighted.mean(cov_childA, weight_children),
                                                                            meanexp_childA = weighted.mean(increase_childA,weight),
                                                                            meanexpint_childA = weighted.mean(increase_childA, weight_children),
                                                                            meanbenexp_childA = weighted.mean(increase_childA,wta_childA),
                                                                            
                                                                            meancov_disabA = weighted.mean(cov_disabA, weight), 
                                                                            meancovint_disabA = weighted.mean(cov_disabA, weight_disab),
                                                                            meanexp_disabA = weighted.mean(increase_disabA,weight),
                                                                            meanexpint_disabA = weighted.mean(increase_disabA, weight_disab),
                                                                            meanbenexp_disabA = weighted.mean(increase_disabA,wta_disabA),
                                                                            
                                                                            meancov_oldA = weighted.mean(cov_oldA, weight), 
                                                                            meancovint_oldA = weighted.mean(cov_oldA, weight_elderly),
                                                                            meanexp_oldA = weighted.mean(increase_oldA,weight),
                                                                            meanexpint_oldA = weighted.mean(increase_oldA, weight_elderly),
                                                                            meanbenexp_oldA = weighted.mean(increase_oldA,wta_oldA),
                                                                            
                                                                            meancov_B = weighted.mean(cov_B, weight),
                                                                            meancovint_B = weighted.mean(cov_B, wta_B), 
                                                                            meanexp_B = weighted.mean(increase_B,weight),
                                                                            meanexpint_B = weighted.mean(increase_B, wta_B),
                                                                            meanbenexp_B = weighted.mean(increase_B,wta_B))
  
  rural <- impactData %>% group_by(decile, rural) %>% summarise(meancov_A = weighted.mean(cov_A, weight), 
                                                                meanexp_A = weighted.mean(increase_A,weight),
                                                                meanbenexp_A = weighted.mean(increase_A,wta_A),
                                                                
                                                                meancov_matA = weighted.mean(cov_matA, weight), 
                                                                meancovint_matA = weighted.mean(cov_matA, weight_mat),
                                                                meanexp_matA = weighted.mean(increase_matA,weight),
                                                                meanexpint_matA = weighted.mean(increase_matA, weight_mat),
                                                                meanbenexp_matA = weighted.mean(increase_matA,wta_matA),
                                                                
                                                                meancov_childA = weighted.mean(cov_childA, weight), 
                                                                meancovint_childA = weighted.mean(cov_childA, weight_children),
                                                                meanexp_childA = weighted.mean(increase_childA,weight),
                                                                meanexpint_childA = weighted.mean(increase_childA, weight_children),
                                                                meanbenexp_childA = weighted.mean(increase_childA,wta_childA),
                                                                
                                                                meancov_disabA = weighted.mean(cov_disabA, weight), 
                                                                meancovint_disabA = weighted.mean(cov_disabA, weight_disab),
                                                                meanexp_disabA = weighted.mean(increase_disabA,weight),
                                                                meanexpint_disabA = weighted.mean(increase_disabA, weight_disab),
                                                                meanbenexp_disabA = weighted.mean(increase_disabA,wta_disabA),
                                                                
                                                                meancov_oldA = weighted.mean(cov_oldA, weight), 
                                                                meancovint_oldA = weighted.mean(cov_oldA, weight_elderly),
                                                                meanexp_oldA = weighted.mean(increase_oldA,weight),
                                                                meanexpint_oldA = weighted.mean(increase_oldA, weight_elderly),
                                                                meanbenexp_oldA = weighted.mean(increase_oldA,wta_oldA),
                                                                
                                                                meancov_B = weighted.mean(cov_B, weight),
                                                                meancovint_B = weighted.mean(cov_B, wta_B), 
                                                                meanexp_B = weighted.mean(increase_B,weight),
                                                                meanexpint_B = weighted.mean(increase_B, wta_B),
                                                                meanbenexp_B = weighted.mean(increase_B,wta_B))
  
  deciledata <- bind_rows(total, female_head, rural)
  # print(deciledata)
  return(deciledata)
}

age5yrsdata <- function() {
  # replace data with impact_data()
  impactData <- impact_data()
  total <- impactData %>% group_by(age5yrs) %>% summarise(meanpov = weighted.mean(pov,weight),
                                                          meangap = weighted.mean(gap,weight),
                                                          meancov_A = weighted.mean(cov_A, weight), 
                                                          meanpov_A = weighted.mean(post_pov_A,weight),
                                                          meangap_A = weighted.mean(post_gap_A,weight),
                                                          
                                                          meanbenpov_A = weighted.mean(pov,wta_A),
                                                          meanbengap_A = weighted.mean(gap,wta_A),
                                                          meanbenexp_A = weighted.mean(increase_A,wta_A),
                                                          meanbenpostpov_A = weighted.mean(post_pov_A,wta_A),
                                                          meanbenpostgap_A = weighted.mean(post_gap_A,wta_A),
                                                          
                                                          meancov_matA = weighted.mean(cov_matA, weight), 
                                                          meanpov_matA = weighted.mean(post_pov_matA,weight),
                                                          meangap_matA = weighted.mean(post_gap_matA,weight),
                                                          meanbenpov_matA = weighted.mean(pov,wta_matA),
                                                          meanbengap_matA = weighted.mean(gap,wta_matA),
                                                          meanbenexp_matA = weighted.mean(increase_matA,wta_matA),
                                                          meanbenpostpov_matA = weighted.mean(post_pov_matA,wta_matA),
                                                          meanbenpostgap_matA = weighted.mean(post_gap_matA,wta_matA),
                                                          
                                                          meancov_childA = weighted.mean(cov_childA, weight), 
                                                          meanpov_childA = weighted.mean(post_pov_childA,weight),
                                                          meangap_childA = weighted.mean(post_gap_childA,weight),
                                                          meanbenpov_childA = weighted.mean(pov,wta_childA),
                                                          meanbengap_childA = weighted.mean(gap,wta_childA),
                                                          meanbenexp_childA = weighted.mean(increase_childA,wta_childA),
                                                          meanbenpostpov_childA = weighted.mean(post_pov_childA,wta_childA),
                                                          meanbenpostgap_childA = weighted.mean(post_gap_childA,wta_childA),
                                                          
                                                          meancov_disabA = weighted.mean(cov_disabA, weight), 
                                                          meanpov_disabA = weighted.mean(post_pov_disabA,weight),
                                                          meangap_disabA = weighted.mean(post_gap_disabA,weight),
                                                          meanbenpov_disabA = weighted.mean(pov,wta_disabA),
                                                          meanbengap_disabA = weighted.mean(gap,wta_disabA),
                                                          meanbenexp_disabA = weighted.mean(increase_disabA,wta_disabA),
                                                          meanbenpostpov_disabA = weighted.mean(post_pov_disabA,wta_disabA),
                                                          meanbenpostgap_disabA = weighted.mean(post_gap_disabA,wta_disabA),
                                                          
                                                          meancov_oldA = weighted.mean(cov_oldA, weight), 
                                                          meanpov_oldA = weighted.mean(post_pov_oldA,weight),
                                                          meangap_oldA = weighted.mean(post_gap_oldA,weight),
                                                          meanbenpov_oldA = weighted.mean(pov,wta_oldA),
                                                          meanbengap_oldA = weighted.mean(gap,wta_oldA),
                                                          meanbenexp_oldA = weighted.mean(increase_oldA,wta_oldA),
                                                          meanbenpostpov_oldAA = weighted.mean(post_pov_oldA,wta_oldA),
                                                          meanbenpostgap_oldA = weighted.mean(post_gap_oldA,wta_oldA),
                                                          meancov_B = weighted.mean(cov_B, weight), 
                                                          meanpov_B = weighted.mean(post_pov_B,weight),
                                                          meangap_B = weighted.mean(post_gap_B,weight),
                                                          meanbenpov_B = weighted.mean(pov,wta_B),
                                                          meanbengap_B = weighted.mean(gap,wta_B),
                                                          meanbenexp_B = weighted.mean(increase_B,wta_B),
                                                          meanbenpostpov_B = weighted.mean(post_pov_B,wta_B),
                                                          meanbenpostgap_B = weighted.mean(post_gap_B,wta_B))
  total$female_head <- 2
  total$rural <- 2
  female_head <- impactData %>% group_by(age5yrs, female_head) %>% summarise(meanpov = weighted.mean(pov,weight),
                                                                             meangap = weighted.mean(gap,weight),
                                                                             meancov_A = weighted.mean(cov_A, weight), 
                                                                             meanpov_A = weighted.mean(post_pov_A,weight),
                                                                             meangap_A = weighted.mean(post_gap_A,weight),
                                                                             
                                                                             meanbenpov_A = weighted.mean(pov,wta_A),
                                                                             meanbengap_A = weighted.mean(gap,wta_A),
                                                                             meanbenexp_A = weighted.mean(increase_A,wta_A),
                                                                             meanbenpostpov_A = weighted.mean(post_pov_A,wta_A),
                                                                             meanbenpostgap_A = weighted.mean(post_gap_A,wta_A),
                                                                             
                                                                             meancov_matA = weighted.mean(cov_matA, weight), 
                                                                             meanpov_matA = weighted.mean(post_pov_matA,weight),
                                                                             meangap_matA = weighted.mean(post_gap_matA,weight),
                                                                             meanbenpov_matA = weighted.mean(pov,wta_matA),
                                                                             meanbengap_matA = weighted.mean(gap,wta_matA),
                                                                             meanbenexp_matA = weighted.mean(increase_matA,wta_matA),
                                                                             meanbenpostpov_matA = weighted.mean(post_pov_matA,wta_matA),
                                                                             meanbenpostgap_matA = weighted.mean(post_gap_matA,wta_matA),
                                                                             
                                                                             meancov_childA = weighted.mean(cov_childA, weight), 
                                                                             meanpov_childA = weighted.mean(post_pov_childA,weight),
                                                                             meangap_childA = weighted.mean(post_gap_childA,weight),
                                                                             meanbenpov_childA = weighted.mean(pov,wta_childA),
                                                                             meanbengap_childA = weighted.mean(gap,wta_childA),
                                                                             meanbenexp_childA = weighted.mean(increase_childA,wta_childA),
                                                                             meanbenpostpov_childA = weighted.mean(post_pov_childA,wta_childA),
                                                                             meanbenpostgap_childA = weighted.mean(post_gap_childA,wta_childA),
                                                                             
                                                                             meancov_disabA = weighted.mean(cov_disabA, weight), 
                                                                             meanpov_disabA = weighted.mean(post_pov_disabA,weight),
                                                                             meangap_disabA = weighted.mean(post_gap_disabA,weight),
                                                                             meanbenpov_disabA = weighted.mean(pov,wta_disabA),
                                                                             meanbengap_disabA = weighted.mean(gap,wta_disabA),
                                                                             meanbenexp_disabA = weighted.mean(increase_disabA,wta_disabA),
                                                                             meanbenpostpov_disabA = weighted.mean(post_pov_disabA,wta_disabA),
                                                                             meanbenpostgap_disabA = weighted.mean(post_gap_disabA,wta_disabA),
                                                                             
                                                                             meancov_oldA = weighted.mean(cov_oldA, weight), 
                                                                             meanpov_oldA = weighted.mean(post_pov_oldA,weight),
                                                                             meangap_oldA = weighted.mean(post_gap_oldA,weight),
                                                                             meanbenpov_oldA = weighted.mean(pov,wta_oldA),
                                                                             meanbengap_oldA = weighted.mean(gap,wta_oldA),
                                                                             meanbenexp_oldA = weighted.mean(increase_oldA,wta_oldA),
                                                                             meanbenpostpov_oldAA = weighted.mean(post_pov_oldA,wta_oldA),
                                                                             meanbenpostgap_oldA = weighted.mean(post_gap_oldA,wta_oldA),
                                                                             
                                                                             meancov_B = weighted.mean(cov_B, weight), 
                                                                             meanpov_B = weighted.mean(post_pov_B,weight),
                                                                             meangap_B = weighted.mean(post_gap_B,weight),
                                                                             meanbenpov_B = weighted.mean(pov,wta_B),
                                                                             meanbengap_B = weighted.mean(gap,wta_B),
                                                                             meanbenexp_B = weighted.mean(increase_B,wta_B),
                                                                             meanbenpostpov_B = weighted.mean(post_pov_B,wta_B),
                                                                             meanbenpostgap_B = weighted.mean(post_gap_B,wta_B))
  
  rural <- impactData %>% group_by(age5yrs, rural) %>% summarise(meanpov = weighted.mean(pov,weight),
                                                                 meangap = weighted.mean(gap,weight),
                                                                 meancov_A = weighted.mean(cov_A, weight), 
                                                                 meanpov_A = weighted.mean(post_pov_A,weight),
                                                                 meangap_A = weighted.mean(post_gap_A,weight),
                                                                 
                                                                 meanbenpov_A = weighted.mean(pov,wta_A),
                                                                 meanbengap_A = weighted.mean(gap,wta_A),
                                                                 meanbenexp_A = weighted.mean(increase_A,wta_A),
                                                                 meanbenpostpov_A = weighted.mean(post_pov_A,wta_A),
                                                                 meanbenpostgap_A = weighted.mean(post_gap_A,wta_A),
                                                                 
                                                                 meancov_matA = weighted.mean(cov_matA, weight), 
                                                                 meanpov_matA = weighted.mean(post_pov_matA,weight),
                                                                 meangap_matA = weighted.mean(post_gap_matA,weight),
                                                                 meanbenpov_matA = weighted.mean(pov,wta_matA),
                                                                 meanbengap_matA = weighted.mean(gap,wta_matA),
                                                                 meanbenexp_matA = weighted.mean(increase_matA,wta_matA),
                                                                 meanbenpostpov_matA = weighted.mean(post_pov_matA,wta_matA),
                                                                 meanbenpostgap_matA = weighted.mean(post_gap_matA,wta_matA),
                                                                 
                                                                 meancov_childA = weighted.mean(cov_childA, weight), 
                                                                 meanpov_childA = weighted.mean(post_pov_childA,weight),
                                                                 meangap_childA = weighted.mean(post_gap_childA,weight),
                                                                 meanbenpov_childA = weighted.mean(pov,wta_childA),
                                                                 meanbengap_childA = weighted.mean(gap,wta_childA),
                                                                 meanbenexp_childA = weighted.mean(increase_childA,wta_childA),
                                                                 meanbenpostpov_childA = weighted.mean(post_pov_childA,wta_childA),
                                                                 meanbenpostgap_childA = weighted.mean(post_gap_childA,wta_childA),
                                                                 
                                                                 meancov_disabA = weighted.mean(cov_disabA, weight), 
                                                                 meanpov_disabA = weighted.mean(post_pov_disabA,weight),
                                                                 meangap_disabA = weighted.mean(post_gap_disabA,weight),
                                                                 meanbenpov_disabA = weighted.mean(pov,wta_disabA),
                                                                 meanbengap_disabA = weighted.mean(gap,wta_disabA),
                                                                 meanbenexp_disabA = weighted.mean(increase_disabA,wta_disabA),
                                                                 meanbenpostpov_disabA = weighted.mean(post_pov_disabA,wta_disabA),
                                                                 meanbenpostgap_disabA = weighted.mean(post_gap_disabA,wta_disabA),
                                                                 
                                                                 meancov_oldA = weighted.mean(cov_oldA, weight), 
                                                                 meanpov_oldA = weighted.mean(post_pov_oldA,weight),
                                                                 meangap_oldA = weighted.mean(post_gap_oldA,weight),
                                                                 meanbenpov_oldA = weighted.mean(pov,wta_oldA),
                                                                 meanbengap_oldA = weighted.mean(gap,wta_oldA),
                                                                 meanbenexp_oldA = weighted.mean(increase_oldA,wta_oldA),
                                                                 meanbenpostpov_oldAA = weighted.mean(post_pov_oldA,wta_oldA),
                                                                 meanbenpostgap_oldA = weighted.mean(post_gap_oldA,wta_oldA),
                                                                 
                                                                 meancov_B = weighted.mean(cov_B, weight), 
                                                                 meanpov_B = weighted.mean(post_pov_B,weight),
                                                                 meangap_B = weighted.mean(post_gap_B,weight),
                                                                 meanbenpov_B = weighted.mean(pov,wta_B),
                                                                 meanbengap_B = weighted.mean(gap,wta_B),
                                                                 meanbenexp_B = weighted.mean(increase_B,wta_B),
                                                                 meanbenpostpov_B = weighted.mean(post_pov_B,wta_B),
                                                                 meanbenpostgap_B = weighted.mean(post_gap_B,wta_B))
  
  age5yrsdata <- bind_rows(total, female_head, rural)
  return(age5yrsdata)
}

hhtypedata <- function() {
  start_time <- Sys.time()
  
  # replace data with impact_data()
  idata <- impact_data()
  total <- idata %>% group_by(hhtype3) %>% summarise(meancov_A = weighted.mean(cov_A, weight,na.rm = TRUE), 
                                                     meanexp_A = weighted.mean(increase_A,weight,na.rm = TRUE),
                                                     meanbenexp_A = weighted.mean(increase_A,wta_A,na.rm = TRUE),
                                                     
                                                     meancov_matA = weighted.mean(cov_matA, weight,na.rm = TRUE), 
                                                     meanexp_matA = weighted.mean(increase_matA,weight,na.rm = TRUE),
                                                     meanbenexp_matA = weighted.mean(increase_matA,wta_matA,na.rm = TRUE), 
                                                     
                                                     meancov_childA = weighted.mean(cov_childA, weight,na.rm = TRUE), 
                                                     meanexp_childA = weighted.mean(increase_childA,weight,na.rm = TRUE),
                                                     meanbenexp_childA = weighted.mean(increase_childA,wta_childA,na.rm = TRUE),
                                                     
                                                     meancov_disabA = weighted.mean(cov_disabA, weight,na.rm = TRUE), 
                                                     meanexp_disabA = weighted.mean(increase_disabA,weight,na.rm = TRUE),
                                                     meanbenexp_disabA = weighted.mean(increase_disabA,wta_disabA,na.rm = TRUE),
                                                     
                                                     meancov_oldA = weighted.mean(cov_oldA, weight,na.rm = TRUE), 
                                                     meanexp_oldA = weighted.mean(increase_oldA,weight,na.rm = TRUE),
                                                     meanbenexp_oldA = weighted.mean(increase_oldA,wta_oldA,na.rm = TRUE),
                                                     
                                                     meancov_B = weighted.mean(cov_B, weight,na.rm = TRUE), 
                                                     meanexp_B = weighted.mean(increase_B,weight,na.rm = TRUE),
                                                     meanbenexp_B = weighted.mean(increase_B,wta_B,na.rm = TRUE))
  
  total$female_head <- 2
  total$rural <- 2
  female_head <- idata %>% group_by(hhtype3, female_head) %>% summarise(meancov_A = weighted.mean(cov_A, weight,na.rm = TRUE), 
                                                                        meanexp_A = weighted.mean(increase_A,weight,na.rm = TRUE),
                                                                        meanbenexp_A = weighted.mean(increase_A,wta_A,na.rm = TRUE),
                                                                        
                                                                        meancov_matA = weighted.mean(cov_matA, weight,na.rm = TRUE), 
                                                                        meanexp_matA = weighted.mean(increase_matA,weight,na.rm = TRUE),
                                                                        meanbenexp_matA = weighted.mean(increase_matA,wta_matA,na.rm = TRUE),
                                                                        
                                                                        meancov_childA = weighted.mean(cov_childA, weight,na.rm = TRUE), 
                                                                        meanexp_childA = weighted.mean(increase_childA,weight,na.rm = TRUE),
                                                                        meanbenexp_childA = weighted.mean(increase_childA,wta_childA,na.rm = TRUE),
                                                                        
                                                                        meancov_disabA = weighted.mean(cov_disabA, weight,na.rm = TRUE), 
                                                                        meanexp_disabA = weighted.mean(increase_disabA,weight,na.rm = TRUE),
                                                                        meanbenexp_disabA = weighted.mean(increase_disabA,wta_disabA,na.rm = TRUE),
                                                                        
                                                                        meancov_oldA = weighted.mean(cov_oldA, weight,na.rm = TRUE), 
                                                                        meanexp_oldA = weighted.mean(increase_oldA,weight,na.rm = TRUE),
                                                                        meanbenexp_oldA = weighted.mean(increase_oldA,wta_oldA,na.rm = TRUE),
                                                                        
                                                                        meancov_B = weighted.mean(cov_B, weight,na.rm = TRUE), 
                                                                        meanexp_B = weighted.mean(increase_B,weight,na.rm = TRUE),
                                                                        meanbenexp_B = weighted.mean(increase_B,wta_B,na.rm = TRUE))
  
  rural <- idata %>% group_by(hhtype3, rural) %>% summarise(meancov_A = weighted.mean(cov_A, weight,na.rm = TRUE), 
                                                            meanexp_A = weighted.mean(increase_A,weight,na.rm = TRUE),
                                                            meanbenexp_A = weighted.mean(increase_A,wta_A,na.rm = TRUE),
                                                            
                                                            meancov_matA = weighted.mean(cov_matA, weight,na.rm = TRUE), 
                                                            meanexp_matA = weighted.mean(increase_matA,weight,na.rm = TRUE),
                                                            meanbenexp_matA = weighted.mean(increase_matA,wta_matA,na.rm = TRUE),
                                                            
                                                            meancov_childA = weighted.mean(cov_childA, weight,na.rm = TRUE), 
                                                            meanexp_childA = weighted.mean(increase_childA,weight,na.rm = TRUE),
                                                            meanbenexp_childA = weighted.mean(increase_childA,wta_childA,na.rm = TRUE),
                                                            
                                                            meancov_disabA = weighted.mean(cov_disabA, weight,na.rm = TRUE), 
                                                            meanexp_disabA = weighted.mean(increase_disabA,weight,na.rm = TRUE),
                                                            meanbenexp_disabA = weighted.mean(increase_disabA,wta_disabA,na.rm = TRUE),
                                                            
                                                            meancov_oldA = weighted.mean(cov_oldA, weight,na.rm = TRUE), 
                                                            meanexp_oldA = weighted.mean(increase_oldA,weight,na.rm = TRUE),
                                                            meanbenexp_oldA = weighted.mean(increase_oldA,wta_oldA,na.rm = TRUE),
                                                            
                                                            meancov_B = weighted.mean(cov_B, weight,na.rm = TRUE), 
                                                            meanexp_B = weighted.mean(increase_B,weight,na.rm = TRUE),
                                                            meanbenexp_B = weighted.mean(increase_B,wta_B,na.rm = TRUE))
  
  hhtype <- bind_rows(total, female_head, rural)
  #hhtype[is.na(hhtype)]<-0
  # glimpse(hhtype)
  
  # formatted_hhtype2 = data.frame(parameter = numeric(),
  #                               country = character(),
  #                               indicator = numeric(),
  #                               type_of_result = character(),
  #                               scheme = character(),
  #                               value_type = character(),
  #                               label = character(),
  #                               value = numeric(),
  #                               stringsAsFactors = FALSE)
  # formatted_hhtype6 = data.frame(parameter = numeric(),
  #                                  country = character(),
  #                                  indicator = numeric(),
  #                                  type_of_result = character(),
  #                                  scheme = character(),
  #                                  value_type = character(),
  #                                  label = character(),
  #                                  value = numeric(),
  #                                  stringsAsFactors = FALSE)
  # counter = 1
  # counter2 = 1
  # data <- hhtype[order(hhtype$rural),]
  # data_urban <- data[data$rural ==0 & is.na(data$female_head),]
  # data_rural <- data[data$rural ==1 & is.na(data$female_head),]
  # data_total <- data[data$rural ==2 & data$female_head==2,]
  # combine_data <- rbind(data_total, data_urban, data_rural)
  # combine_data$meanbenexp_A[is.na(combine_data$meanbenexp_A)]<-0
  # for (i in 1:nrow(combine_data)) {
  #   # print(deciledata[i,]);
  #   d = combine_data[i,];
  #   # print(d);
  #   # print(d$decile)
  #   print(d$hhtype3)
  #   print(typeof(d$hhtype3))
  #   print(d$hhtype3[1])
  #   # parameter	country	indicator	type_of_result	scheme
  #   fo = c();
  #   fo = append(fo, 1);
  #   fo = append(fo, input$country);
  #   fo = append(fo, 2);
  #   fo = append(fo, "Coverage");
  #   fo = append(fo, "Child Benefit");
  #   if (!is.na(d$rural) && d$rural==2) {
  #     fo = append(fo, "Total");
  #   } else if (!is.na(d$rural) && d$rural==1) {
  #     fo = append(fo, "Rural");
  #   } else if (!is.na(d$rural) && d$rural==0) {
  #     fo = append(fo, "Urban");
  #   }
  #   fo = append(fo, as.character(d$hhtype3));
  #   fo = append(fo, round(d$meancov_A,1));
  #   if (!is.na(d$rural)) {
  #     formatted_hhtype2[counter, ] <- fo;
  #     counter<-counter+1
  #   }
  #   
  #   fohh = c();
  #   fohh = append(fohh, 1);
  #   fohh = append(fohh, input$country);
  #   fohh = append(fohh, 6);
  #   fohh = append(fohh, "Household Consumption");
  #   fohh = append(fohh, "Child Benefit");
  #   if (!is.na(d$rural) && d$rural==2) {
  #     fohh = append(fohh, "Total");
  #   } else if (!is.na(d$rural) && d$rural==1) {
  #     fohh = append(fohh, "Rural");
  #   } else if (!is.na(d$rural) && d$rural==0) {
  #     fohh = append(fohh, "Urban");
  #   }
  #   fohh = append(fohh, as.character(d$hhtype3));
  #   fohh = append(fohh, round(d$meanbenexp_A,1));
  #   # fohh2 = append(fohh2, d$meanexp_A);
  #   if (!is.na(d$rural)) {
  #     formatted_hhtype6[counter2, ] <- fohh;
  #     counter2<-counter2+1
  #   }
  # }
  # write.csv(formatted_hhtype2, "./csv_output/formatted_hhtype2.csv")
  # write.csv(formatted_hhtype6, "./csv_output/formatted_hhtype6.csv")
  # 
  # write.csv(hhtype, "./csv_output/hhtypedata.csv")
  end_time <- Sys.time()
  
  print('hhtypedata processing: ')
  print(end_time - start_time)
  return(hhtype)
}

totaldata <- function() {
  # replace data with impact_data()
  data <- impact_data()
  total <- data.frame(meancov_A = weighted.mean(data$cov_A, data$weight), 
                      meanexp_A = weighted.mean(data$increase_A,data$weight),
                      meanbenexp_A = weighted.mean(data$increase_A,data$wta_A),
                      meancovchildren_A = weighted.mean(data$cov_A, data$weight_children),
                      meancovworking_A = weighted.mean(data$cov_A, data$weight_workingage), 
                      meancovelderly_A = weighted.mean(data$cov_A, data$weight_elderly), 
                      
                      meancov_matA = weighted.mean(data$cov_matA, data$weight), 
                      meancovint_matA = weighted.mean(data$cov_matA, data$weight_mat),
                      meanexp_matA = weighted.mean(data$increase_matA,data$weight),
                      meanexpint_matA = weighted.mean(data$increase_matA, data$weight_mat),
                      meanbenexp_matA = weighted.mean(data$increase_matA,data$wta_matA),
                      meancovchildren_matA = weighted.mean(data$cov_matA, data$weight_children),
                      meancovworking_matA = weighted.mean(data$cov_matA, data$weight_workingage), 
                      meancovelderly_matA = weighted.mean(data$cov_matA, data$weight_elderly), 
                      
                      meancov_childA = weighted.mean(data$cov_childA, data$weight), 
                      meancovint_childA = weighted.mean(data$cov_childA, data$weight_children),
                      meanexp_childA = weighted.mean(data$increase_childA,data$weight),
                      meanexpint_childA = weighted.mean(data$increase_childA, data$weight_children),
                      meanbenexp_childA = weighted.mean(data$increase_childA,data$wta_childA),
                      meancovchildren_childA = weighted.mean(data$cov_childA, data$weight_children),
                      meancovworking_childA = weighted.mean(data$cov_childA, data$weight_workingage), 
                      meancovelderly_childA = weighted.mean(data$cov_childA, data$weight_elderly), 
                      
                      meancov_disabA = weighted.mean(data$cov_disabA, data$weight), 
                      meancovint_disabA = weighted.mean(data$cov_disabA, data$weight_disab),
                      meanexp_disabA = weighted.mean(data$increase_disabA,data$weight),
                      meanexpint_disabA = weighted.mean(data$increase_disabA, data$weight_disab),
                      meanbenexp_disabA = weighted.mean(data$increase_disabA,data$wta_disabA),
                      meancovchildren_disabA = weighted.mean(data$cov_disabA, data$weight_children),
                      meancovworking_disabA = weighted.mean(data$cov_disabA, data$weight_workingage), 
                      meancovelderly_disabA = weighted.mean(data$cov_disabA, data$weight_elderly), 
                      
                      meancov_oldA = weighted.mean(data$cov_oldA, data$weight), 
                      meancovint_oldA = weighted.mean(data$cov_oldA, data$weight_elderly),
                      meanexp_oldA = weighted.mean(data$increase_oldA,data$weight),
                      meanexpint_oldA = weighted.mean(data$increase_oldA, data$weight_elderly),
                      meanbenexp_oldA = weighted.mean(data$increase_oldA,data$wta_oldA),
                      meancovchildren_oldA = weighted.mean(data$cov_oldA, data$weight_children),
                      meancovworking_oldA = weighted.mean(data$cov_oldA, data$weight_workingage), 
                      meancovelderly_oldA = weighted.mean(data$cov_oldA, data$weight_elderly), 
                      
                      meancov_B = weighted.mean(data$cov_B, data$weight), 
                      meancovint_B = weighted.mean(data$cov_B, data$wta_B),
                      meanexp_B = weighted.mean(data$increase_B,data$weight),
                      meanexpint_B = weighted.mean(data$increase_B, data$wta_B),
                      meanbenexp_B = weighted.mean(data$increase_B,data$wta_B),
                      meancovchildren_B = weighted.mean(data$cov_B, data$weight_children),
                      meancovworking_B = weighted.mean(data$cov_B, data$weight_workingage), 
                      meancovelderly_B = weighted.mean(data$cov_B, data$weight_elderly))
  
  total$rural <- 2
  rural <- data %>% group_by(rural) %>% summarise(meancov_A = weighted.mean(cov_A, weight), 
                                                  meanexp_A = weighted.mean(increase_A,weight),
                                                  meanbenexp_A = weighted.mean(increase_A,wta_A),
                                                  meancovchildren_A = weighted.mean(cov_A, weight_children),
                                                  meancovworking_A = weighted.mean(cov_A, weight_workingage), 
                                                  meancovelderly_A = weighted.mean(cov_A, weight_elderly), 
                                                  
                                                  meancov_matA = weighted.mean(cov_matA, weight), 
                                                  meancovint_matA = weighted.mean(cov_matA, weight_mat),
                                                  meanexp_matA = weighted.mean(increase_matA,weight),
                                                  meanexpint_matA = weighted.mean(increase_matA, weight_mat),
                                                  meanbenexp_matA = weighted.mean(increase_matA,wta_matA),
                                                  meancovchildren_matA = weighted.mean(cov_matA, weight_children),
                                                  meancovworking_matA = weighted.mean(cov_matA, weight_workingage), 
                                                  meancovelderly_matA = weighted.mean(cov_matA, weight_elderly), 
                                                  
                                                  meancov_childA = weighted.mean(cov_childA, weight), 
                                                  meancovint_childA = weighted.mean(cov_childA, weight_children),
                                                  meanexp_childA = weighted.mean(increase_childA,weight),
                                                  meanexpint_childA = weighted.mean(increase_childA, weight_children),
                                                  meanbenexp_childA = weighted.mean(increase_childA,wta_childA),
                                                  meancovchildren_childA = weighted.mean(cov_childA, weight_children),
                                                  meancovworking_childA = weighted.mean(cov_childA, weight_workingage), 
                                                  meancovelderly_childA = weighted.mean(cov_childA, weight_elderly), 
                                                  
                                                  meancov_disabA = weighted.mean(cov_disabA, weight), 
                                                  meancovint_disabA = weighted.mean(cov_disabA, weight_disab),
                                                  meanexp_disabA = weighted.mean(increase_disabA,weight),
                                                  meanexpint_disabA = weighted.mean(increase_disabA, weight_disab),
                                                  meanbenexp_disabA = weighted.mean(increase_disabA,wta_disabA),
                                                  meancovchildren_disabA = weighted.mean(cov_disabA, weight_children),
                                                  meancovworking_disabA = weighted.mean(cov_disabA, weight_workingage), 
                                                  meancovelderly_disabA = weighted.mean(cov_disabA, weight_elderly), 
                                                  
                                                  meancov_oldA = weighted.mean(cov_oldA, weight), 
                                                  meancovint_oldA = weighted.mean(cov_oldA, weight_elderly),
                                                  meanexp_oldA = weighted.mean(increase_oldA,weight),
                                                  meanexpint_oldA = weighted.mean(increase_oldA, weight_elderly),
                                                  meanbenexp_oldA = weighted.mean(increase_oldA,wta_oldA),
                                                  meancovchildren_oldA = weighted.mean(cov_oldA, weight_children),
                                                  meancovworking_oldA = weighted.mean(cov_oldA, weight_workingage), 
                                                  meancovelderly_oldA = weighted.mean(cov_oldA, weight_elderly), 
                                                  
                                                  meancov_B = weighted.mean(cov_B, weight), 
                                                  meancovint_B = weighted.mean(cov_B, wta_B),
                                                  meanexp_B = weighted.mean(increase_B,weight),
                                                  meanexpint_B = weighted.mean(increase_B, wta_B),
                                                  meanbenexp_B = weighted.mean(increase_B,wta_B),
                                                  meancovchildren_B = weighted.mean(cov_B, weight_children),
                                                  meancovworking_B = weighted.mean(cov_B, weight_workingage), 
                                                  meancovelderly_B = weighted.mean(cov_B, weight_elderly))
  
  totaldata <- bind_rows(total, rural)
  # write.csv(totaldata, "./csv_output/totaldata.csv")
  return(totaldata)
}

caption_text <- function(){
  database <- datasetsSurveys[[input$country]]
  caption_text = paste0("<em>Notes</em>: own calculations based on ",
                        database,
                        ".")
}
