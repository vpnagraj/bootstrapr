context("packages")

test_that("user cannot specify package not in CRAN", {

  expect_error(bootstrapr(cran = "thisisnotapackage"))

})
