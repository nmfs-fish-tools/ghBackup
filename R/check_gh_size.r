#' Check size of a directory
#'
#' @description
#' The function uses identified path to check the size of given directory. It returns the total size of files in the directory
#'
#' @param path The full path to directory to be sized
#' @param recursive Operating on a directory and its contents, including the contents of any subdirectories
#'
#' @return Sum of size of files in directory
#' @export
#' @examples
#' \dontrun{
#' dir_size(
#'   path= "C:/Users/Desktop",
#'   recursive= TRUE)
#' )
#' }
#'
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
