ghBackup
=========

ghBackup is an R package that backs up your GitHub repositories. It uses 
GitHub personal access token to clone repositories from a GitHub 
organization and save the files in the destination directory.
[Simple examples](https://bai-li-noaa.github.io/ghBackup/articles/) on how to back up repositories and upload backup files 
to a Google Drive folder on a schedule are provided. 

# Installation

```r
remotes::install_github("Bai-Li-NOAA/ghBackup")
```
# Usage
 
```r
library(ghBackup)
```

Use `ghBackup::back_up_gh_orgs()` to download clones of all public and 
private repositories of an organization your token can access. Clones of
all repositories will be saved in the destination directory
`C:/Users/ghbackup/` and a zip archives of clones of all repositories 
will be created under parent directory `C:/Users/`.

```r
ghBackup::back_up_gh_orgs(
  gh_token = gh::gh_token(),
  backup_path = "C:/Users/ghbackup/"",
  orgs_name = c("nmfs-general-modeling-tools")
)
```
# Need Help?

Get questions answered in 
[issues](https://github.com/Bai-Li-NOAA/ghBackup/issues) or submit bug 
reports and feature requests to issues. 

**Disclaimer**

“The United States Department of Commerce (DOC) GitHub project code is
provided on an ‘as is’ basis and the user assumes responsibility for its
use. DOC has relinquished control of the information and no longer has
responsibility to protect the integrity, confidentiality, or
availability of the information. Any claims against the Department of
Commerce stemming from the use of its GitHub project will be governed by
all applicable Federal law. Any reference to specific commercial
products, processes, or services by service mark, trademark,
manufacturer, or otherwise, does not constitute or imply their
endorsement, recommendation or favoring by the Department of Commerce.
The Department of Commerce seal and logo, or the seal and logo of a DOC
bureau, shall not be used in any manner to imply endorsement of any
commercial product or activity by DOC or the United States Government.”
