#### Sidebar ####

#step <- c(10, 100, 100000, 1000, 100, 100, 10000, 100)
#names(step) <- c(countrylist, '')

# sidebar ui ####
output$sidebar_b <- renderUI({
  ui <- div(
    selectInput(
      "country_b",
      "Select a country",
      c(countrylist, ''),
      selected = param_b$country,
      multiple = FALSE
    ),
    conditionalPanel(
      condition = "input.country_b != ''",
      div(id = "setup_panel_b",
          h5(tags$b("Set parameters")),
          {
            wellPanel(
              id = "Sidebar_b",
              h5(
                "Select the type of programmes you would like to build (you can also select a combination of programmes). Next, adjust the parameters to simulate potential impacts."
              ),
              ### INCLUSIVE
              ## MATERNITY BENEFIT
              prettyCheckbox(
                inputId = "matbenefit_b",
                label = "Maternity Benefit Programme",
                value = mparam_b$mat,
                bigger = TRUE,
                icon = icon("check"),
                status = 'primary',
                fill = TRUE,
                thick = TRUE
              ),
              conditionalPanel(
                condition = "input.matbenefit_b == true",
                helpText(textOutput("existing_matA_b")),
                sliderInput(
                  inputId = "matlengthA_b",
                  "Drag sliders to adjust length of maternity benefit:",
                  min = 0,
                  max = 52,
                  value = mparam_b$matLength,
                  post = " weeks",
                  step = 1,
                  dragRange = F
                ),
                popify(
                  sliderInput(
                    inputId = "mattransferA_b",
                    paste0("Enter monthly benefit level (in ", econ_b()$cur, "):"),
                    min = 0,
                    max = round(econ_b()$gdppc[1] * 0.09 / 12, -1)*4, # TO BE REVIEWED
                    value = mparam_b$matTrans,
                    step = econ_b()$steps,
                    pre = paste0(econ_b()$cur, " ")
                  ),
                  "",
                  "The transfer value is paid monthly to each mother of newborn, in local currency. The default transfer value is set to zero. Across countries, a benefit of two thirds of the minimum wage for 14 weeks would correspond to 9% GDP per capita, while a benefit equivalent to 18 weeks of minimum wage would correspond to 18% GDP per capita.",                        
                  placement = "bottom"
                ),
                textOutput("gdppercapita_matA_b"),
                br(),
                sliderInput(
                  inputId = "mat_admin_b",
                  "Administrative cost of Maternity Benefit",
                  min = 0,
                  max = 50,
                  value = mparam_b$matAdmin,
                  post = "%",
                  step = 0.5
                ),
                #   "Administrative costs are relative to the programme's total transfer value. The default is set to 5%, when programme is universal and 10% otherwise.",
                br(),
                popify(
                  prettyCheckbox(
                    inputId = "matmeansA_b",
                    label = "Make programme means-tested?",
                    value = mparam_b$matMeans,
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
                  condition = "input.matmeansA_b == true", 
                  helpText("Note that by restricting coverage targeting errors will be assumed. Please find the extent of the errors for the selected coverage in the Coverage Tab for this programme"),
                  sliderInput(
                    inputId = "matcovA_b",
                    "Drag slider to restrict coverage (% of all matren targeted):",
                    min = 0,
                    max = 100,
                    value = mparam_b$matCov,
                    dragRange = F,
                    post = "%"
                  ),
                  br(),
                  br()
                )
              ),
              ## CHILD BENEFIT
                  prettyCheckbox(
                    inputId = "childbenefit_b",
                    label = "Child Benefit Programme",
                    value = cparam_b$child,
                    bigger = TRUE,
                    icon = icon("check"),
                    status = 'primary',
                    fill = TRUE,
                    thick = TRUE
                  ),
                  conditionalPanel(
                    condition = "input.childbenefit_b == true",
                      helpText(textOutput("existing_childA_b")),
                      sliderInput(
                        inputId = "childageA_b",
                        "Drag sliders to adjust age-eligibility criteria:",
                        min = 0,
                        max = 18,
                        value = cparam_b$childAge,
                        post = " yrs",
                        dragRange = F
                      ),
                      popify(
                        sliderInput(
                          inputId = "childtransferA_b",
                          paste0("Enter monthly benefit level (in ", econ_b()$cur, "):"),
                          min = 0,
                          max = round(econ_b()$gdppc[1] * 0.04 / 12, -1)*4,
                          value = cparam_b$childTrans,
                          step = econ_b()$steps,
                          pre = paste0(econ_b()$cur, " ")
                        ),
                        "",
                        "The transfer value is paid monthly per child, in local currency. The default transfer value is set to zero. Globally, child benefit on average is 4% GDP per capita.",                        placement = "bottom"
                      ),
                      textOutput("gdppercapita_childA_b"),
                      br(),
                      sliderInput(
                        inputId = "child_admin_b",
                        "Administrative cost of Child Benefit",
                        min = 0,
                        max = 50,
                        value = cparam_b$childAdmin,
                        post = "%",
                        step = 0.5
                      ),
                      #   "Administrative costs are relative to the programme's total transfer value. The default is set to 5%, when programme is universal and 10% otherwise.",
                      br(),
                      popify(
                        prettyCheckbox(
                          inputId = "childmeansA_b",
                          label = "Make programme means-tested?",
                          value = cparam_b$childMeans,
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
                        condition = "input.childmeansA_b == true", 
                        helpText("Note that by restricting coverage targeting errors will be assumed. Please find the extent of the errors for the selected coverage in the Coverage Tab for this programme"),
                        sliderInput(
                          inputId = "childcovA_b",
                          "Drag slider to restrict coverage (% of all children targeted):",
                          min = 0,
                          max = 100,
                          value = cparam_b$childCov,
                          dragRange = F,
                          post = "%"
                        ),
                        br(),
                        br()
                      )
                  ),
              ## DISABILITY BENEFIT
                  prettyCheckbox(
                    inputId = "disabilitybenefit_b",
                    label = "Disability Benefit Programme",
                    value = dparam_b$disab,
                    bigger = TRUE,
                    icon = icon("check"),
                    status = 'primary',
                    fill = TRUE,
                    thick = TRUE
                  ),
                  conditionalPanel(
                    condition = "input.disabilitybenefit_b == true",
                      helpText(textOutput("existing_disabA_b")),
                      sliderInput(
                        inputId = "disabageA_b",
                        "Drag sliders to adjust age-eligibility criteria:",
                        min = 0,
                        max = 100,
                        value = dparam_b$disabAge,
                        post = " yrs",
                        dragRange = F
                      ),
                      popify(
                        sliderInput(
                          inputId = "disabtransferA_b",
                          paste0("Enter monthly benefit level (in ", econ_b()$cur, "):"),
                          min = 0,
                          max = round(econ_b()$gdppc[1] * 0.10 / 12, -1)*6,
                          value = dparam_b$disabTrans,
                          step = econ_b()$steps,
                          pre = paste0(econ_b()$cur, " ")
                        ),
                        "",
                        "The transfer value is paid monthly per eligible person, in local currency. The default transfer value is set to zero. Globally, disability benefit on average is 14% of GDP per capita, while among OECD countries it is on average 23%",                        placement = "bottom"
                      ),
                      textOutput("gdppercapita_disabA_b"),
                      br(),
                      sliderInput(
                        inputId = "disab_admin_b",
                        "Administrative cost of Disability Benefit",
                        min = 0,
                        max = 50,
                        value = dparam_b$disabAdmin,
                        post = "%",
                        step = 0.5
                      ),
                      #   "Administrative costs are relative to the programme's total transfer value. The default is set to 5%, when programme is universal and 10% otherwise.",
                      br(),
                      popify(
                        prettyCheckbox(
                          inputId = "disabmeansA_b",
                          label = "Make programme means-tested?",
                          value = dparam_b$disabMeans,
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
                        condition = "input.disabmeansA_b == true",
                        helpText("Note that by restricting coverage targeting errors will be assumed. Please find the extent of the errors for the selected coverage in the Coverage Tab for this programme"),
                        sliderInput(
                          inputId = "disabcovA_b",
                          "Drag slider to restrict coverage (% of all persons with disabilities):",
                          min = 0,
                          max = 100,
                          value = dparam_b$disabCov,
                          dragRange = F,
                          post = "%"
                        ),
                        br(),
                        br()
                        )
                  ),
              ## OLD AGE BENEFIT
                  prettyCheckbox(
                    inputId = "oldagebenefit_b",
                    label = "Old Age Benefit Programme",
                    value = oparam_b$old,
                    bigger = TRUE,
                    icon = icon("check"),
                    status = 'primary',
                    fill = TRUE,
                    thick = TRUE
                  ),
                  conditionalPanel(
                    condition = "input.oldagebenefit_b == true",
                      helpText(textOutput("existing_oldA_b")),
                      sliderInput(
                        inputId = "oldageA_b",
                        "Drag sliders to adjust age-eligibility criteria:",
                        min = 50,
                        max = 100,
                        value = oparam_b$oldAge,
                        post = " yrs",
                        dragRange = F
                      ),
                      popify(
                        sliderInput(
                          inputId = "oldtransferA_b",
                          paste0("Enter monthly benefit level (in ", econ_b()$cur, "):"),
                          min = 0,
                          max = round(econ_b()$gdppc[1] * 0.10 / 12, -1)*6,
                          value = oparam_b$oldTrans,
                          step = econ_b()$steps,
                          pre = paste0(econ_b()$cur, " ")
                        ),
                        "",
                        "The transfer value is paid monthly per eligible person, in local currency. The default transfer value is set to zero. Globally, old age benefit on average is 16% of GDP per capita, while among OECD countries it is on an average 22%",                        placement = "bottom"
                      ),
                      textOutput("gdppercapita_oldA_b"),
                      br(),
                      sliderInput(
                        inputId = "old_admin_b",
                        "Administrative cost of Old Age Benefit",
                        min = 0,
                        max = 50,
                        value = oparam_b$oldAdmin,
                        post = "%",
                        step = 0.5
                      ),
                      #   #   "Administrative costs are relative to the programme's total transfer value. The default is set to 5%, when programme is universal and 10% otherwise.",
                      br(),
                      popify(
                        prettyCheckbox(
                          inputId = "pensiontest_b",
                          label = "Make programme pension-tested?",
                          value = oparam_b$oldPension,
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
                          inputId = "oldmeansA_b",
                          label = "Make programme means-tested?",
                          value = oparam_b$oldMeans,
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
                        condition = "input.oldmeansA_b == true",
                        helpText("Note that by restricting coverage targeting errors will be assumed. Please find the extent of the errors for the selected coverage in the Coverage Tab for this programme"),
                        sliderInput(
                          inputId = "oldcovA_b",
                          "Drag slider to restrict coverage (% of all older people targeted):",
                          min = 0,
                          max = 100,
                          value = oparam_b$oldCov,
                          dragRange = F,
                          post = "%"
                        ),
                        br(),
                        br()
                      )
                  ),
              ## HH BENEFIT
              prettyCheckbox(
                inputId = "meanstested_b",
                label = "Household Poverty Reduction Programme",
                value = param_b$hh,
                bigger = TRUE,
                icon = icon("check"),
                status = 'primary',
                fill = TRUE,
                thick = TRUE
              ),
              {
                conditionalPanel(
                  condition = "input.meanstested_b == true",
                    helpText(textOutput("existing_B_b")),
                    sliderInput(
                      inputId = "hhcovB_b",
                      "Drag slider to restrict coverage (% of all households targeted):",
                      min = 0,
                      max = 100,
                      value = hparam_b$hhCov,
                      dragRange = F,
                      post = "%"
                    ),
                  helpText("Note that targeting errors will be assumed. Please find the extent of the errors for the selected coverage in the Coverage Tab for this programme"),
                  br(),
                    br(),
                    popify(
                      sliderInput(
                        inputId = "hhtransferB_b",
                        paste0("Enter monthly benefit level (in ", econ_b()$cur, "):"),
                        min = 0,
                        max = round(econ_b()$gdppc[1] * 0.10 / 12, -1)*6,
                        value = hparam_b$hhTrans,
                        step = econ_b()$steps,
                        pre = paste0(econ_b()$cur, " ")
                      ),
                      "",
                      "The transfer value is paid monthly per eligible household, in local currency. The default transfer value is set to zero. A typical household benefit is around 2-3% of GDP per capita for an average household size of 5 members.",
                      placement = "bottom"
                    ),
                    textOutput("gdppercapita_B_b"),
                    br(),
                    sliderInput(
                      inputId = "hh_admin_b",
                      "Administrative cost of Household Programme",
                      min = 0,
                      max = 50,
                      value = hparam_b$hhAdmin,
                      post = "%",
                      step = 0.5
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
