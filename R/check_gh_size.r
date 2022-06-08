#' Check size of a directory
#'
#' @description
#' The function uses identified path to check the size of given directory. It returns the total size of files in the directory
#'
#' @param path The full path to directory to be sized
#'
#' @return Sum of size of files in directory
#' @export
#' @examples
#' \dontrun{
#' dir_size(path = "C:/ghBackup/R")
#' }
#'
dir_size <- function(path) {

  # error message class
  if (class(path) != "character") stop("class of the path is not character")
  files <- list.files(path, full.names = T, recursive = T)

  if (length(files)==0) {
    size_files <- file.size(path)
# Error message
    stop("no file found")

  } else {
    vect_size <- sapply(files, function(x) file.size(x))
    size_files <- data.frame(
      Total_Size_MB = sum(vect_size)/10**6,
      path=path
    )

    if (size_files$Total_Size_MB > 1000) warning("The size of the directory exceeds the recommended size: 1000 MB!")
  }
  #return output
  return(size_files)
}
