User Guide
================

# Introduction

The Social Protection Tool provides simulations of the cost and impact
of tax-financed cash transfer programmes across a number of countries in
Asia and the Pacific. It can be used to make initial estimates of cost
projections for different social protection schemes and their impact on
coverage, household purchasing power, poverty and inequality. The Tool
also illustrates programme affordability by comparing estimated budget
against alternative financing streams. The tool was developed using  and
its Shiny package, developed by RStudio. For more information about the
Shiny package see <https://shiny.rstudio.com>.

This guide complements the Tool’s technical note, and provides an
overview of the different files and R scripts used in the Tool. This
guide will help ESCAP’s internal staff to maintain and develop the Tool.
The guide has two main sections. The first section describes to the user
all the necessary files that go into the tool, including all the
different data files. The second section provides a detailed overview of
the structure of the files.

This guide assumes the reader knows the Tool and is familiar with the R
language and the Shiny package.

# Input files

There are three types of input files that feed into the tool: data,
documentation and HTML files. The data files consist of all the
household survey and socioeconomic data necessary for the Tool to
simulate economic outcomes and project costs of programmes for each
country. The documentation files are mostly csv tables that feed the
**About** and **Glossary** pages, and which also provide background
information on the existing programmes of each country. Finally, the
HTML files are pages in the tool that have been developed using HTML
code instead of the R language.

## Data files

All data files are stored in a `./data` folder, which is not included in this repository. Household survey data
are stored in feather format and have to be named with the country’s
name followed by a space and “data” (e.g., “Sri Lanka data”). Data on
country’s population by single age groups are stored in csv format and
have to be named as well by the country’s name followed by a space and
“pop data” (e.g., “Sri Lanka pop data”). Economic and government
finances data for all the countries are stored in two separate csv files
in the same directory: `./data/economic_data.csv` and
`./data/govfin.csv`.

### Household surveys

Household surveys are at the essence of the simulations produced by the
Tool. Only with microdata from household surveys are we able to infer on
hypothetical scenarios of what could have happened if the programmes
existed at the time of the survey.

In order for the Tool to read the microdata from the surveys, it is
required that the raw survey data are processed and standardized. The
processed data should include the following variables:

  - `hhid`: ***numerical*** variable which uniquely identifies eacg
    household captured by the household survey.
  - `weight`: ***numerical*** variable which corresponds to the
    household survey weight.
  - `rural`: ***numerical*** variable which identifies the place of
    residence of the household. The variable takes the value of 1 if
    located in rural areas and 0 if located in urban areas.
  - `hhsize`: ***numerical*** variable which takes the value of the
    number of members in the household.
  - `hhtype3`: ***character*** variable which groups the household
    according to the composition of its members. The variable considers
    the following eight categories: “Couple household, with children”,
    “Couple household, with no children”, “Single parent/caregiver
    (\<60 years)”, “One-person household, 60+ years”, “One-person
    household, 18-59 years”, “Three generation household”, “Skipped
    generation” and “Other household types”
  - `adj_factor`: ***numerical*** variable necessary when multiple
    poverty lines are considered in a given country. The variable will
    convert the welfare variable such that only one national poverty
    line is considered while respecting existing levels of poverty.
  - `adj_welfare`: ***numerical*** variable which represents the
    adjusted monthly household per capita welfare variable. For most
    countries the welfare variable consists of household consumption
    expenditure.
  - `pmt`: ***numerical*** variable which is the predicted welfare
    variable after regressing the log of `adj_welfare` on a number of
    observable household characteristics.
  - `decile`: ***numerical*** variable which groups households into ten
    equal groups according to the distribution of values of the welfare
    variable. The variable takes on values from 1 to 10, where 1
    represents the poorest decile, and 10 the richest decile.
  - `current_B`: ***numerical*** variable which identifies whether the
    household is a recipient of an existing household benefit. The
    variable takes on the value of 0 if not currently in receipt of a
    household benefit and 1 if in receipt.
  - `value_B`: ***numerical*** variable which corresponds to the monthly
    adjusted total household per capita amount of the household benefit.
  - `current_oldA`: ***numerical*** variable which identifies whether a
    household member is a recipient of an existing old age benefit. The
    variable takes on the value of 0 if not currently in receipt of an
    old age benefit and 1 if in receipt.
  - `value_oldA`: ***numerical*** variable which corresponds to the
    monthly adjusted total household per capita amount of the old age
    benefit.
  - `current_childA`: ***numerical*** variable which identifies whether
    a household member is a recipient of an existing child benefit. The
    variable takes on the value of 0 if not currently in receipt of a
    child benefit and 1 if in receipt.
  - `value_childA`: ***numerical*** variable which corresponds to the
    monthly adjusted total household per capita amount of the child
    benefit.
  - `current_disabA`: ***numerical*** variable which identifies whether
    a household member is a recipient of an existing disability benefit.
    The variable takes on the value of 0 if not currently in receipt of
    a disability benefit and 1 if in receipt.
  - `value_disabA`: ***numerical*** variable which corresponds to the
    monthly adjusted total household per capita amount of the disability
    benefit.
  - `disab`: ***numerical*** variable which identifies whether the
    household member has a disability or not. The variable takes on the
    value of 0 if the member does not have a disability and 1 if the
    member has a disability.
  - `age`: ***numerical*** variable which identifies the age, in
    completed years, of each household member.
  - `age5yrs`: ***numerical*** variable which groups the age of
    household members into five-year age groups. The variable takes the
    value of 0 if the household member is aged between 0 and 4, 1 if the
    member is aged between 5 and 9, and so on up to the value of 16 if
    the member is 80 years or over.
  - `sex`: ***numerical*** variable which identifies the sex of
    household members. The variable takes the value of 0 if male and 1
    if female.
  - `pension`: ***numerical*** variable which identifies if the person
    receives regular income from a pension scheme. The variable takes
    the value of 1 if individual receives regular pension, 0 otherwise.

