# About page

tagList(
  tags$iframe(src = './htmls/about.html', # put myMarkdown.html to /www
              width = '100%', height = '800px', 
              frameborder = 0, scrolling = 'yes'
  ),
  div(
    br(),
    h4("Download extended methodological notes"), downloadButton(
    "aboutPDF",
    "PDF",
    icon = icon("download"),
    style = "color: white;background-color: #02B481;"
  ), align = "center")
)
  