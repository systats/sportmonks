
#' @export 
characterize_pos <- function(x){
  if(is.null(x)) return(NULL)
  x %>% dplyr::mutate_all(as.character)
}

#' @export 
clean_value <- function(x){
  x %>%
    tolower() %>%
    stringr::str_remove_all("[[:punct:]]") %>%
    stringr::str_replace_all("\\s+", "\\_") %>%
    stringr::str_replace("^(?=\\d)", "x")
}
