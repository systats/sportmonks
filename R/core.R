#' @export  
make_request <- function(end_point, dev = F){
  
  base_url <- "https://soccer.sportmonks.com/api/v2.0/"
  q <- glue::glue("{base_url}{end_point}?api_token={Sys.getenv('sportmonks')}")
  res <- httr::GET(q)
  
  if(dev) {
    print(q) 
    print(res)
  }
  
  return(httr::content(res)$data)
}

#' @export 
parse_request <- function(d){
  if(length(d[[1]]) == 1){
    d %>% 
      rlist::list.flatten() %>% 
      dplyr::bind_cols() 
  } else {
    d %>% 
      purrr::map_dfr(rlist::list.flatten)
  }
}

#' @export 
request <- function(end_point, dev = F){
  end_point %>% 
    make_request() %>%
    parse_request() %>% 
    janitor::clean_names()
}
