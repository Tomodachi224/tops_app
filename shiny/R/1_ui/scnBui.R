#scenario A

######## TITLE
tagList(
h1(textOutput("title_b")),
sidebarLayout(
  # Sidebar with setup inputs
  div(id = "setup_panel_b",
      column(
        12,
        br(),
        br(),
        bsButton(
          "showpanel_b",
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
          id = "Sidebar_b",
          uiOutput("sidebar_b"),
          conditionalPanel(
            condition = "input.country_b != ''",
            wellPanel(
              ## Assumptions
              checkboxInput(
                inputId = "assumptions_b",
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
                  condition = "input.assumptions_b==true",
                    uiOutput("gdpgrowthrate_b")
                )
              }),
            column(
              4,
              uiOutput("runbutton2_b")
            ),
            column(4,
                   uiOutput("reportDownload_b")),
            column(
              4,
              actionButton(
                "resetAll_b",
                "Reset",
                icon = icon("trash"),
                style = "color: white;background-color: #F36E58 ;"
              )
            ),
            br(),
            span(textOutput("downloadFail_b"), style = "color:red"),
            br(),
            br()
          ))
      }),
  # Show a plot of the generated distribution
  div(id = "mainpanel_b",
  mainPanel(
    id = "Main_B",
    conditionalPanel(
      condition = "input.run_b != 0",
    h5(tags$b("Explore results by programme")),
    ######## TABS
    uiOutput("TopTabSetup_b"),
    br(),
        p("Compare these results with Scenario A", actionLink("link_to_compare_b", "here."))
    ),
    br(),
    div(
      id = "footer_main",
      extendShinyjs("www/app-shinyjs.js", functions = c("return")),
      p(
        "For more information on calculations see documentation ",
        actionLink("link_to_about_b", "here."), 
        "Return to the top", 
        actionLink("return_b", "here.")
      )
    )
  )) %>% shinyjs::hidden()
)
)