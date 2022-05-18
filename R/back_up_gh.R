#' Back up GitHub organization repositories
#'
#' @description
#' The function uses gh_token to access GitHub API URL to download organization
#' repositories. It returns all backup materials in a folder on users'
#' local machine.
#' @importFrom utils download.file
#' @importFrom zip zip
#' @importFrom rjson fromJSON
#'
#' @param gh_token Token number from GitHub website.
#' @param backup_path Directory where backup materials are located.
#' @param orgs_name Name of the organization. A vector of names. Otherwise
#' the function will backup all organizations that are associated with
#' your account.
#'
#' @return Backup of GitHub repository in the directory where \code{backup_path} is
#' @export
#' @examples
#' \dontrun{
#' back_up_gh_orgs(
#'   gh_token = "abcdefghijklmnopqrstuvwxyz01234567890123",
#'   backup_path = "C:/Users/ghbackup/",
#'   orgs_name = c("nmfs-fish-tools", "nmfs-general-modeling-tools")
#' )
#' }
back_up_gh_orgs <- function(gh_token, backup_path, orgs_name=NULL) {
  if (is.null(gh_token)) {
    stop("Please provide GitHub token. gitcreds::gutcreds_set() is a nice tool to add new GitHub credentials or replacing existing ones in R. Please see details from gitcreds website: https://github.com/r-lib/gitcreds")
  }

  header_info <- paste("token", gh_token)

  if(!file.exists(backup_path)) {
    stop(paste(backup_path, "does not exist!"))
  }
  # Delete all files in the backup folder
  unlink(file.path(backup_path, "*"), recursive = T, force = T)

  if (is.null(orgs_name)) {
    orgs_name <- api_url <- "https://api.github.com/user/orgs"
  }

  if (length(orgs_name) > 1 | orgs_name != "https://api.github.com/user/orgs") {
    user_organizations_url <- paste0(
      "https://api.github.com/orgs/",
      orgs_name, "/repos"
    )
    user_organizations_name <- orgs_name
  } else {
    # Download a list of repo names in a json file
    orgs_data_dir <- file.path(backup_path, "orgs_data.json")
    utils::download.file(
      url = api_url,
      destfile = orgs_data_dir,
      headers = list(
        Authorization = header_info
      )
    )

    json_data <- rjson::fromJSON(file = orgs_data_dir)

    user_organizations_url <- sapply(1:length(json_data), function(x) {
      json_data[[x]]$repos_url
    })

    user_organizations_name <- sapply(1:length(json_data), function(x) {
      json_data[[x]]$login
    })
  }

  sapply(1:length(user_organizations_name), function(x) {
    dir.create(file.path(backup_path, user_organizations_name[x]))
  })

  # Download public repos

  for (org_id in 1:length(user_organizations_url)) {
    file_path <- file.path(
      backup_path,
      paste(user_organizations_name[org_id],
        "-public.json",
        sep = ""
      )
    )
    # Download repo list
    utils::download.file(
      url = paste(user_organizations_url[org_id], "?type=public&per_page=100", sep = ""),
      destfile = file_path,
      headers = list(
        Authorization = header_info
      )
    )


    json_data <- rjson::fromJSON(file = file_path)

    if (length(json_data) != 0) {
      repo_url <- sapply(1:length(json_data), function(x) {
        json_data[[x]]$ssh_url
      })

      repo_name <- sapply(1:length(json_data), function(x) {
        json_data[[x]]$name
      })

      # Clone repos
      for (repo_id in 1:length(repo_url)) {
        file_path <- file.path(backup_path, user_organizations_name[org_id], repo_name[repo_id])

        shell(paste("git clone", repo_url[repo_id], file_path))
      }
    }
  }

  # Download private repos

  for (org_id in 1:length(user_organizations_url)) {
    file_path <- file.path(
      backup_path,
      paste(user_organizations_name[org_id],
        "-private.json",
        sep = ""
      )
    )
    # Download repo list
    utils::download.file(
      url = paste(user_organizations_url[org_id], "?type=private&per_page=100", sep = ""),
      destfile = file_path,
      headers = list(
        Authorization = header_info
      )
    )

    json_data <- rjson::fromJSON(file = file_path)

    if (length(json_data) != 0) {
      repo_url <- sapply(1:length(json_data), function(x) {
        json_data[[x]]$ssh_url
      })

      repo_name <- sapply(1:length(json_data), function(x) {
        json_data[[x]]$name
      })

      # Clone repos
      for (repo_id in 1:length(repo_url)) {
        file_path <- file.path(backup_path, user_organizations_name[org_id], repo_name[repo_id])

        shell(paste("git clone", repo_url[repo_id], file_path))
      }
    }
  }


  zip::zip(zipfile = file.path(dirname(backup_path), "ghBackup.zip"), files = backup_path)
}
