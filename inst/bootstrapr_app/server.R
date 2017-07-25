library(shiny)
library(bootstrapr)

shinyServer(function(input, output) {

  script <- reactive({

    if (is.null(input$cranpackage) & is.null(input$biocpackage)) {

      bootstrapr()

    } else {

      bootstrapr(cran = input$cranpackage, bioc = input$biocpackage)

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

  observeEvent(input$launch, {

    withProgress(message = "provisioning",
                 detail = '...', value = 0, {
                   for (i in 1:50) {
                     incProgress(1/50)
                     Sys.sleep(0.25)
                   }

                   metadat <- aws.ec2::run_instances("ami-80861296",
                                                     type = input$instancetype,
                                                     keypair = input$key,
                                                     sgroup = input$sg,
                                                     userdata = caTools::base64encode(script()))


                   id <- unlist(metadat)["item.instanceId"]

                   Sys.sleep(30)

                   info <- aws.ec2::describe_instances(id)

                   publicip <- unlist(info[[1]])["instancesSet.networkInterfaceSet.association.publicIp"]
                   showNotification(paste0("your instance is available at: ", publicip),
                                    type = "message",
                                    duration = NULL)

                 })
  })

})
