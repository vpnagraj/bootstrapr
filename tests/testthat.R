library(testthat)
library(bootstrapr)

# need to set option for cran repo for testthat
r <- getOption("repos")
r["CRAN"] <- "https://cran.rstudio.com"
options(repos = r)

test_check("bootstrapr")
