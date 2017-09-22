context("packages")

test_that("user cannot specify package not in CRAN", {

  expect_error(bootstrapr(cran = "thisisnotapackage"))

})

test_that("package appears in bootstrapping script", {

  isthere <- grepl("dplyr", bootstrapr(cran = "dplyr", write = FALSE))
  expect_true(isthere)

})

context("dependencies")

test_that("rstudio server and shiny server include args work", {

  isthere <- grepl("rstudio-server", bootstrapr(rstudio_server = FALSE, write = FALSE))
  expect_false(isthere)

  isthere <- grepl("shiny-server", bootstrapr(shiny_server = FALSE, write = FALSE))
  expect_false(isthere)

})
