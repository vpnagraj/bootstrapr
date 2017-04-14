# get all packages from CRAN
# multiple text input with choices ^

# something similar for bioconductor

# multiple text input with free text for GH

# output raw text and download button

# write package to automate this?

package_choices <- row.names(available.packages())


library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("bootstrapr"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectizeInput(inputId = "package", 
                     label = h3("choose package(s) to be installed"), 
                     choices = package_choices,
                     multiple = TRUE),
      downloadButton("dlscript", "download script")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      verbatimTextOutput("script", placeholder = TRUE)
    )
  )
))
