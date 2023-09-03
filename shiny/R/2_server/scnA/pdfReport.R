## Produce pdf (report.pdf)

output$reportPDF <- downloadHandler(
  # For PDF output, change this to "report.pdf"
  filename = "report.pdf",
  content = function(file) {
    # Copy the report file to a temporary directory before processing it, in
    # case we don't have write permissions to the current working dir (which
    # can happen when deployed).
    tempReport <- file.path(tempdir(), "report.Rmd")
    file.copy("report.Rmd", tempReport, overwrite = TRUE)
    
    params <- list(
      input_mattransfer = mparam$matTrans,
      input_childtransfer = cparam$childTrans,
      input_disabtransfer = dparam$disabTrans,
      input_oldtransfer = oparam$oldTrans,
      input_hhtransfer = hparam$hhTrans,
      input_mat_cov = mparam$matCov,
      input_child_cov = cparam$childCov,
      input_disab_cov = dparam$disabCov,
      input_old_cov = oparam$oldCov,
      input_mat_length = mparam$matLength,
      input_child_age = cparam$childAge,
      input_disab_age = dparam$disabAge,
      input_old_age = oparam$oldAge,
      input_hh_cov = hparam$hhCov,
      input_country = input$country,
      plot_graphcov_exp_pdf = plot_graphcov_exp_pdf(),
      plot_graphexp_all_pdf = plot_graphexp_all_pdf(),
      plot_graphexpen_pdf = plot_graphexpen_pdf(),
      plot_graphpov_pdf = plot_graphpov_pdf(),
      plot_graphgap_pdf = plot_graphgap_pdf(),
      plot_cost_pdf = plot_cost_pdf(),
      data_textfin1_pdf = data_textfin1_pdf(),
      plot_graphfin1_pdf = plot_graphfin1_pdf(),
      plot_graphfin2_pdf = plot_graphfin2_pdf(),
      data_textfin3_pdf = data_textfin3_pdf(),
      text_pdf = text_pdf(),
      data_textpovineq_pdf = data_textpovineq_pdf()
    )
    
    # Knit the document, passing in the `params` list, and eval it in a
    # child of the global environment (this isolates the code in the document
    # from the code in this app).
    rmarkdown::render(
      tempReport,
      output_file = file,
      params = params,
      envir = new.env(parent = globalenv())
    )
  }
)