The dataset should be at the person level and no variable should have
missing values. With the exception of the variables `disab`, `age`,
`age5yrs`, `sex` and `pension`, all other variables are measured at the
household level, meaning that their values should be the same across all
members of the household.

While data processing can be done using any data software, all the
processed datasets used in this tool have be produced using Stata,
following the template enclosed. The processed data are exported to csv
before transforming into a feather data file using R and the library
`feather`. The following code can be used to batch the conversion from
CSV to feather

``` r
library(feather)

for (i in c("Armenia",
            "Bangladesh",
            "Bhutan",
            "Cambodia",
            "Cook Islands",
            "Georgia",
            "India",
            "Indonesia",
            "Kiribati",
            "Kyrgyzstan",
            "Maldives",
            "Mongolia",
            "Nepal",
            "Pakistan",
            "Philippines",
            "Sri Lanka",
            "Thailand",
            "Viet Nam",
            "Turkey")) {
  feather <- read.csv(paste0("~/path to folder with csv files/", i, " data", ".csv"))
  write_feather(feather, paste0("app directory/data/", i, " data", ".feather"))
}
```

### Population data

For each country, population data from UN DESA’s World Population
Prospects are used to project programme budget. Annual data on projected
population by single age groups are extracted to a csv a file. The first
row in the data table should only include the names of the variables,
the first column should correspond to the calendar years and subsequent
columns should have the median projected population of each age group
from 0 to 100 in thousands. The projected years should cover all the
years considered in the Tool’s projections, i.e., 2021 - 2030. Excel
workbooks with data from UN DESA can be download from:
<https://population.un.org/wpp/Download/Standard/Interpolated/>.

#### Economic and government functional expenditure data

Economic and government functional expenditure data are stored on two
separate csv files. All economic data for each country is stored in a
csv called `economic_data`. The data table should include the country’s
name in the first column and a number of economic variables in
subsequent columns. Most economic data are from the IMF’s World Economic
Outlook (WEO) database. All variables in the data file are defined
below:

  - `Country`: ***character*** variable with name of the countries in
    the Tool.
  - `cpi11`: ***numerical*** variable with countries’ consumer price
    index in 2011 (IMF WEO).
  - `cpi_sy`: ***numerical*** variable with countries’ consumer price
    index in the year of the survey (IMF WEO).
  - `cpi21`: ***numerical*** variable with countries’ consumer price
    index in 2021 (IMF WEO).
  - `ppp11`: ***numerical*** variable with countries’ PPP conversion
    factor private consumption 2011 (World Bank).
  - `usd`: ***numerical*** variable with countries’ foreign exchange as
    local currency per USD (IMF WEO).
  - `govrev2021`: ***numerical*** variable with countries’ estimated
    government revenue in 2021 (IMF WEO).
  - `nationalpline`: ***numerical*** variable with countries’ national
    poverty line (surveys and official reports).
  - `gdp2021`: ***numerical*** variable with countries’ nominal GDP
    estimates for 2021 in billions (IMF WEO).
  - `gdpgrowth`: ***numerical*** variable with countries’ geometric
    average for GDP growth between 2022 and 2026 (calculation using IMF
    WEO).
  - `currency`: ***character*** variable with countries’ local currency
    three letter code.

