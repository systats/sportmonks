source(here::here("tests/test_prerequisite.R"))

test_that("get_continents", {
  out <- get_continents()
  expect_equal(nrow(out), 7)
})

test_that("get_continent", {
  avaible <- c("Europe", "Asia", "Africa", "Oceania", "Antarctica", "North America", 
               "South America")
  draw <- sample(1:7, 1)
  out <- get_continent(draw)
  expect_equal(out$name, avaible[draw])
})

test_that("get_countries", {
  out <- get_countries()
  expect_equal(nrow(out), 248)
})

test_that("get_country", {
  out <- get_country(2)
  expect_equal(out$name, "Poland")
})

test_that("get_leagues", {
  out <- get_leagues()
  expect_equal(colnames(out)[1:3], c("id", "active", "type" ))
})

test_that("get_league", {
  out <- get_league(271)
  expect_equal(out$id, 271)
})

test_that("get_seasons", {
  out <- get_seasons()
  expect_equal(colnames(out)[1:3], c("id", "name", "league_id"))
})

test_that("get_season", {
  input <- 1273
  out <- get_season(input)
  expect_equal(out$id, input)
})

test_that("get_fixture by id", {
  id <- 10333321
  out <- get_fixture(id)
  expect_equal(out$id, id)
})

test_that("get_fixture by ids", {
  ids <- c(10333321, 10333322)
  out <- get_fixtures(ids)
  expect_equal(out$id, as.character(ids))
})

test_that("get_fixture by more than 25 ids", {
  ids <- c(10328844L, 10328849L, 10328845L, 10328843L, 10328848L, 10328846L, 
           10328847L, 10328853L, 10328855L, 10328850L, 10328851L, 10328856L, 
           10328854L, 10328852L, 10328857L, 10328863L, 10328860L, 10328861L, 
           10328858L, 10328859L, 10328862L, 10328864L, 10328869L, 10328870L, 
           10328867L, 10328865L, 10328868L, 10328866L, 10328872L, 10328876L, 
           10328874L, 10328877L, 10328875L, 10328873L, 10328871L, 10328878L, 
           10328879L, 10328880L, 10328881L, 10328882L, 10328883L, 10328884L, 
           11849722L, 11849723L, 11849737L, 11849738L, 11849724L, 11849725L)
  out <- get_fixtures(ids)
  expect_equal(length(setdiff(out$id, as.character(ids))), 0)
})

test_that("get_fixture by date", {
  date <- "2019-01-23"
  out <- get_fixture(date = date)
  expect_equal(out$time_starting_at_date[1], date)
})

test_that("get_fixture by dates", {
  dates <- c("2019-01-01", "2019-02-01")
  out <- get_fixtures(dates = dates)
  expect_equal(nrow(out) > 10, T)
})

# test_that("get_live", {
#   out <- get_live()
#   expect_equal(colnames(out)[1:3], c("id", "league_id", "season_id"))
# })

test_that("get_comments", {
  input <- 10333321
  out <- get_comments(input)
  expect_equal(out$fixture_id[1], as.character(input))
})

test_that("get_highlights", {
  input <- 10333321
  out <- get_highlights(input)
  expect_equal(out$fixture_id[1], as.character(input))
})

test_that("get_head2head", {
  out <- get_head2head(team1 = 309, team2 = 66)
  expect_equal(colnames(out)[1:3], c("id", "league_id", "season_id"))
})

test_that("get_team by id", {
  input <- 180
  out <- get_team(input)
  expect_equal(out$id, input)
})

test_that("get_team by season", {
  input <- 1273
  out <- get_team(season_id = input)
  expect_equal(out$id[1], "85")
})

test_that("get_player", {
  input <- 180
  out <- get_player(input)
  expect_equal(out$player_id, input)
})

test_that("get_topscores", {
  input <- 1273
  out <- get_topscores(season_id = input)
  expect_equal(out$id, input)
})

test_that("get_venue", {
  input <- 8928
  out <- get_venue(input)
  expect_equal(out$id, input)
})

test_that("get_round by season_id", {
  input <- 12963
  out <- get_round(season_id = input)
  expect_equal(nrow(out) > 30, T)
})

test_that("get_round by round_id", {
  input <- 147767
  out <- get_round(round_id = input)
  expect_equal(out$id[1], input)
})

test_that("get_odds", {
  input <- 10333321
  out <- get_odds(input)
  expect_equal(nrow(out) > 49, T)
})

test_that("get_coache", {
  input <- 896462
  out <- get_coache(input)
  expect_equal(out$coach_id, input)
})

test_that("get_stage", {
  input <- 7508262
  out <- get_stage(stage_id = input)
  expect_equal(out$id[1], input)
})

test_that("get_stage", {
  input <- 12963
  out <- get_stage(season_id = input)
  expect_equal(out$season_id[1], as.character(input))
})

test_that("get_bookmakers", {
  out <- get_bookmakers()
  expect_equal(out$name[1], "10Bet")
})


test_that("get_bookmaker", {
  out <- get_bookmaker(book_id = 1)
  expect_equal(out$name, "10Bet")
})

test_that("get_markets", {
  out <- get_markets()
  expect_equal(out$name[1], "3Way Result")
})

test_that("get_market", {
  input <- 10
  out <- get_market(input)
  expect_equal(out$name, "Home/Away")
})

test_that("get_team_squads", {
  out <- get_team_squads(season_id = 12963, team_id = 180)
  expect_equal(out$player_id[1], "172042")
})

test_that("get_team_squads", {
  input <- "10333321"
  out <- get_tv(input)
  expect_equal(out$fixture_id[1], input)
})

test_that("get_fixture_year", {
  year <- 2017
  out <- get_fixture_year(year)
  expect_equal(unique(lubridate::year(out$date)), year)
})

