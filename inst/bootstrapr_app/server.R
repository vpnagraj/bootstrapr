library(shiny)
library(bootstrapr)

shinyServer(function(input, output) {

  script <- reactive({

    if (is.null(input$package)) {

      c(setup(),
         dependencies(), "\nwget https://download2.rstudio.org/rstudio-server-0.99.903-amd64.deb\nsudo gdebi rstudio-server-0.99.903-amd64.deb")
      # "\nwget https://download2.rstudio.org/rstudio-server-0.99.903-amd64.deb\nsudo gdebi rstudio-server-0.99.903-amd64.deb"

    } else {

      c(setup(),
        dependencies(),
        sapply(input$package,
               function(x) paste0("\nsudo su - -c 'R -e \'install.packages('", x, "',repos='http://cran.rstudio.com/')\'"))
        ,"\n\nwget https://download2.rstudio.org/rstudio-server-0.99.903-amd64.deb\nsudo gdebi rstudio-server-0.99.903-amd64.deb")

      # c(
      #   sapply(input$package,
      #          function(x) paste0("\nsudo su - -c 'R -e \'install.packages('", x, "',repos='http://cran.rstudio.com/')\'"))
      #   ,"\n\nwget https://download2.rstudio.org/rstudio-server-0.99.903-amd64.deb\nsudo gdebi rstudio-server-0.99.903-amd64.deb")

    }
  })

  output$script <- renderText({

    script()

  })

  output$dlscript <- downloadHandler(

    filename = "bootstrap.sh",
    content = function(file) {
        writeLines(script(), file)
    }
  )

})