Data on taxes and government finances for each country are in a csv file
called `govfin_data`, and, similar to the economic data file, the first
column includes the names of the countries. The other variables holds
information on government functional expenses and taxation. All
variables in the data file are defined below:

  - `country`: ***character*** variable with name of the countries used
    in the Tool.
  - `def`: ***numerical*** variable with countries’ government
    functional expenditure on defense as percentage of GDP.
  - `econ`: ***numerical*** variable with countries’ government
    functional expenditure on economic affairs as percentage of GDP.
  - `educ`: ***numerical*** variable with countries’ government
    functional expenditure on education as percentage of GDP.
  - `envir`: ***numerical*** variable with countries’ government
    functional expenditure on environment protection as percentage of
    GDP.
  - `gen`: ***numerical*** variable with countries’ government
    functional expenditure on general public services as percentage of
    GDP.
  - `health`: ***numerical*** variable with countries’ government
    functional expenditure on health as percentage of GDP.
  - `house`: ***numerical*** variable with countries’ government
    functional expenditure on housing and community amenities as
    percentage of GDP.
  - `safety`: ***numerical*** variable with countries’ government
    functional expenditure on public order and safety as percentage of
    GDP.
  - `culture`: ***numerical*** variable with countries’ government
    functional expenditure on recreation, culture, and religion as
    percentage of GDP.
  - `socprot`: ***numerical*** variable with countries’ government
    functional expenditure on social protection as percentage of GDP.
  - `income_t`: ***numerical*** variable with countries’ highest
    household income tax bracket.
  - `corporate_t`: ***numerical*** variable with countries’ highest
    corporate tax bracket.
  - `tax_burden`: ***numerical*** variable with countries’ total tax
    revenue as percentage of GDP.

Please see the technical note for the different sources used. Government
functional expenses data are from the IMF.

## Documentation files

There are two csv tables that feed into the Tool and which relate to the
Tool’s technical background. In the `./documentation` folder, the
`existingProg.csv` lists for every country all the existing programmes
considered by the Tool. If a new country is added to the Tool, it is
important to add the new country and the information of all relevant
existing programmes captured by the survey to this file.

The second csv table is for the **Glossary** page. The page renders a
data table with the information contained in the `glossary.csv` file.
Any tweak or addition of the new terms should be altered in this file.

## HTML files

Two pages in the tool were coded directly in HTML instead of using R.
These pages can be found in the folder `./www/htmls` and are for the
about and for the landing pages. Any changes to these pages will have to
be done in HTML in the corresponding files. The landing page was
designed by ESCAP and the about HTML page was knitted using the R
Markdown file `./documentation/about.Rmd`.

# Structure of the R files

With the exception of the main `app.R` file, all R scripts are in the
`./R` folder. The scripts are mainly divided into user interface (ui)
and server scripts. Server scripts are scripts which go in the server
section of the main `app.R` file and ui scripts go in the ui section.
There are also other auxiliary scripts that are used to define objects
that do not need to be defined within the Shiny framework or are
function objects used throughout the different scripts. Finally, there
are the scripts used to modularize the Shiny app. Below we describe the
purpose of the scripts and the key objects constructed in each of the
scripts following the flow of the `app.R` script.

First, it should be noted that the Tool was developed and tested using
**R version 3.6.2 (2019-12-12) – “Dark and Stormy Night”**. Also the
following packages and its dependencies are required to run the app
locally.

``` r
library(shiny)
library(DT)
library(ggplot2)
library(plotly)
library(scales)
library(shinycssloaders)
library(shinyjs)
library(shinyBS)
library(markdown)
library(rmarkdown)
library(feather)
library(shinyWidgets)
library(dplyr)
library(readr)
library(stringr)
library(ggthemes)
library(lubridate)
```

