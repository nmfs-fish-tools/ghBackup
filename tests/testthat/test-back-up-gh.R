temp_dir <- tempdir()

test_that("back_up_gh_orgs() stops on error", {
  testthat::expect_error(
    back_up_gh_orgs(
      gh_token = NULL,
      backup_path = temp_dir,
      orgs_name = c("nmfs-general-modeling-tools")
    )
  )


  testthat::expect_error(
    back_up_gh_orgs(
      gh_token = gh::gh_token(),
      backup_path = "dir",
      orgs_name = c("nmfs-general-modeling-tools")
    )
  )
})

test_that("back_up_gh_orgs() clones repos and creates zip archives", {
  back_up_gh_orgs(
    gh_token = gh::gh_token(),
    backup_path = temp_dir,
    orgs_name = c("nmfs-general-modeling-tools")
  )

  zip_path <- file.path(dirname(temp_dir), "ghBackup.zip")
  on.exit(unlink(zip_path), add = TRUE)

  testthat::expect_true(
    file.exists(zip_path)
  )
})
