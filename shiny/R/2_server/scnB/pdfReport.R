## Produce pdf (report.pdf)

output$reportPDF_b <- downloadHandler(
  # For PDF output, change this to "report.pdf"
  filename = "report.pdf",
  content = function(file) {
    # Copy the report file to a temporary directory before processing it, in
    # case we don't have write permissions to the current working dir (which
    # can happen when deployed).
    tempReport <- file.path(tempdir(), "report_b.Rmd")
    file.copy("report_b.Rmd", tempReport, overwrite = TRUE)
    
    params <- list(
      input_mattransfer = mparam_b$matTrans,
      input_childtransfer = cparam_b$childTrans,
      input_disabtransfer = dparam_b$disabTrans,
      input_oldtransfer = oparam_b$oldTrans,
      input_hhtransfer = hparam_b$hhTrans,
      input_mat_cov = mparam_b$matCov,
      input_child_cov = cparam_b$childCov,
      input_disab_cov = dparam_b$disabCov,
      input_old_cov = oparam_b$oldCov,
      input_mat_length = mparam_b$matLength,
      input_child_age = cparam_b$childAge,
      input_disab_age = dparam_b$disabAge,
      input_old_age = oparam_b$oldAge,
      input_hh_cov = hparam_b$hhCov,
      input_country = input$country_b,
      plot_graphcov_exp_pdf = plot_graphcov_exp_pdf_b(),
      plot_graphexp_all_pdf = plot_graphexp_all_pdf_b(),
      plot_graphexp_ben_pdf = plot_graphexp_ben_pdf_b(),
      plot_graphpov_pdf = plot_graphpov_pdf_b(),
      plot_graphgap_pdf = plot_graphgap_pdf_b(),
      plot_cost_pdf = plot_cost_pdf_b(),
      data_textfin1_pdf = data_textfin1_pdf_b(),
      plot_graphfin1_pdf = plot_graphfin1_pdf_b(),
      plot_graphfin2_pdf = plot_graphfin2_pdf_b(),
      data_textfin3_pdf = data_textfin3_pdf_b(),
      text_pdf = text_pdf_b(),
      data_textpovineq_pdf = data_textpovineq_pdf_b()
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