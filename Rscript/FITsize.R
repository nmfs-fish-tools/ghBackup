# This R script check size of each tool directory
library(xlsx)

# dir_size: main function to check size of a directory
dir_size <- function(path, recursive = TRUE) {
  # error message class
  if (class(x) != "character") stop("class is not character")
  files <- list.files(path, full.names = T, recursive = T)
  #error message
  if (length(files)==0) {
    size_files <- file.size(path)
    #calculate size
  } else {
    vect_size <- sapply(files, function(x) file.size(x))
    size_files <- sum(vect_size)
  }
  #return output
  return(size_files)
}

# Provide path to the main directory
dir_path <- "C:\\Users\\bai.li\\Desktop\\FITbackup\\RtmpK6keDF"
output_file <- file.path(dirname(dir_path), "dir_size.xlsx")

# List files/subdirectories in the main directory
dir_files <- list.files(dir_path)
dir_data <- data.frame(
  folder_name = rep(NA, length(dir_files)),
  size_Mb = rep(NA, length(dir_files))
)

# Check size of organization repo --------------------------------------------

for (i in seq_along(dir_files)){

  dir_data$folder_name[i] <- dir_files[i]
  dir_data$size_Mb[i] <- dir_size(path = file.path(dir_path, dir_files[i]))/10**6

}

write.xlsx(dir_data, file = output_file,
           sheetName = "Organizations", append = FALSE)

# Check size of individual tool repo ----------------------------------------------

subdir <- grep(list.files(path=dir_path), pattern='.json', invert=TRUE, value=TRUE)

for (i in seq_along(subdir)){
  dir_files <- list.files(file.path(dir_path, subdir[i]))
  dir_data <- data.frame(
    folder_name = rep(NA, length(dir_files)),
    size_Mb = rep(NA, length(dir_files))
  )

  for (j in seq_along(dir_files)){

    dir_data$folder_name[j] <- dir_files[j]
    dir_data$size_Mb[j] <- dir_size(path = file.path(dir_path, subdir[i], dir_files[j]))/10**6

  }

  write.xlsx(dir_data, file = output_file,
             sheetName = subdir[i], append = TRUE)
}

