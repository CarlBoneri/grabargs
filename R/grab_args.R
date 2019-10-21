#' Arg helper
#'
#' \code{grab_args}
#'
#'  This function is intended as a helper to be used within functions. It creates
#'    an object which stores all the arguments passed into the function/parent
#'    environment. Useful for when a function has many arguments or \code{...}
#'    parameter in which named referencing can be too much work.
#'
#' @author Carl Boneri, \email{carl.boneri@@whyles.com}
#'
#' @return
#' The args passed into a function
#'
#' @examples
#' .examp <- function(arg = NULL, a = 3, is_fun = TRUE, ...){
#'   fargs <- grab_args()
#'   return(fargs)
#' }
#'
#'> .examp(test_arg = 123)
#'$arg
#'NULL
#'$a
#'[1] 3
#'$is_fun
#'[1] TRUE
#'$test_arg
#'[1] 123
#'
#' @export

grab_args <- function() {
  envir <- parent.frame()
  func <- sys.function(-1)
  call <- sys.call(-1)
  dots <- match.call(func, call, expand.dots=FALSE)$...
  c(as.list(envir), dots)
}


#' Arg helper with cleaning
#'
#' \code{grab_args_clean}
#'
#'
#' This is a version of \code{grab_args} that will drop NULL values, as well
#'   as match any arguments which may have multiple options. The main difference
#'   here is that this will handle any need for \code{match.arg} in parameter inputs.
#'
#'
#' @examples
#' t.search_test2 <- function(q = NULL, geocode = NULL, lang = NULL, locale = NULL, result_type = c("mixed", "recent", "popular"),
#'                            count = 100, until = NULL, since_id = NULL, max_id = NULL, include_entities = FALSE){
#'
#'    query <- grab_args_clean()
#'
#'
#'    query
#'
#' }
#'
#' > t.search_test2()
#' $result_type
#' [1] "mixed"
#' $count
#' [1] 100
#' $include_entities
#' [1] FALSE
#'
#'
#' @export
grab_args_clean <- function() {
  envir <- parent.frame()
  func <- sys.function(-1)
  call <- sys.call(-1)
  dots <- match.call(func, call, expand.dots=FALSE)$...
  o <- c(as.list(envir), dots)
  o <- o[!mapply(is.null, o)]
  o[mapply(length, o) > 1] <- eval(parse(text = sprintf("match.arg(%s)", names(o[mapply(length, o) > 1]))), envir = envir)
  o
}
