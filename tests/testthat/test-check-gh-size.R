test_that("class of path is not character warning works", {
    expect_error(
        object = ghBackup::dir_size(path = 0),
        regexp = "class of the path is not character"
    )

})
test_that("directory size function works", {
  expect_equal(object = dir_size(path=system.file("extdata", package="ghBackup")), expected = 4.8e-5, tolerance = 0.1)
})

