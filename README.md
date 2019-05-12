sportmonks
================

``` r
pacman::p_load(tidyverse, devtools, httr, jsonlite, xml2, listviewer, janitor)
```

``` r
key <- read_json("settings.json") %>% unlist
```

``` r
make_request <- function(end_point, dev = T){
  base_url <- "https://soccer.sportmonks.com/api/v2.0/"
  q <- glue::glue("{base_url}{end_point}?api_token={key}")
  res <- httr::GET(q)
  if(dev) print(q); print(res)
  return(httr::content(res))
}

end_point <- "livescores/now"
#make_request(end_point)
```

``` r
get_continents <- function(id = NULL){
  end_point <- "continents"
  if(!is.null(id)) end_point <- paste0(end_point, "/", id)
  make_request(end_point)$data %>% 
  purrr::map_dfr(dplyr::bind_cols) %>% 
  janitor::clean_names(.)
}

get_countries <- function(id = NULL){
  end_point <- "countries"
  if(!is.null(id)) end_point <- paste0(end_point, "/", id)
  make_request(end_point)$data %>%
  purrr::map_dfr(~rlist::list.flatten(.x) %>% bind_cols) %>% 
  janitor::clean_names(.)
}

get_leagues <- function(id = NULL){
  end_point <- "leagues"
  if(!is.null(id)) end_point <- paste0(end_point, "/", id)
  make_request(end_point)$data %>%
  purrr::map_dfr(~rlist::list.flatten(.x) %>% bind_cols) %>% 
  janitor::clean_names(.)
}

get_seasons <- function(id = NULL){
  end_point <- "seasons"
  if(!is.null(id)) end_point <- paste0(end_point, "/", id)
  make_request(end_point)$data %>%
  purrr::map_dfr(~rlist::list.flatten(.x) %>% bind_cols) %>% 
  janitor::clean_names(.)
}

get_fixtures <- function(id = NULL){
  end_point <- "fixtures"
  if(!is.null(id)) end_point <- paste0(end_point, "/", id)
  make_request(end_point)$data
}
```

``` r
list(
  get_continents,
  get_countries,
  get_leagues,
  get_seasons
) %>% 
  walk(~glimpse(.x()))
```

    ## https://soccer.sportmonks.com/api/v2.0/continents?api_token=2eT3zMYQNQeAD0ELjWXMKi0HWzefdHRUf0Iki2mozdvfgP0hFoAXuGfiB9xk
    ## Response [https://soccer.sportmonks.com/api/v2.0/continents?api_token=2eT3zMYQNQeAD0ELjWXMKi0HWzefdHRUf0Iki2mozdvfgP0hFoAXuGfiB9xk]
    ##   Date: 2019-05-12 17:22
    ##   Status: 200
    ##   Content-Type: application/json
    ##   Size: 508 B
    ## 
    ## Observations: 7
    ## Variables: 2
    ## $ id   <int> 1, 2, 3, 4, 5, 6, 7
    ## $ name <chr> "Europe", "Asia", "Africa", "Oceania", "Antarctica", "North…
    ## https://soccer.sportmonks.com/api/v2.0/countries?api_token=2eT3zMYQNQeAD0ELjWXMKi0HWzefdHRUf0Iki2mozdvfgP0hFoAXuGfiB9xk
    ## Response [https://soccer.sportmonks.com/api/v2.0/countries?api_token=2eT3zMYQNQeAD0ELjWXMKi0HWzefdHRUf0Iki2mozdvfgP0hFoAXuGfiB9xk]
    ##   Date: 2019-05-12 17:22
    ##   Status: 200
    ##   Content-Type: application/json
    ##   Size: 950 kB
    ## 
    ## Observations: 50
    ## Variables: 11
    ## $ id                 <int> 2, 5, 11, 17, 20, 23, 26, 32, 38, 41, 44, 47,…
    ## $ name               <chr> "Poland", "Brazil", "Germany", "France", "Por…
    ## $ extra_continent    <chr> "Europe", "Americas", "Europe", "Europe", "Eu…
    ## $ extra_sub_region   <chr> "Eastern Europe", "South America", "Western E…
    ## $ extra_world_region <chr> "EMEA", "AMER", "EMEA", "EMEA", "EMEA", "EMEA…
    ## $ extra_fifa         <chr> "POL", "BRA", "GER", "FRA", "POR", "CIV", "ML…
    ## $ extra_iso          <chr> "POL", "BRA", "DEU", "FRA", "PRT", "CIV", "ML…
    ## $ extra_iso2         <chr> "PL", "BR", "DE", "FR", "PT", "CI", "ML", "ES…
    ## $ extra_longitude    <chr> "19.37775993347168", "-52.97311782836914", "1…
    ## $ extra_latitude     <chr> "52.147850036621094", "-10.81045150756836", "…
    ## $ extra_flag         <chr> "<svg xmlns=\"http://www.w3.org/2000/svg\" wi…
    ## https://soccer.sportmonks.com/api/v2.0/leagues?api_token=2eT3zMYQNQeAD0ELjWXMKi0HWzefdHRUf0Iki2mozdvfgP0hFoAXuGfiB9xk
    ## Response [https://soccer.sportmonks.com/api/v2.0/leagues?api_token=2eT3zMYQNQeAD0ELjWXMKi0HWzefdHRUf0Iki2mozdvfgP0hFoAXuGfiB9xk]
    ##   Date: 2019-05-12 17:22
    ##   Status: 200
    ##   Content-Type: application/json
    ##   Size: 1.08 kB
    ## 
    ## Observations: 2
    ## Variables: 12
    ## $ id                         <int> 271, 501
    ## $ legacy_id                  <int> 43, 66
    ## $ country_id                 <int> 320, 1161
    ## $ logo_path                  <chr> "https://cdn.sportmonks.com/images/so…
    ## $ name                       <chr> "Superliga", "Premiership"
    ## $ is_cup                     <lgl> FALSE, FALSE
    ## $ current_season_id          <int> 12919, 12963
    ## $ current_stage_id           <int> 7088925, NA
    ## $ live_standings             <lgl> TRUE, TRUE
    ## $ coverage_topscorer_goals   <lgl> TRUE, TRUE
    ## $ coverage_topscorer_assists <lgl> TRUE, TRUE
    ## $ coverage_topscorer_cards   <lgl> TRUE, TRUE
    ## https://soccer.sportmonks.com/api/v2.0/seasons?api_token=2eT3zMYQNQeAD0ELjWXMKi0HWzefdHRUf0Iki2mozdvfgP0hFoAXuGfiB9xk
    ## Response [https://soccer.sportmonks.com/api/v2.0/seasons?api_token=2eT3zMYQNQeAD0ELjWXMKi0HWzefdHRUf0Iki2mozdvfgP0hFoAXuGfiB9xk]
    ##   Date: 2019-05-12 17:22
    ##   Status: 200
    ##   Content-Type: application/json
    ##   Size: 3.83 kB
    ## 
    ## Observations: 28
    ## Variables: 6
    ## $ id                <int> 1273, 1274, 1275, 1276, 1277, 1278, 1279, 1280…
    ## $ name              <chr> "2005/2006", "2006/2007", "2007/2008", "2008/2…
    ## $ league_id         <int> 271, 271, 271, 271, 271, 271, 271, 271, 271, 2…
    ## $ is_current_season <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
    ## $ current_stage_id  <int> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
    ## $ current_round_id  <int> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…

``` r
nn <- get_leagues(1) 
nn %>% listviewer::jsonedit()
nn[[1]] %>% rlist::list.flatten()
```
