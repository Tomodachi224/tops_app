output[['glossaryTable']] = DT::renderDataTable({
  data <- read_csv("./documentation/glossary.csv", col_names =FALSE)
  DT::datatable(
    data,
    rownames = FALSE,
    colnames = c("Terms", "Definition"),
    options = list(
      autoWidth = TRUE,
      columnDefs = list(
        list(
          className = 'dt-left',
          targets = c(0),
          width = '100px'
        ),
        list(
          className = 'dt-left',
          targets = c(1),
          width = '500px'
        )
      ),
      pageLength = 25
    ),
    escape = FALSE
  )
})