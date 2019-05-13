skip_if_no_token <- function() {
  if (is.na(Sys.getenv("sportmonks", NA_character_))) {
    skip("No GitHub token")
  }
}

skip_if_no_token()

test_that("make_request API response", {
  res <- make_request("countries")
  expect_equal(length(res) > 0, T) # API Call
})

test_that("parse_request long format", {
  res <- mtcars %>% split(1:nrow(.)) %>% parse_request()
  expect_equal(is_tibble(res), T) # Parser
})

test_that("parse_request wide format", {
  res <- mtcars %>% slice(1) %>% as.list %>% parse_request()
  expect_equal(is_tibble(res), T) # Parser
})

test_that("request all at once", {
  res <- request("countries")
  expect_equal(length(res) > 0, T) # API Call
  expect_equal(is_tibble(res), T) # Parser
})