## Preamble

Before the ui and server sections are executed in the `app.R` script,
the code loads all the scripts in the `./R/0_preamble` and
`./R/4_module` folders, which are mostly creating non-reactive objects
and Shiny modules used in Tool.

``` r
############ 0 Preamble #########################

  # Load data and information of countries in tool
  source("./R/0_preamble/about.R")

  # Load functions
  source("./R/0_preamble/loadFunctions.R")

  # Load modules
  source("./R/4_modules/scnA/covModule.R")
  source("./R/4_modules/scnA/expModule.R")
  source("./R/4_modules/scnA/povModule.R")
  source("./R/4_modules/scnA/costModule.R")
  source("./R/4_modules/scnA/finModule.R")
  source("./R/4_modules/scnA/topTabModule.R")

  source("./R/4_modules/scnB/covModule.R")
  source("./R/4_modules/scnB/expModule.R")
  source("./R/4_modules/scnB/povModule.R")
  source("./R/4_modules/scnB/costModule.R")
  source("./R/4_modules/scnB/finModule.R")
  source("./R/4_modules/scnB/topTabModule.R")

  source("./R/4_modules/summary/covModule.R")
  source("./R/4_modules/summary/expModule.R")
  source("./R/4_modules/summary/povModule.R")
  source("./R/4_modules/summary/costModule.R")
  source("./R/4_modules/summary/topTabModule.R")
```

  - The `./R/0_preamble/about.R` script creates objects which provides
    information and data about the countries in the tool. For example,
    the vector with the names of all the countries used in the tool and
    which form the drop-down list in the Tool with all the countries
    will be included in this script. It is important to update the
    objects in this script when adding new countries to the tool.

  - The `./R/0_preamble/loadFunctions.R` script loads functions created
    to plot the graphs and construct inequality metrics. These functions
    are sourced from R scripts in the `./R/3_functions` folder. Any
    changes to the plots on costs, coverage, household consumption and
    poverty, which have all be done using the `ggplot2` package, will
    need to be done in the scripts: `./R/3_functions/plotCost.R`,
    `./R/3_functions/impactCov.R`, `./R/3_functions/impactExp.R`, and
    `./R/3_functions/impactPov.R`, respectively.

  - Shiny modules have been used to develop the different pages across
    the results tabs in the Tool. The tabs under **Step 3** in the
    Tool–which show the results for selected programmes–are scripted
    in the `topTabModule.R` modules which call the modules for the
    result tabs (“Coverage”, “Household Consumption”, “Poverty and
    Inequality” and “Costs”) under **Step 4** in the Tool. All scripts
    for Shiny modules have been saved in the folder `./R/4_modules`
    separately for **Scenario A**, **Scenario B** and the **Summary**
    pages.

## User interface

The user interface (UI) chunk (below) creates two functions for the UI
which are sourced from two different scripts.

``` r
############ 1 UI       #########################

  # Transition: landing page to main page
  mainPage = FALSE
  
  # UI 1 (Landing page)
  ui1 <- function() {
    source("./R/1_ui/ui1.R")$value
  }
  
  # UI 2 (Main page)
  ui2 <- function() {
    source("./R/1_ui/ui2.R")
  }

  ui = (uiOutput("page"))
```

  - The `ui1` function scripted in `./R/1_ui/ui1.R` processes the HTML
    template for the landing page (`landing.html`) found in the
    `./www/htmls` folder. The script also adds to the HTML template the
    inputs required to run the simulations.

  - The `ui2` function scripted in `./R/1_ui/ui2.R` loads the main page
    after the user transitions from the landing page to the main page.
    The main page is created using fluid layout and the tabs in the main
    page are defined using the `tabPanel` function and arguments from
    the Shiny package. Also from the Shiny package, the main page also
    uses `navbarPage` function to create a page with top level
    navigation bar and footer.

  - Finally, a logical object `mainPage` with initial value `FALSE` is
    created. This object is then used to transition the user of the tool
    from the landing page to the main page. This is also done on the
    server side where the `"page"` ui output is defined.

## Server

