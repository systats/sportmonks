
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
parse_odds <- function(data){
  
  if(is.null(data)) return(dplyr::tibble(id = NA_character_))
  
  odds_out <- data$odds$data %>%
    purrr::map_dfr(~{
      id <- .x[["id"]] # %>% map_chr("id")
      name <- .x[["name"]] # %>% map_chr("name")
      if(name != "3Way Result") retrun(NULL)
      
      odds <- .x[["bookmaker"]][["data"]] %>%
        map_dfr(~{
          odds <- .x[["odds"]][["data"]] %>%
            purrr::map_dfr(~{
              .x %>% 
                rlist::list.flatten() %>% 
                purrr::compact() %>% 
                dplyr::bind_cols()
            }) %>%
            janitor::clean_names() %>%
            dplyr::rename(odd_label = label, odd_value = value) %>%
            dplyr::select(-dplyr::contains("timezone"))
          
          odds[["book_id"]] <- .x[["id"]]
          odds[["book_name"]] <- .x[["name"]]
          
          return(odds)
        })
      
      id <- ifelse(is.null(id), NA_character_, id)
      name <- ifelse(is.null(name), NA_character_, name)
      
      out <- odds %>% 
        dplyr::mutate(
          game_id = data$id, 
          market_id = id, 
          market_name = name,
          index = as.character(glue::glue("{game_id}_{book_id}_{market_id}_{odd_label}"))
        ) %>% 
        dplyr::select(index, game_id, market_id, market_name, dplyr::everything())
      
      return(out)
    })
  
  return(odds_out)
}


#' @export 
parse_lineups <- function(data){
  data$lineup[[1]] %>% 
    purrr::map_dfr(~{.x %>% rlist::list.flatten() %>% purrr::compact() %>% dplyr::bind_cols()}) %>% 
    janitor::clean_names(.) %>%
    dplyr::rename_all(~str_remove_all(.x, "stats_") %>% str_replace_all("shots_shots_", "shots_")) %>%
    dplyr::rename(game_id = fixture_id) %>% 
    dplyr::mutate(index = as.character(glue::glue("{game_id}_{team_id}_{player_id}"))) %>%
    dplyr::select(index, game_id, team_id, player_id, player_name, dplyr::everything()) %>%
    dplyr::mutate_at(-1:-11, ~as.numeric(.x))
}


#' @export
parse_teamstats <- function(data){
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

