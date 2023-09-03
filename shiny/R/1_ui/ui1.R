#UI of landing page

htmlTemplate(
  "www/htmls/landing.html",
  preamble = tagList(
    useShinyjs(),
    extendShinyjs("www/app-shinyjs.js", functions = c("return")),
    setSliderColor(rep(c("#0475BB"), times = 200), c(1:200)),
    chooseSliderSkin("Flat")),
   landsidebar = div(
     uiOutput("sidebar"),
     conditionalPanel(
       condition = "input.country != '' && (input.meanstested==true || input.matbenefit==true || input.childbenefit==true || input.disabilitybenefit==true || input.oldagebenefit==true)",
       conditionalPanel(
         condition = "input.country != ''",
         wellPanel(
           ## Assumptions
           checkboxInput(
             inputId = "assumptions",
             label = "Assumptions underpinning the spending projections",
             value = FALSE
             # ,
             # bigger = TRUE,
             # icon = icon("check"),
             # status = 'primary',
             # fill = TRUE,
             # thick = TRUE
           ),
           conditionalPanel(
             condition = "input.assumptions==true",
               uiOutput("gdpgrowthrate")
           )
         ), 
           uiOutput("runbutton")
         )
       )
     )
   )