The server code runs all the necessary scripts to produce the outputs
and perform the actions required in the Tool. There are three parts to
the server chunk. The first part loads all the necessary scripts to run
the main page of the tool. The second part executes the transition
between landing and main pages after the user of the tool hits **Go**.
Finally, the server runs all event handlers of the type `observeEvent`.

### Main page

The main scripts used to run the tool are loaded from
`./R/2_server/scnAserver.R`, `./R/2_server/scnBserver.R` and
`./R/2_server/summaryserver.R`. In these scenario server, the scripts
load and process all the data and simulate the results presented in the
tabs of **Step 4**. The `./R/2_server/glossaryserver.R` and
`./R/2_server/aboutserver.R` sourced scripts produce all the outputs
required in the glossary and about pages respectively and which are
mostly rendered tables.

``` r
############ 2 Server   #########################
server = (function(input, output, session) {
  # options(shiny.reactlog=TRUE)
  
  #### Main Page (tool) ####

  ### Scenario A ####
  source("./R/2_server/scnAserver.R", local = TRUE)$value
  
  ### Scenario B ####
  source("./R/2_server/scnBserver.R", local = TRUE)$value
  
  ### Summary ####
  source("./R/2_server/summaryserver.R", local = TRUE)$value
  
  ##### Glossary page ####
  source("./R/2_server/glossaryserver.R", local = TRUE)$value
  
  ##### About page ####
  source("./R/2_server/aboutserver.R", local = TRUE)$value
```

The four main scripts executed when running the scenario server scripts
are:

1.  `dataServer.R`: this script loads all the data files (described
    above) utilized under each scenario in the script. In this script,
    the input data are read and transformed into reactive objects which
    are mostly data frames and specific to the selected country, such
    that every time users of the tool select a different country, the
    objects are updated.

2.  `params.R`: this script defines the default values of all the
    parameters to be inputted by the user of the tool. The values are
    created as reactive values and are updated once users alter its
    value.

3.  `dataCosts.R`: this script calculates the projected costs of the
    selected programmes once parameters have been defined by the user of
    the tool. The main reactive object in this script is the
    `costs_data` which is a data frame and contains all the projected
    costs.

4.  `dataImpact.R`: this script simulates the impacts on coverage,
    consumption and poverty of the selected programmes once parameters
    have been defined by the user of the tool. The script first
    constructs a reactive data frame, `impact_data`, which is the final
    processed data linked to the inputs selected by the user of the
    tool. The tool then produces the summary data which feed the plots
    in the results tabs by age groups, urban-rural and type of
    household.

The reactive objects created in `dataCosts.R` and `dataImpact.R` are
then read by modules when called in the `topTabModule.R` modules and
transformed into text, table and graph outputs.

The other scripts sourced in the scenario servers mostly relate to
dynamic UI outputs used in the construction of the main page and sidebar
of the tool.

### Changing UI

This part of the server code performs the transition from the UI
function for the landing page to the UI function of the main page after
the user hits **Go**.

``` r
  ##### Changing UI ####
  
  output$runbutton <- renderUI({
    if ((cparam$child == TRUE || 
         dparam$disab ==TRUE || 
         oparam$old==TRUE) || 
        (!is.null(input$meanstested) && input$meanstested==TRUE)) {
      actionButton(
        "run",
        "Go",
        icon = icon("check-circle"),
        style = "color: white;background-color: #02B481;"
      )
    } else {
      actionButton(
        "run_no",
        "Go",
        icon = icon("check-circle"),
        style = "color: white;background-color: #02B481;"
      )
    }
  })
  
  transition <- reactiveValues(mainPage = mainPage)
  
  # Change from landing page to main page
  observeEvent(input$run,{
      transition$mainPage <- TRUE
  })
  
  # Change UI
  observe({
    if (transition$mainPage == FALSE) {
      output$page <- renderUI({
        do.call(bootstrapPage, c("", ui1()))
      })
    }
    if (transition$mainPage == TRUE)
    {
      output$page <- renderUI({
        div(class = "outer", do.call(bootstrapPage, c("", ui2())))
      })
    }
  })
  
  observeEvent(input$run, updateQueryString("?page=tool", mode = "push"))
```

### Event handlers

The last part of the server chunk in `app.R` deals with the numerous
observe actions found in the tool. These are event handlers that carry
out actions after users of tool select certain actions (e.g., press on a
link or action button).

