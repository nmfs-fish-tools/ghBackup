## example_task_schedule.R
## This R script allows users to automate backup workflow on specific
## time on Windows. See taskscheduleR vignette (https://cran.r-project.org/web/packages/taskscheduleR/vignettes/taskscheduleR.html) for more details.

# Install packages ------------------------------------------------

required_pkg <- c("taskscheduleR")

pkg_to_install <- required_pkg[!(required_pkg %in%
  installed.packages()[, "Package"])]
if (length(pkg_to_install)) install.packages(pkg_to_install)
lapply(required_pkg, library, character.only = TRUE)


# Schedule task ---------------------------------------------------

task_script <- system.file(
  "extdata", "example_back_up_gh.R",
  package = "ghBackup"
)

# Run every 5 mins, starting from within 60 seconds
taskscheduleR::taskscheduler_create(
  taskname = "ghBackup_5min",
  rscript = task_script,
  schedule = "MINUTE",
  startdate = format(Sys.Date(), "%m/%d/%Y"),
  starttime = format(Sys.time() + 60, "%H:%M"),
  modifier = 5
)

# Run every week on Wednesday at 11:00 am
taskscheduleR::taskscheduler_create(
  taskname = "ghBackup_weekly",
  rscript = task_script,
  schedule = "WEEKLY",
  starttime = "11:00",
  days = c("WED")
)
