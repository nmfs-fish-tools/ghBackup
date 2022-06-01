test_that("class of path is not character warning works", {
    expect_error(
        object = ghBackup::dir_size(path = 0),
        regexp = "class of the path is not character"
    )

})