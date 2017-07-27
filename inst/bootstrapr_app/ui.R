library(shiny)

cran_package_choices <- row.names(available.packages())
bioc_package_choices <- BiocInstaller::all_group()
instance_choices <- readLines("https://s3.amazonaws.com/instance-types/instance-types.json")

shinyUI(fluidPage(

  # Application title
  titlePanel("bootstrapr"),

  sidebarLayout(
    sidebarPanel(
      selectizeInput(inputId = "cranpackage",
                     label = h3("choose CRAN package(s) to be installed"),
                     choices = cran_package_choices,
                     multiple = TRUE),
      selectizeInput(inputId = "biocpackage",
                     label = h3("choose Bioconductor package(s) to be installed"),
                     choices = bioc_package_choices,
                     multiple = TRUE),
      downloadButton("dlscript", "download script"),
      tags$hr(""),
      actionButton("run", "run instance", icon = icon("power-off")),
      conditionalPanel(condition = "input.run == 1",
                         selectInput("instancetype",
                                     label = "instance type",
                                     choices = instance_choices,
                                     selected = "t2.medium"),
                         textInput("key", "key name"),
                         textInput("sg", "security group"),
                         actionButton("launch", "launch it!", icon = icon("rocket"))
                       )
    ),
    mainPanel(
      verbatimTextOutput("script", placeholder = TRUE)
    )
  )
))
