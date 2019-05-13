#' @export 
get_continents <- function() request("continents")

#' @export 
get_continent <- function(id){
  glue::glue("continents/{id}") %>% request()
}

#' @export 
get_countries <- function() request("countries")

#' @export 
get_country <- function(id){
  glue::glue("continents/{id}") %>% request()
}

#' @export 
get_leagues <- function() request("leagues")

#' @export 
get_league <- function(id){
  glue::glue("leagues/{id}") %>% request()
}

#' @export 
get_seasons <- function() request("seasons")

#' @export 
get_season <- function(id){
  glue::glue("seasons/{id}") %>% request()
}

#' @export 
get_fixture <- function(id = NULL, date = NULL){
  if(!is.null(id)) ep <- glue::glue("fixtures/{id}")
  if(!is.null(date)) ep <- glue::glue("fixtures/date/{date}")
  ep %>% request()
}

#' @export 
get_fixtures <- function(ids = NULL, dates = NULL){
  if(!is.null(ids)) ep <- ids %>% paste(collapse = ",") %>% paste("fixtures/multi/", .) 
  if(!is.null(dates)) ep <- dates[1:2] %>% paste(collapse = "/") %>% paste0("fixtures/between/", .) 
  ep %>% request()
}

#' @export 
get_live <- function() request("livescores")
#get_live_now <- function() make_request("livescores/now")

#' @export 
get_comments <- function(game_id){
  glue::glue("commentaries/fixture/{game_id}") %>% request()
}

#' @export 
get_highlights <- function(game_id){
  glue::glue("commentaries/fixture/{game_id}") %>% request()
}

#' @export 
get_head2head <- function(team1, team2){
  glue::glue("head2head/{team1}/{team2}") %>% request()
}

#' @export 
get_head2head <- function(team1, team2){
  glue::glue("head2head/{team1}/{team2}") %>% request()
}

#' @export 
get_team <- function(id){
  glue::glue("teams/{id}") %>% request()
}

#' @export 
get_player <- function(id){
  glue::glue("players/{id}") %>% request()
}

#' @export 
get_topscores <- function(season_id, agg = F){
  agg <- ifelse(agg, "/aggregated", "")
  glue::glue("topscorers/season/{season_id}{agg}") %>% request()
}

#' @export 
get_venue <- function(id){
  glue::glue("venues/{id}") %>% request()
}

#' @export 
get_round <- function(round_id = NULL, season_id = NULL){
  if(!is.null(season_id)) round_id <- paste0("season/", season_id)
  glue::glue("rounds/{round_id}") %>% request()
}

#' @export 
get_odds <- function(game_id){
  glue::glue("odds/fixture/{game_id}") %>% request()
}

#' @export 
get_coache <- function(id){
  glue::glue("coaches/{id}") %>% request()
}

#' @export 
get_stage <- function(stage_id = NULL, season_id = NULL){
  if(!is.null(season_id)) stage_id <- paste0("season/", season_id)
  glue::glue("stages/{stage_id}") %>% request()
}

#' @export 
get_bookmakers <- function() request("bookmakers")

#' @export 
get_bookmaker <- function(book_id){
  glue::glue("bookmakers/{book_id}") %>% request()
}

#' @export 
get_markets <- function() request("markets")

#' @export 
get_market <- function(id){
  glue::glue("markets/{id}") %>% request()
}

#' @export 
get_team_squads <- function(season_id = NULL, team_id = NULL){
  glue::glue("squad/season/{season_id}/team/{team_id}") %>% request()
}

#' @export 
get_tv <- function(game_id){
  glue::glue("tvstations/fixture/{game_id}") %>% request()
}