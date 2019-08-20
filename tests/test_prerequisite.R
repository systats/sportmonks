library(crayon)

key <- jsonlite::read_json(here::here("tests/settings.json"))[[1]]
Sys.setenv(sportmonks = key)