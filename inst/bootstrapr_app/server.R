library(shiny)

dependencies <- function(deps = NULL, update = TRUE) {

  # combine specified deps with baseline
  deps <- c(deps,
            "r-base",
            "libapparmor1",
            "libcurl4-gnutls-dev",
            "libxml2-dev",
            "libssl-dev",
            "gdebi-core",
            "libcairo2-dev",
            "libxt-dev",
            "git-core")

  res <- sapply(deps,
                function(x) paste0("\nsudo apt-get -y install ", x, collapse = "\n"))

  if(update) {
    # cat(paste0("sudo apt-get update ",res, collapse = "\n"))
    # cat(c("sudo apt-get update\n",res))
    c("sudo apt-get update\n",res)

  } else {
    # cat(res)
    res
  }

}

setup <- function() {

  "sudo sh -c 'echo 'deb http://cran.rstudio.com/bin/linux/ubuntu trusty/' >> /etc/apt/sources.list'\ngpg --keyserver keyserver.ubuntu.com --recv-key E084DAB\ngpg -a --export E084DAB9 | sudo apt-key add -\n"

}

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
