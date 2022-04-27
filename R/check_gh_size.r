# dir_size: main function to check size of a directory
dir_size <- function(path, recursive = TRUE) {

  # error message class
  if (class(x) != "character") stop("class is not character")
  files <- list.files(path, full.names = T, recursive = T)
  
  if (length(files)==0) {
    size_files <- file.size(path)
# Error message
    stop("no file found")

  } else {
    vect_size <- sapply(files, function(x) file.size(x))
    size_files <- sum(vect_size)
  }
  #return output
  return(size_files)
}