``` r
  ##### Observe actions ####
  
  #move page up after landing page
  observeEvent(input$run, {
    js$return();
  })
  
  #Scenario A
  #change tab to about
    observeEvent(input$link_to_about , {
      updateTabsetPanel(session, "menu", selected = "about")
      js$return()
    })
  #move page up when clicking on return
  observeEvent(input$return, {
      js$return()
  }) 
  #change tab to scn B
  observeEvent(input$link_to_scen_b , {
    updateTabsetPanel(session, "maintabs", selected = "Scenario B")
    js$return()
  })
  #Scenario B
  #change tab to about
  observeEvent(input$link_to_about_b , {
    updateTabsetPanel(session, "menu", selected = "about")
    js$return()
  })
  #move page up when clicking on return
  observeEvent(input$return_b, {
    js$return()
  })
  #change tab to compare
  observeEvent(input$link_to_compare_b , {
    updateTabsetPanel(session, "maintabs", selected = "Compare")
    js$return()
  })
  #Summary Scenario
  #change tab to about
  observeEvent(input$link_to_about_c , {
    updateTabsetPanel(session, "menu", selected = "about")
    js$return()
  })
  #move page up when clicking on return
  observeEvent(input$return_c, {
    js$return()
  }) 
  
  #Conditional tabs
  
  #Scenario A
  observeEvent(input$run, {
    toggle(condition = (cparam$child),
           selector = "#navbar li a[data-value=childbenefit_tab_A]")
  })
  observeEvent(input$run, {
    toggle(condition = (dparam$disab),
      selector = "#navbar li a[data-value=disabilitybenefit_tab_A]")
  })
  observeEvent(input$run, {
    toggle(condition = (oparam$old),
           selector = "#navbar li a[data-value=oldagebenefit_tab_A]")
  })
  observeEvent(input$run, {
    toggle(condition = (input$meanstested),
           selector = "#navbar li a[data-value=hhbenefit_tab_A]")
  })
  
  #Scenario B
  observeEvent(input$run_b, {
    shinyjs::show("mainpanel_b")
  })
  
  observeEvent(input$run_b, {
    toggle(condition = (cparam_b$child),
           selector = "#navbar_b li a[data-value=childbenefit_tab_b]")
  })
  observeEvent(input$run_b, {
    toggle(condition = (dparam_b$disab),
           selector = "#navbar_b li a[data-value=disabilitybenefit_tab_b]")
  })
  observeEvent(input$run_b, {
    toggle(condition = (oparam_b$old),
           selector = "#navbar_b li a[data-value=oldagebenefit_tab_b]")
  })
  observeEvent(input$run_b, {
    toggle(condition = (param_b$hh),
           selector = "#navbar_b li a[data-value=hhbenefit_tab_b]")
  })
  
  #Summary Scenario
  observeEvent(input$run_b, {
    toggle(condition = (cparam$child || cparam_b$child),
           selector = "#navbar_c li a[data-value=childbenefit_tab_c]")
  })
  observeEvent(input$run_b, {
    toggle(condition = (dparam$disab || dparam_b$disab),
           selector = "#navbar_c li a[data-value=disabilitybenefit_tab_c]")
  })
  observeEvent(input$run_b, {
    toggle(condition = (oparam$old || oparam_b$old),
           selector = "#navbar_c li a[data-value=oldagebenefit_tab_c]")
  })
  observeEvent(input$run_b, {
    toggle(condition = (param$hh || param_b$hh),
           selector = "#navbar_c li a[data-value=hhbenefit_tab_c]")
  })
  observeEvent(input$run_b, {
    shinyjs::show("tabsetpanel_c")
  })

})
```

After the server code is executed in `app.R`, the app object is created
using the `shinyapp` function with the `ui` and `server` functions
constructed in their respective parts as arguments.

``` r
############ Deploy ########################################
shinyApp(ui = ui, server = server)
```

# Development and final considerations

This version of the app was developed throughout 2019-2020 by
Development Pathways on behalf of ESCAP.

If using the latest version of R (**4.1.2 (Bird Hippie)**), to run
locally, the user will need to remove `else return()` from the event
handlers in the scripts in both scenarios which define and update the
selected parameters in the tool (`params.R`).
