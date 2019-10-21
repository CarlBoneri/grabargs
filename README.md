
<!-- README.md is generated from README.Rmd. Please edit that file -->

# grabargs

<p align="center">

<img src="./inst/grabby.gif" width="448" height="384" />

</p>

A very small package with only one real purpose: to import the
`grab_args` function into any package or *Shiny App*. I got tired of
importing this function into all my private packages, so deploying as a
package itself.

## Installation

You can install the released version of grabargs from
[GitHub](https://github.com/CarlBoneri/grabargs) with:

``` r
devtools::install_github("CarlBoneri/grabargs")
```

## Why this function is helpful

Let’s say you have a function with a ton of optional arguments. A good
example is when building an **API** and the query params are mostly
optional. Let’s use twitter as an example for [searching
tweets](https://developer.twitter.com/en/docs/tweets/search/api-reference/get-search-tweets).

I’m not in the mood to write out all the params, so let’s parse the doc:

``` r
library(xml2)

raw_page <- xml2::read_html("https://developer.twitter.com/en/docs/tweets/search/api-reference/get-search-tweets")

params_table <- xml_find_all(raw_page, ".//h2[contains(.,'Parameters')]//following-sibling::table") %>%
  rvest::html_table() %>% .[[1]] %>%  dplyr::rename_all(function(x){
    tolower(x) %>% gsub("(\\s+)", "_", ., perl = TRUE)
  })

# The description column is making this thing wrap way too much, so gonna truncate:
# 
params_table$description <- lapply(params_table$description, function(i){
    r <- stri_split_regex(i, "(?<=\\.|\\!|\\?)(\\s+)") %>% unlist()
    if(length(r) > 1){
        stri_join(r[1:2], collapse = " ")
    }else {
        r
    }
}) %>% unlist

knitr::kable(params_table %>% select(-default_value), align = "l")
```

| name              | required | description                                                                                                                                                                                        | example                   |
| :---------------- | :------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------ |
| q                 | required | A UTF-8, URL-encoded search query of 500 characters maximum, including operators. Queries may additionally be limited by complexity.                                                               | @noradio                  |
| geocode           | optional | Returns tweets by users located within a given radius of the given latitude/longitude. The location is preferentially taking from the Geotagging API, but will fall back to their Twitter profile. | 37.781157 -122.398720 1mi |
| lang              | optional | Restricts tweets to the given language, given by an ISO 639-1 code. Language detection is best-effort.                                                                                             | eu                        |
| locale            | optional | Specify the language of the query you are sending (only ja is currently effective). This is intended for language-specific consumers and the default should work in the majority of cases.         | ja                        |
| result\_type      | optional | Optional. Specifies what type of search results you would prefer to receive.                                                                                                                       | mixed recent popular      |
| count             | optional | The number of tweets to return per page, up to a maximum of 100. Defaults to 15.                                                                                                                   | 100                       |
| until             | optional | Returns tweets created before the given date. Date should be formatted as YYYY-MM-DD.                                                                                                              | 2015-07-19                |
| since\_id         | optional | Returns results with an ID greater than (that is, more recent than) the specified ID. There are limits to the number of Tweets which can be accessed through the API.                              | 12345                     |
| max\_id           | optional | Returns results with an ID less than (that is, older than) or equal to the specified ID.                                                                                                           | 54321                     |
| include\_entities | optional | The entities node will not be included when set to false.                                                                                                                                          | false                     |
