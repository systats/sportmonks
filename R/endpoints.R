#' @export 
get_continents <- function(parse = T, ...) request("continents", ...) %>% parse_request(parse = parse)

#' @export 
get_continent <- function(id, parse = T, ...){
  glue::glue("continents/{id}") %>% request(...) %>% parse_request(parse = parse)
}

#' @export 
get_countries <- function(parse = T, ...) request("countries", ...) %>% parse_request(parse = parse)

#' @export 
get_country <- function(id, parse = T, ...){
  glue::glue("countries/{id}") %>% request(...) %>% parse_request(parse = parse)
}

#' @export 
get_leagues <- function(parse = T, ...) request("leagues", ...)  %>% parse_request(parse = parse)

#' @export 
get_league <- function(id, parse = T, ...){
  glue::glue("leagues/{id}") %>% request(...) %>% parse_request(parse = parse)
}

#' @export 
get_seasons <- function(parse = T, ...) request("seasons", ...) %>% parse_request(parse = parse)

#' @export 
get_season <- function(id, parse = T, ...){
  glue::glue("seasons/{id}") %>% request(...)  %>% parse_request(parse = parse)
}

#' @export 
get_fixture <- function(id = NULL, date = NULL, parse = T, ...){
  if(!is.null(id)) ep <- glue::glue("fixtures/{id}")
  if(!is.null(date)) ep <- glue::glue("fixtures/date/{date}")
  ep %>% request(...)  %>% parse_request(parse = parse)
}

#' @export 
get_fixtures <- function(ids = NULL, dates = NULL, year = NULL, parse = T,...){
  
  if(!is.null(ids) & length(ids) > 24){
    out <- split(ids, 1:length(ids) %/% 25) %>% 
      purrr::imap_dfr(~{get_fixtures(ids = .x, dates = NULL, year = NULL, parse = T, ...)}) #%>%
      #purrr::reduce(c)
  }
  
  
  if(!is.null(ids) & length(ids) <= 24){ep <- ids %>% paste(collapse = ",") %>% paste("fixtures/multi/", .)}
  if(!is.null(dates)){ep <- dates[1:2] %>% paste(collapse = "/") %>% paste0("fixtures/between/", .)}
  if(!is.null(year)){ep <- glue::glue("fixtures/between/{year}-01-01/{year+1}-01-01")}
  if(length(ids) <= 24){out <- ep %>% request(dev = F,...)  %>% parse_request(parse = parse)}
  
  return(out)
}

#' @export 
get_live <- function(parse = T, ...){
  out <- request("livescores", ...)
  
  if(length(out) == 0){
    message("\nNo livescore available")
  } else {
    return(parse_request(out, parse = parse))
  }
}
#get_live_now <- function() make_request("livescores/now")

#' @export 
get_comments <- function(game_id, parse = T, ...){
  glue::glue("commentaries/fixture/{game_id}") %>% request(...) %>% parse_request(parse = parse)
}

#' @export 
get_highlights <- function(game_id, parse = T, ...){
  glue::glue("commentaries/fixture/{game_id}") %>% request(...) %>% parse_request(parse = parse)
}

#' @export 
get_head2head <- function(team1, team2, parse = T, ...){
  glue::glue("head2head/{team1}/{team2}") %>% request(...)  %>% parse_request(parse = parse)
}

#' @export 
get_head2head <- function(team1, team2, parse = T, ...){
  glue::glue("head2head/{team1}/{team2}") %>% request(...)  %>% parse_request(parse = parse)
}

#' @export 
get_team <- function(id, season_id = NULL, parse = T, ...){
  if(!is.null(season_id)) id <- paste0("season/", season_id)
  glue::glue("teams/{id}") %>% request(...) %>% parse_request(parse = parse)
}

#' @export 
get_player <- function(id, parse = T, ...){
  glue::glue("players/{id}") %>% request(...) %>% parse_request(parse = parse)
}

#' @export 
get_topscores <- function(season_id, agg = F, parse = T, ...){
  agg <- ifelse(agg, "/aggregated", "")
  glue::glue("topscorers/season/{season_id}{agg}") %>% request(...) %>% parse_request(parse = parse)
}

#' @export 
get_venue <- function(id, parse = T, ...){
  glue::glue("venues/{id}") %>% request(...) %>% parse_request(parse = parse)
}

#' @export 
get_round <- function(round_id = NULL, season_id = NULL, parse = T, ...){
  if(!is.null(season_id)) round_id <- paste0("season/", season_id)
  glue::glue("rounds/{round_id}") %>% request(...) %>% parse_request(parse = parse)
}

#' @export 
get_odds <- function(game_id, parse = T, ...){
  glue::glue("odds/fixture/{game_id}") %>% request(...) %>% parse_request(parse = parse)
}

#' @export 
get_coache <- function(id, parse = T, ...){
  glue::glue("coaches/{id}") %>% request(...) %>% parse_request(parse = parse)
}

#' @export 
get_stage <- function(stage_id = NULL, season_id = NULL, parse = T, ...){
  if(!is.null(season_id)) stage_id <- paste0("season/", season_id)
  glue::glue("stages/{stage_id}") %>% request(...) %>% parse_request(parse = parse)
}

#' @export 
get_bookmakers <- function(parse = T, ...) request("bookmakers", ...) %>% parse_request(parse = parse)

#' @export 
get_bookmaker <- function(book_id, parse = T, ...){
  glue::glue("bookmakers/{book_id}") %>% request(...) %>% parse_request(parse = parse)
}

#' @export 
get_markets <- function(parse = T, ...) request("markets", ...) %>% parse_request(parse = parse)

#' @export 
get_market <- function(id, parse = T, ...){
  glue::glue("markets/{id}") %>% request(...) %>% parse_request(parse = parse)
}

#' @export 
get_team_squads <- function(season_id = NULL, team_id = NULL, parse = T, ...){
  glue::glue("squad/season/{season_id}/team/{team_id}") %>% request(...) %>% parse_request(parse = parse)
}

#' @export 
get_tv <- function(game_id, parse = T, ...){
  glue::glue("tvstations/fixture/{game_id}") %>% request(...) %>% parse_request(parse = parse) 
}


#' @export 
get_fixture_year <- function(year){
  out <- get_fixtures(year = year, parse = F) %>% 
    purrr::map_dfr(~{
      tibble::tibble(game_id = .x[["id"]], date = .x[["time"]][["starting_at"]][["date"]])
    })
  
  return(out)
}