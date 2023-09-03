#scenario A

######## TITLE
tagList(
h1(textOutput("title")),
sidebarLayout(
  # Sidebar with setup inputs
  div(id = "setup_panel",
      column(
        12,
        br(),
        br(),
        bsButton(
          "showpanel",
          "",
          type = "toggle",
          value = TRUE,
          icon = icon("sliders")
        ),
        br(),
        br()
      ),
      {
        sidebarPanel(
          id = "Sidebar",
          uiOutput("sidebar"),
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
              {
                conditionalPanel(
                  condition = "input.assumptions==true",
                    uiOutput("gdpgrowthrate")
                )
              }),
            column(
              4,
              uiOutput("runbutton2")
            ),
            column(4,
                   uiOutput("reportDownload")),
            column(
              4,
              actionButton(
                "resetAll",
                "Reset",
                icon = icon("trash"),
                style = "color: white;background-color: #F36E58 ;"
              )
            ),
            br(),
            span(textOutput("downloadFail"), style = "color:red"),
            br(),
            br()
          ))
      }),
  # Show a plot of the generated distribution
 mainPanel(
    id = "Main_A",
    h5(tags$b("Explore results by programme")),
    ######## TABS
      uiOutput("TopTabSetup"),
    br(),
    p("Would you like to compare with a different programme or country? Build a new scenario here to compare the results ", actionLink("link_to_scen_b", "here.")),
    br(),
    div(
      id = "footer_main",
      extendShinyjs("www/app-shinyjs.js", functions = c("return")),
      p(
        "For more information on calculations see documentation ",
        actionLink("link_to_about", "here."), 
        "Return to the top", 
        actionLink("return", "here.")
      )
    )
  )
)
)