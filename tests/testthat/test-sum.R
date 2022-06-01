test_that("sum works with a vector that has more than 1 number", {
    a <- c(1, 2)
    testthat::expect_equal(ghBackup::sum(a), 3)

    b <- c(1, 2, 5, 10)
    testthat::expect_equal(ghBackup::sum(b), 18)

    c <- c(2)
    testthat::expect_error(ghBackup::sum(c), "vector x needs to have at least two numbers!")
})

test_that("sum does not work with non numeric values", {
    a <- c("a", "b", "c")
    testthat::expect_error(ghBackup::sum(a))
})

test_that("directory size is equal to sum", {
  testthat::expect_equal(object = dir_size(path=”example_file”), expected = 0.3, tolerance = 0.1)
})
