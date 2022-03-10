#' Sum of two or more numbers.
#'
#' Add a vector of numbers and return the sum of the vector of numbers.
#'
#' @param x A vector of numbers. Minimum requirements: two numbers.
#'
#' @return The sum of vector \code{x}.
#' @export
#' @examples
#' sum(c(1, 2))
#' sum(c(4, 5, 6, 7))
sum <- function(x) {

    # Error messages
    if (length(x) < 2) stop("vector x needs to have at least two numbers!")
    if (class(x) != "numeric") stop("vector x needs to be numeric numbers!")

    # sum calculation
    output <- 0
    for (i in 1:length(x)) {
        output <- output + x[i]
    }

    # return the output
    return(output)
}