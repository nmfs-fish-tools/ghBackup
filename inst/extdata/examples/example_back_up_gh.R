## example_back_up_gh.R
## This R script allows users to back up GitHub repositories and upload
## clones of all repositories to a Google Drive folder.

# Install packages ------------------------------------------------

required_pkg <- c("remotes", "gh", "googledrive")

pkg_to_install <- required_pkg[!(required_pkg %in%
  installed.packages()[, "Package"])]
if (length(pkg_to_install)) install.packages(pkg_to_install)
lapply(required_pkg, library, character.only = TRUE)

remotes::install_github("Bai-Li-NOAA/ghBackup")
library(ghBackup)

# Back up GitHub repositories -------------------------------------

backup_path <- "C:/Users/test"

ghBackup::back_up_gh_orgs(
  gh_token = gh::gh_token(),
  backup_path = backup_path,
  orgs_name = c("nmfs-general-modeling-tools")
)


# Upload zip archives to Google Drive -----------------------------

# Thanks Kathryn Doering for providing the solution, this approach uses
# an auto auth setting so no interaction is needed.
# See gargle's "Non-interactive auth" vignette for more details:
# https://gargle.r-lib.org/articles/non-interactive-auth.html

options(gargle_oauth_email = "*@noaa.gov")

zip_name <- "ghBackup.zip"
zip_path <- file.path(dirname(backup_path), zip_name)
googledrive::drive_put(
  media = zip_path,
  path = googledrive::as_id("https://drive.google.com/drive/folders/1vju2qQ0dPh49Ay7VGaWv6CvGqMZsZKPc"),
  name = zip_name
)
