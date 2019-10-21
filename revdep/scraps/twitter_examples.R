t.search_test <- function(q = NULL, geocode = NULL, lang = NULL, locale = NULL, result_type = c("mixed", "recent", "popular"),
                          count = 100, until = NULL, since_id = NULL, max_id = NULL, include_entities = FALSE){


  query <- list(q = q, geocode = geocode, lang = lang, locale = locale, result_type = match.arg(result_type),
                count = count, until = until, since_id = since_id, max_id = max_id, include_entities = include_entities)

  query <- query[!mapply(is.null, query)]

  query
}



t.search_test2 <- function(q = NULL, geocode = NULL, lang = NULL, locale = NULL, result_type = c("mixed", "recent", "popular"),
                           count = 100, until = NULL, since_id = NULL, max_id = NULL, include_entities = FALSE){

  query <- grab_args_clean()


  query

}
