#' @export 
make_request <- function(end_point, page = NULL, leagues = NULL, includes = NULL){
  
  base_url <- "https://soccer.sportmonks.com/api/v2.0/"
  page <- ifelse(is.null(page), "", glue::glue("&page={page}"))
  leagues <- ifelse(is.null(leagues), "", glue::glue("&leagues={paste(leagues, collapse = ',')}"))
  includes <- ifelse(is.null(includes), "", glue::glue("&include={paste(includes, collapse = ',')}"))
  q <- glue::glue("{base_url}{end_point}?api_token={Sys.getenv('sportmonks')}{includes}{page}{leagues}") #&include={includes}
  
  res <- httr::GET(q)
  
  if(httr::http_error(res)){
    main <- httr::message_for_status(res$status_code)
    log_error(header = res$status_code, info = main)
  } else {
    #data_len <- content(res)$data %>% length()
    main <- httr::message_for_status(res$status_code)
    log_success(header = res$status_code, info = main)
  }
  
  return(res)
}


#' @export  
request <- function(end_point, dev = F, pages = T, ...){
  
  param <- list(...)
  
  res <- make_request(end_point, leagues = param[["leagues"]], includes = param[["includes"]])
  ct <- httr::content(res)
  data <- ct$data
  meta <- ct$meta
  
  if(dev) {
    print(q)
    print(res)
    print(meta)
  }
  
  if(length(meta$pagination$total_pages) > 0){
    if(pages & meta$pagination$total_pages > 1){
      
      data <- 2:meta$pagination$total_pages %>%
        imap(~{
          print(.x)
          end_point %>% 
            make_request(page = .x, leagues = param[["leagues"]], includes = param[["includes"]]) %>%
            httr::content(.) %>%
            .$data
        }) %>%
        c(list(data), .) %>% 
        unlist(.,recursive = F)
      
    }
  }

  return(data)
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
log_success <- function(header = "", info = ""){
  info <- as.character(info) %>% paste0(., "\n") 
  crayon::green(glue::glue("Success {header} [{Sys.time()}]: ")) %+% info %>% cat()
}

#' @export 
log_error <- function(header = "", info = ""){
  info <- as.character(info) %>% paste0(., "\n")
  crayon::red(glue::glue("Error {header} [{Sys.time()}]: ")) %+% info %>% cat()
}

