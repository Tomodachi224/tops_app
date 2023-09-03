#### Sidebar ####

#step <- c(10, 100, 100000, 1000, 100, 100, 10000, 100)
#names(step) <- c(countrylist, '')

# sidebar ui ####
output$sidebar <- renderUI({
  ui <- div(
    selectInput(
      "country",
      "Select a country",
      c(countrylist, ''),
      selected = param$country,
      multiple = FALSE
    ),
    conditionalPanel(
      condition = "input.country != ''",
      div(id = "setup_panel",
          h5(tags$b("Set parameters")),
          {
            wellPanel(
              id = "Sidebar",
              h5(
                "Select the type of programmes you would like to build (you can also select a combination of programmes). Next, adjust the parameters to simulate potential impacts."
              ),
              ### INCLUSIVE
              ## MATERNITY BENEFIT
              prettyCheckbox(
                inputId = "matbenefit",
                label = "Maternity Benefit Programme",
                value = mparam$mat,
                bigger = TRUE,
                icon = icon("check"),
                status = 'primary',
                fill = TRUE,
                thick = TRUE
              ),
              conditionalPanel(
                condition = "input.matbenefit == true",
                helpText(textOutput("existing_matA")),
                sliderInput(
                  inputId = "matlengthA",
                  "Drag sliders to adjust length of maternity benefit:",
                  min = 0,
                  max = 52,
                  value = mparam$matLength,
                  post = " weeks",
                  step = 1,
                  dragRange = F
                ),
                popify(
                  sliderInput(
                    inputId = "mattransferA",
                    paste0("Enter monthly benefit level (in ", econ()$cur, "):"),
                    min = 0,
                    max = round(econ()$gdppc[1] * 0.09 / 12, -1)*4, # TO BE REVIEWED
                    value = mparam$matTrans,
                    step = econ()$steps,
                    pre = paste0(econ()$cur, " ")
                  ),
                  "",
                  "The transfer value is paid monthly to each mother of newborn, in local currency. The default transfer value is set to zero. Across countries, a benefit of two thirds of the minimum wage for 14 weeks would correspond to 9% GDP per capita, while a benefit equivalent to 18 weeks of minimum wage would correspond to 18% GDP per capita.",                        
                  placement = "bottom"
                ),
                textOutput("gdppercapita_matA"),
                br(),
                sliderInput(
                  inputId = "mat_admin",
                  "Administrative cost of Maternity Benefit",
                  min = 0,
                  max = 50,
                  value = mparam$matAdmin,
                  post = "%",
                  step = 0.5
                ),
                #   "Administrative costs are relative to the programme's total transfer value. The default is set to 5%, when programme is universal and 10% otherwise.",
                br(),
                popify(
                  prettyCheckbox(
                    inputId = "matmeansA",
                    label = "Make programme means-tested?",
                    value = mparam$matMeans,
                    icon = icon("check"),
                    shape = 'round',
                    status = 'primary',
                    fill = TRUE,
                    thick = TRUE
                  ),
                  "Means-tested",
                  "Means-tested programmes require individual or households to be below a certain level of income or wealth. In this tool, the threshold is determined in relative terms, that is, by welfare ranking"
                ),
                conditionalPanel(
                  condition = "input.matmeansA == true", 
                  helpText("Note that by restricting coverage targeting errors will be assumed. Please find the extent of the errors for the selected coverage in the Coverage Tab for this programme"),
                  sliderInput(
                    inputId = "matcovA",
                    "Drag slider to restrict coverage (% of all matren targeted):",
                    min = 0,
                    max = 100,
                    value = mparam$matCov,
                    dragRange = F,
                    post = "%"
                  ),
                  br(),
                  br()
                )
              ),
              ## CHILD BENEFIT
                prettyCheckbox(
                    inputId = "childbenefit",
                    label = "Child Benefit",
                    value = cparam$child,
                    bigger = TRUE,
                    icon = icon("check"),
                    status = 'primary',
                    fill = TRUE,
                    thick = TRUE
                  ),
                  conditionalPanel(
                    condition = "input.childbenefit == true",
                      helpText(textOutput("existing_childA")),
                      sliderInput(
                        inputId = "childageA",
                        "Drag sliders to adjust age-eligibility criteria",
                        min = 0,
                        max = 18,
                        value = cparam$childAge,
                        post = " yrs",
                        dragRange = F
                      ),
                      popify(
                        sliderInput(
                          inputId = "childtransferA",
                          paste0("Enter monthly benefit level (in ", econ()$cur, "):"),
                          min = 0,
                          max = round(econ()$gdppc[1] * 0.04 / 12, -1)*4,
                          value = cparam$childTrans,
                          step = econ()$steps,
                          pre = paste0(econ()$cur, " ")
                        ),
                        "",
                        "The transfer value is paid monthly per child, in local currency. The default transfer value is set to zero. Globally, child benefit on average is 4% GDP per capita.",                        placement = "bottom"
                      ),
                      textOutput("gdppercapita_childA"),
                      br(),
                      sliderInput(
                        inputId = "child_admin",
                        "Administrative cost of Child Benefit",
                        min = 0,
                        max = 50,
                        value = cparam$childAdmin,
                        post = "%",
                        step = 1
                      ),
                      #   "Administrative costs are relative to the programme's total transfer value. The default is set to 5%, when programme is universal and 10% otherwise.",
                      br(),
                      popify(
                        prettyCheckbox(
                          inputId = "childmeansA",
                          label = "Make programme means-tested?",
                          value = cparam$childMeans,
                          icon = icon("check"),
                          shape = 'round',
                          status = 'primary',
                          fill = TRUE,
                          thick = TRUE
                        ),
                        "Means-tested",
                        "Means-tested programmes require individual or households to be below a certain level of income or wealth. In this tool, the threshold is determined in relative terms, that is, by welfare ranking"
                      ),
                      conditionalPanel(
                        condition = "input.childmeansA == true",
                        helpText("Note that by restricting coverage targeting errors will be assumed. Please find the extent of the errors for the selected coverage in the Coverage Tab for this programme"),
                        sliderInput(
                          inputId = "childcovA",
                          "Drag slider to restrict coverage (% of all children targeted):",
                          min = 0,
                          max = 100,
                          value = cparam$childCov,
                          dragRange = F,
                          post = "%"
                        ),
                        br(),
                        br()
                      )
                  ),
              ## DISABILITY BENEFIT
                  prettyCheckbox(
                    inputId = "disabilitybenefit",
                    label = "Disability Benefit",
                    value = dparam$disab,
                    bigger = TRUE,
                    icon = icon("check"),
                    status = 'primary',
                    fill = TRUE,
                    thick = TRUE
                  ),
                  conditionalPanel(
                    condition = "input.disabilitybenefit == true",
                      helpText(textOutput("existing_disabA")),
                      sliderInput(
                        inputId = "disabageA",
                        "Drag sliders to adjust age-eligibility criteria",
                        min = 0,
                        max = 100,
                        value = dparam$disabAge,
                        post = " yrs",
                        dragRange = F
                      ),
                      popify(
                        sliderInput(
                          inputId = "disabtransferA",
                          paste0("Enter monthly benefit level (in ", econ()$cur, "):"),
                          min = 0,
                          max = round(econ()$gdppc[1] * 0.10 / 12, -1)*6,
                          value = dparam$disabTrans,
                          step = econ()$steps,
                          pre = paste0(econ()$cur, " ")
                        ),
                        "",
                        "The transfer value is paid monthly per eligible person, in local currency. The default transfer value is set to zero. Globally, disability benefit on average is 14% of GDP per capita, while among OECD countries it is on average 23%",                        placement = "bottom"
                      ),
                      textOutput("gdppercapita_disabA"),
                      br(),
                      sliderInput(
                        inputId = "disab_admin",
                        "Administrative cost of Disability Benefit",
                        min = 0,
                        max = 50,
                        value = dparam$disabAdmin,
                        post = "%",
                        step = 1
                      ),
                      #   "Administrative costs are relative to the programme's total transfer value. The default is set to 5%, when programme is universal and 10% otherwise.",
                      br(),
                      popify(
                        prettyCheckbox(
                          inputId = "disabmeansA",
                          label = "Make programme means-tested?",
                          value = dparam$disabMeans,
                          icon = icon("check"),
                          shape = 'round',
                          status = 'primary',
                          fill = TRUE,
                          thick = TRUE
                        ),
                        "Means-tested",
                        "Means-tested programmes require individual or households to be below a certain level of income or wealth. In this tool, the threshold is determined in relative terms, that is, by welfare ranking"
                      ),
                      conditionalPanel(
                        condition = "input.disabmeansA == true",
                        helpText("Note that by restricting coverage targeting errors will be assumed. Please find the extent of the errors for the selected coverage in the Coverage Tab for this programme"),
                        sliderInput(
                          inputId = "disabcovA",
                          "Drag slider to restrict coverage (% of all persons with disabilities):",
                          min = 0,
                          max = 100,
                          value = dparam$disabCov,
                          dragRange = F,
                          post = "%"
                        ),
                        br(),
                        br()
                        )
                  ),
              ## OLD AGE BENEFIT
                  prettyCheckbox(
                    inputId = "oldagebenefit",
                    label = "Old Age Benefit",
                    value = oparam$old,
                    bigger = TRUE,
                    icon = icon("check"),
                    status = 'primary',
                    fill = TRUE,
                    thick = TRUE
                  ),
                  conditionalPanel(
                    condition = "input.oldagebenefit == true",
                      helpText(textOutput("existing_oldA")),
                      sliderInput(
                        inputId = "oldageA",
                        "Drag sliders to adjust age-eligibility criteria",
                        min = 50,
                        max = 100,
                        value = oparam$oldAge,
                        post = " yrs",
                        dragRange = F
                      ),
                      popify(
                        sliderInput(
                          inputId = "oldtransferA",
                          paste0("Enter monthly benefit level (in ", econ()$cur, "):"),
                          min = 0,
                          max = round(econ()$gdppc[1] * 0.10 / 12, -1)*6,
                          value = oparam$oldTrans,
                          step = econ()$steps,
                          pre = paste0(econ()$cur, " ")
                        ),
                        "",
                        "The transfer value is paid monthly per eligible person, in local currency. The default transfer value is set to zero. Globally, old age benefit on average is 16% of GDP per capita, while among OECD countries it is on an average 22%",                        placement = "bottom"
                      ),
                      textOutput("gdppercapita_oldA"),
                      br(),
                      sliderInput(
                        inputId = "old_admin",
                        "Administrative cost of Old Age Benefit",
                        min = 0,
                        max = 50,
                        value = oparam$oldAdmin,
                        post = "%",
                        step = 1
                      ),
                      #   #   "Administrative costs are relative to the programme's total transfer value. The default is set to 5%, when programme is universal and 10% otherwise.",
                      br(),
                      popify(
                        prettyCheckbox(
                          inputId = "pensiontest",
                          label = "Make programme pension-tested?",
                          value = oparam$oldPension,
                          icon = icon("check"),
                          shape = 'round',
                          status = 'primary',
                          fill = TRUE,
                          thick = TRUE
                        ),
                        "Pension-tested",
                        "Pension-testing is commonly applied in instances when a tax-financed social pension is given only to those not in receipt of a pension",
                        placement = "top"
                      ),
                      popify(
                        prettyCheckbox(
                          inputId = "oldmeansA",
                          label = "Make programme means-tested?",
                          value = oparam$oldMeans,
                          icon = icon("check"),
                          shape = 'round',
                          status = 'primary',
                          fill = TRUE,
                          thick = TRUE
                        ),
                        "Means-tested",
                        "Means-tested programmes require individual or households to be below a certain level of income or wealth. In this tool, the threshold is determined in relative terms, that is, by welfare ranking"
                      ),
                      conditionalPanel(
                        condition = "input.oldmeansA == true",
                        helpText("Note that by restricting coverage targeting errors will be assumed. Please find the extent of the errors for the selected coverage in the Coverage Tab for this programme"),
                        sliderInput(
                          inputId = "oldcovA",
                          "Drag slider to restrict coverage (% of all older people targeted):",
                          min = 0,
                          max = 100,
                          value = oparam$oldCov,
                          dragRange = F,
                          post = "%"
                        ),
                        br(),
                        br()
                      )
                  ),
              ## HH BENEFIT
              prettyCheckbox(
                inputId = "meanstested",
                label = "Household Poverty Reduction",
                value = param$hh,
                bigger = TRUE,
                icon = icon("check"),
                status = 'primary',
                fill = TRUE,
                thick = TRUE
              ),
              {
                conditionalPanel(
                  condition = "input.meanstested == true",
                    helpText(textOutput("existing_B")),
                    sliderInput(
                      inputId = "hhcovB",
                      "Drag slider to restrict coverage (% of all households targeted):",
                      min = 0,
                      max = 100,
                      value = hparam$hhCov,
                      dragRange = F,
                      post = "%"
                    ),
                  helpText("Note that targeting errors will be assumed. Please find the extent of the errors for the selected coverage in the Coverage Tab for this programme"),
                    br(),
                    br(),
                    popify(
                      sliderInput(
                        inputId = "hhtransferB",
                        paste0("Enter monthly benefit level (in ", econ()$cur, "):"),
                        min = 0,
                        max = round(econ()$gdppc[1] * 0.10 / 12, -1)*6,
                        value = hparam$hhTrans,
                        step = econ()$steps,
                        pre = paste0(econ()$cur, " ")
                      ),
                      "",
                      "The transfer value is paid monthly per eligible household, in local currency. The default transfer value is set to zero. A typical old age benefit is around 2-3% of GDP per capita for an average household size of 5 members.",
                      placement = "bottom"
                    ),
                    textOutput("gdppercapita_B"),
                    br(),
                    sliderInput(
                      inputId = "hh_admin",
                      "Administrative cost of Household Programme",
                      min = 0,
                      max = 50,
                      value = hparam$hhAdmin,
                      post = "%",
                      step = 1
                    ),
                    #   "Administrative costs are relative to the programme's total transfer value. The default is set to 5%, when programme is universal and 10% otherwise.",
                    br()
                )
              }
            )
          }))
  )
  return(ui)
})
