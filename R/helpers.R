
#' @export 
characterize_pos <- function(x){
  if(is.null(x)) return(NULL)
  x %>% mutate_all(as.character)
}

#' @export 
clean_value <- function(x){
  x %>%
    tolower %>%
    str_remove_all("[[:punct:]]") %>%
    str_replace_all("\\s+", "\\_") %>%
    str_replace("^(?=\\d)", "x")
}
