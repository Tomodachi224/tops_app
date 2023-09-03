### About page

output[['disababout']] = DT::renderDataTable({
  data <- disabAbout
  DT::datatable(
    data,
    rownames = FALSE,
    colnames = c("Disability", countrylist),
    options = list(
      autoWidth = TRUE,
      columnDefs = list(
        list(
          className = 'dt-center',
          targets = c(1:7),
          width = '200px'
        ),
        list(
          className = 'dt-left',
          targets = c(0),
          width = '500px'
        )
      ),
      dom = 't',
      ordering=F
    ),
    escape = FALSE
  )
})
output[['acronymsabout']] = DT::renderDataTable({
  data <- acronymsTable
  DT::datatable(
    data,
    rownames = FALSE,
    options = list(
      autoWidth = TRUE,
      columnDefs = list(
        list(
          className = 'dt-left',
          targets = c(0),
          width = '200px'
        ),
        list(
          className = 'dt-left',
          targets = c(1),
          width = '500px'
        )
      ),
      dom = 'ft',
      pageLength = 100
    ),
    escape = FALSE
  )
})

# PDF about
output$aboutPDF <- downloadHandler(
  filename = "About.pdf",
  content = function(file) {
    file.copy("./documentation/About.pdf", file)
  }
)