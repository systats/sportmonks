
#' @export 
parse_core <- function(response){
  
  to_keep <- c(
    "id", "league_id", "season_id", "stage_id", "round_id", "group_id", "venue_id", 
    "referee_id", "winner_team_id",  "scores",
    "attendance", "pitch", "winning_odds_calculated", "formations",
    "time", "coaches", "standings","standing", "leg",  "deleted",
    "localTeam", "visitorTeam", "weather_report"
  )
  
  to_delete <- c("odds", "goals", "cards", "assistants", "colors", "commentaries", 
                 "venue", "referee", "stats", "lineup")
  
  new_names <- names(response) %>%
    setdiff(to_keep) %>%
    setdiff(to_delete)
  
  #if(length(new_names) > 0) print(new_names)
  
  response %>%
    .[to_keep] %>% 
    rlist::list.flatten() %>% 
    purrr::map_dfc(purrr::compact) %>% 
    janitor::clean_names() %>%
    dplyr::rename_all(~.x %>% stringr::str_remove("_data")) %>%
    dplyr::rename_all(~.x %>% stringr::str_replace_all("weather_report", "weather")) %>%
    #dplyr::rename_all(~.x %>% stringr::str_replace_all("localteam_id", "local_team_id") %>% stringr::str_replace_all("visitorteam_id", "visitor_team_id")) %>%
    dplyr::rename(game_id = id)
}

#' @export 
parse_odds <- function(response){
  
  if(length(response$odds$data) == 0){return(tibble(game_id = response$id[[1]]))}
  
  out <- response$odds %>% 
    tibble::as_tibble %>%
    tidyr::unnest_wider(data) %>%
    tidyr::unnest_longer(id) %>%
    rename(meta_id = id) %>%
    tidyr::unnest_longer(name) %>%
    rename(meta_name = name) %>%
    mutate(meta_name = clean_value(meta_name)) %>%
    tidyr::unnest_longer(suspended) %>%
    tidyr::unnest_wider(bookmaker) %>%
    tidyr::unnest_longer(data) %>%
    tidyr::unnest_wider(data) %>%
    tidyr::unnest_longer(id) %>%
    tidyr::unnest_longer(name) %>%
    tidyr::unnest_wider(odds) %>%
    tidyr::unnest_longer(data) %>%
    tidyr::unnest_wider(data) %>% 
    mutate_if(~is.list(.x) & length(.x[[1]]) == 1, ~as.character(unlist(.x))) %>%
    tidyr::unnest_wider(last_update) %>%
    mutate_if(~is.list(.x) & length(.x[[1]]) == 1, ~as.character(unlist(.x))) %>%
    mutate(game_id = response$id[[1]])
  
  return(out)
}

#' @export 
parse_lineups <- function(data){
  if(length(data$lineup$data) == 0){return(tibble(game_id = data$id))}
  
  data$lineup[[1]] %>% 
    purrr::map_dfr(~{.x %>% rlist::list.flatten() %>% purrr::compact() %>% dplyr::bind_cols()}) %>% 
    janitor::clean_names(.) %>%
    dplyr::rename_all(~stringr::str_remove_all(.x, "stats_") %>% stringr::str_replace_all("shots_shots_", "shots_")) %>%
    dplyr::rename(game_id = fixture_id) %>% 
    dplyr::mutate(index = as.character(glue::glue("{game_id}_{team_id}_{player_id}"))) %>%
    dplyr::select(index, game_id, team_id, player_id, player_name, dplyr::everything()) %>%
    dplyr::mutate_at(-1:-11, ~as.numeric(.x))
}


#' @export
parse_teamstats <- function(data){
  if(length(data$stats$data) == 0){return(tibble::tibble(game_id = data$id))}
  
  data$stats[[1]] %>% 
    purrr::map_dfr(~rlist::list.flatten(.x) %>% dplyr::bind_cols()) %>% 
    janitor::clean_names() %>%
    dplyr::rename(game_id = fixture_id) %>%
    dplyr::mutate(index = as.character(glue::glue("{game_id}_{team_id}"))) %>% 
    dplyr::select(index, game_id, team_id, dplyr::everything()) %>%
    dplyr::mutate_at(-1:-3, ~as.numeric(.x))
}

#' @export
parse_core_pos <- purrr::possibly(parse_core, NULL)
#' @export
parse_lineups_pos <- purrr::possibly(parse_lineups, NULL)
#' @export
parse_teamstats_pos <- purrr::possibly(parse_teamstats, NULL)

