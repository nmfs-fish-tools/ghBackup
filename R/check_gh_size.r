# Check size of a directory
#
# @description
# The function uses identified path to check the size of given directory. It returns the total size of files in the directory.
# @importFrom (specified path)
#
# @param path The full path to directory to be sized
# @param full.names (needed? nested in function)
#
# @return Sum of files in directory
# @examples
# dir_size(
#   path= "C:\Users\gizelle.schmitz\Desktop", recursive= TRUE) (?)
#
#
# dir_size: main function to check size of a directory
dir_size <- function(path, recursive = TRUE) {

  # error message class
  if (class(path) != "character") stop("class of the path is not character")
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
