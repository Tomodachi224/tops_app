#UI of main page

  tagList(
          div(
            id = "app-content",
            fluidPage(
              tags$head(HTML("<title>Social Protection Simulator</title>")),
              br(),
              br(),
              
              navbarPage(
                title = div(id = "logo", img(
                  src = "http://www.socialprotection-toolbox.org/themes/cantaloupe/logo.png",
                  #height = "35px",
                  style = "margin-top: -5px;margin-right:50px"
                )
                ),
                id = "menu",
                theme = "bootstrap.css",
                header = tagList(
                  useShinyjs(),
                  extendShinyjs("www/app-shinyjs.js", functions = c("return")),
                  extendShinyjs("www/app-shinyjs.js", functions = c("updateHistory"))
                ),
                footer =  tagList(
                  div( id="endnote",
                       p(tags$b("Note:"), "The model is a tool for guiding reforms in social protection programmes, rather than a tool that provides precise estimates of impact, costs and affordability.",
                         align='center'),
                      htmlOutput("citation")
                  ),
                    HTML('
                         <div id="footer">
                         <div class="region-footer container clearfix">
                         <div style="float:left;">
                         <a href="http://www.unescap.org/our-work/social-development/inequality-and-social-protection" target="_blank"><img src="https://www.socialprotection-toolbox.org/files/images/logo-escap-color.png"></a>
                         </div>
                         <div style="float:right;">Copyright © 2019 ESCAP - Social Development Division</div>
                         </div>
                         </div>')
                    ),
                tabPanel(
                  "Tool",
                  br(),
                  br(),
                  tabsetPanel(
                    id = "maintabs",
                    type = 'tabs',
                    tabPanel(
                      "Scenario A",
                      source("./R/1_ui/scnAui.R", local = TRUE)$value
                  ),
                  tabPanel(
                    "Scenario B",
                    source("./R/1_ui/scnBui.R", local = TRUE)$value
                  ),
                  tabPanel(
                    "Compare",
                    source("./R/1_ui/summaryui.R", local = TRUE)$value
                  )
     
                )
                ),
                tabPanel(
                  title = "Glossary",
                  value = "glossary",
                  source("./R/1_ui/glossaryPage.R", local = TRUE)$value
                ),
                tabPanel(
                  title = "About",
                  value = "about",
                  source("./R/1_ui/aboutPage.R", local = TRUE)$value
                )
                #  ,
                # ###### DATA CHECKS TAB
                #  tabPanel("Checks",
                #          DT::dataTableOutput('datatest')
                #  )
                )
              )
            )
          )