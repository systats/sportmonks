sportmonks
================

    ## Registered S3 methods overwritten by 'ggplot2':
    ##   method         from 
    ##   [.quosures     rlang
    ##   c.quosures     rlang
    ##   print.quosures rlang

![](https://img.shields.io/badge/Premium%20Data-Soccer-magenta.svg)
[![](https://img.shields.io/github/languages/code-size/systats/sportmonks.svg)](https://github.com/systats/sportmonks)
[![](https://img.shields.io/github/last-commit/systats/sportmonks.svg)](https://github.com/systats/sportmonks/commits/master)

# Packages

``` r
pacman::p_load(tidyverse, usethis, devtools, httr, jsonlite, xml2, listviewer, janitor)
devtools::load_all()
```

    ## Loading sportmonks

    ## 
    ## Attaching package: 'testthat'

    ## The following objects are masked from 'package:devtools':
    ## 
    ##     setup, test_file

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     matches

    ## The following object is masked from 'package:purrr':
    ## 
    ##     is_null

``` r
# devtools::document()
# devtools::test()
```

``` r
key <- read_json("tests/settings.json")[[1]]
Sys.setenv(sportmonks = key)
Sys.getenv("sportmonks")
```

    ## [1] "2eT3zMYQNQeAD0ELjWXMKi0HWzefdHRUf0Iki2mozdvfgP0hFoAXuGfiB9xk"

# Endpoints

## Continents

``` r
get_continents()
```

    ## # A tibble: 7 x 2
    ##      id name         
    ##   <int> <chr>        
    ## 1     1 Europe       
    ## 2     2 Asia         
    ## 3     3 Africa       
    ## 4     4 Oceania      
    ## 5     5 Antarctica   
    ## 6     6 North America
    ## 7     7 South America

``` r
get_continent(1)
```

    ## # A tibble: 1 x 2
    ##      id name  
    ##   <int> <chr> 
    ## 1     1 Europe

## Country

``` r
get_countries()
```

    ## # A tibble: 50 x 11
    ##       id name  extra_continent extra_sub_region extra_world_reg… extra_fifa
    ##    <int> <chr> <chr>           <chr>            <chr>            <chr>     
    ##  1     2 Pola… Europe          Eastern Europe   EMEA             POL       
    ##  2     5 Braz… Americas        South America    AMER             BRA       
    ##  3    11 Germ… Europe          Western Europe   EMEA             GER       
    ##  4    17 Fran… Europe          Western Europe   EMEA             FRA       
    ##  5    20 Port… Europe          Southern Europe  EMEA             POR       
    ##  6    23 Côte… Africa          Western Africa   EMEA             CIV       
    ##  7    26 Mali  Africa          Western Africa   EMEA             MLI       
    ##  8    32 Spain Europe          Southern Europe  EMEA             ESP       
    ##  9    38 Neth… Europe          Western Europe   EMEA             NED       
    ## 10    41 Euro… <NA>            <NA>             <NA>             <NA>      
    ## # … with 40 more rows, and 5 more variables: extra_iso <chr>,
    ## #   extra_iso2 <chr>, extra_longitude <chr>, extra_latitude <chr>,
    ## #   extra_flag <chr>

``` r
get_country(2)
```

    ## # A tibble: 1 x 2
    ##      id name 
    ##   <int> <chr>
    ## 1     2 Asia

## Leagues

``` r
get_leagues()
```

    ## # A tibble: 2 x 12
    ##      id legacy_id country_id logo_path name  is_cup current_season_…
    ##   <int>     <int>      <int> <chr>     <chr> <lgl>             <int>
    ## 1   271        43        320 https://… Supe… FALSE             12919
    ## 2   501        66       1161 https://… Prem… FALSE             12963
    ## # … with 5 more variables: current_stage_id <int>, live_standings <lgl>,
    ## #   coverage_topscorer_goals <lgl>, coverage_topscorer_assists <lgl>,
    ## #   coverage_topscorer_cards <lgl>

``` r
get_league(271)
```

    ## # A tibble: 1 x 12
    ##      id legacy_id country_id logo_path name  is_cup current_season_…
    ##   <int>     <int>      <int> <chr>     <chr> <lgl>             <int>
    ## 1   271        43        320 https://… Supe… FALSE             12919
    ## # … with 5 more variables: current_stage_id <int>, live_standings <lgl>,
    ## #   coverage_topscorer_goals <lgl>, coverage_topscorer_assists <lgl>,
    ## #   coverage_topscorer_cards <lgl>

## Seasons

``` r
get_seasons()
```

    ## # A tibble: 28 x 6
    ##       id name  league_id is_current_seas… current_stage_id current_round_id
    ##    <int> <chr>     <int> <lgl>                       <int>            <int>
    ##  1  1273 2005…       271 FALSE                          NA               NA
    ##  2  1274 2006…       271 FALSE                          NA               NA
    ##  3  1275 2007…       271 FALSE                          NA               NA
    ##  4  1276 2008…       271 FALSE                          NA               NA
    ##  5  1277 2009…       271 FALSE                          NA               NA
    ##  6  1278 2010…       271 FALSE                          NA               NA
    ##  7  1279 2011…       271 FALSE                          NA               NA
    ##  8  1280 2012…       271 FALSE                          NA               NA
    ##  9  1281 2013…       271 FALSE                          NA               NA
    ## 10  1282 2014…       271 FALSE                          NA               NA
    ## # … with 18 more rows

``` r
get_season(1273)
```

    ## # A tibble: 1 x 4
    ##      id name      league_id is_current_season
    ##   <int> <chr>         <int> <lgl>            
    ## 1  1273 2005/2006       271 FALSE

## Fixtures

``` r
get_fixture(id = 10333321)
```

    ## # A tibble: 1 x 45
    ##       id league_id season_id stage_id round_id venue_id referee_id
    ##    <int>     <int>     <int>    <int>    <int>    <int>      <int>
    ## 1 1.03e7       501     12963  7508262   147767     8928      14468
    ## # … with 38 more variables: localteam_id <int>, visitorteam_id <int>,
    ## #   weather_report_code <chr>, weather_report_type <chr>,
    ## #   weather_report_icon <chr>, weather_report_temperature_temp <dbl>,
    ## #   weather_report_temperature_unit <chr>, weather_report_clouds <chr>,
    ## #   weather_report_humidity <chr>, weather_report_wind_speed <chr>,
    ## #   weather_report_wind_degree <int>, commentaries <lgl>, pitch <chr>,
    ## #   winning_odds_calculated <lgl>, formations_localteam_formation <chr>,
    ## #   formations_visitorteam_formation <chr>, scores_localteam_score <int>,
    ## #   scores_visitorteam_score <int>, scores_ht_score <chr>,
    ## #   scores_ft_score <chr>, time_status <chr>,
    ## #   time_starting_at_date_time <chr>, time_starting_at_date <chr>,
    ## #   time_starting_at_time <chr>, time_starting_at_timestamp <int>,
    ## #   time_starting_at_timezone <chr>, time_minute <int>,
    ## #   time_added_time <int>, time_injury_time <int>,
    ## #   coaches_localteam_coach_id <int>, coaches_visitorteam_coach_id <int>,
    ## #   standings_localteam_position <int>,
    ## #   standings_visitorteam_position <int>,
    ## #   assistants_first_assistant_id <int>,
    ## #   assistants_second_assistant_id <int>,
    ## #   assistants_fourth_official_id <int>, leg <chr>, deleted <lgl>

``` r
get_fixtures(ids = c(10333321, 10333322))
```

    ## # A tibble: 2 x 46
    ##       id league_id season_id stage_id round_id venue_id referee_id
    ##    <int>     <int>     <int>    <int>    <int>    <int>      <int>
    ## 1 1.03e7       501     12963  7508262   147767     8928      14468
    ## 2 1.03e7       501     12963  7508262   147767     8909      15815
    ## # … with 39 more variables: localteam_id <int>, visitorteam_id <int>,
    ## #   weather_report_code <chr>, weather_report_type <chr>,
    ## #   weather_report_icon <chr>, weather_report_temperature_temp <dbl>,
    ## #   weather_report_temperature_unit <chr>, weather_report_clouds <chr>,
    ## #   weather_report_humidity <chr>, weather_report_wind_speed <chr>,
    ## #   weather_report_wind_degree <int>, commentaries <lgl>, pitch <chr>,
    ## #   winning_odds_calculated <lgl>, formations_localteam_formation <chr>,
    ## #   formations_visitorteam_formation <chr>, scores_localteam_score <int>,
    ## #   scores_visitorteam_score <int>, scores_ht_score <chr>,
    ## #   scores_ft_score <chr>, time_status <chr>,
    ## #   time_starting_at_date_time <chr>, time_starting_at_date <chr>,
    ## #   time_starting_at_time <chr>, time_starting_at_timestamp <int>,
    ## #   time_starting_at_timezone <chr>, time_minute <int>,
    ## #   time_added_time <int>, time_injury_time <int>,
    ## #   coaches_localteam_coach_id <int>, coaches_visitorteam_coach_id <int>,
    ## #   standings_localteam_position <int>,
    ## #   standings_visitorteam_position <int>,
    ## #   assistants_first_assistant_id <int>,
    ## #   assistants_second_assistant_id <int>,
    ## #   assistants_fourth_official_id <int>, leg <chr>, deleted <lgl>,
    ## #   winner_team_id <int>

``` r
get_fixture(date = "2019-01-23")
```

    ## # A tibble: 6 x 47
    ##       id league_id season_id stage_id round_id venue_id referee_id
    ##    <int>     <int>     <int>    <int>    <int>    <int>      <int>
    ## 1 1.03e7       501     12963  7508262   147766     8906      15818
    ## 2 1.03e7       501     12963  7508262   147766     8926      17265
    ## 3 1.03e7       501     12963  7508262   147766     8909      14855
    ## 4 1.03e7       501     12963  7508262   147766   288196      17256
    ## 5 1.03e7       501     12963  7508262   147766      219      14466
    ## 6 1.03e7       501     12963  7508262   147766     8922      14853
    ## # … with 40 more variables: localteam_id <int>, visitorteam_id <int>,
    ## #   winner_team_id <int>, weather_report_code <chr>,
    ## #   weather_report_type <chr>, weather_report_icon <chr>,
    ## #   weather_report_temperature_temp <dbl>,
    ## #   weather_report_temperature_unit <chr>, weather_report_clouds <chr>,
    ## #   weather_report_humidity <chr>, weather_report_wind_speed <chr>,
    ## #   weather_report_wind_degree <dbl>, commentaries <lgl>,
    ## #   attendance <int>, pitch <chr>, winning_odds_calculated <lgl>,
    ## #   formations_localteam_formation <chr>,
    ## #   formations_visitorteam_formation <chr>, scores_localteam_score <int>,
    ## #   scores_visitorteam_score <int>, scores_ht_score <chr>,
    ## #   scores_ft_score <chr>, time_status <chr>,
    ## #   time_starting_at_date_time <chr>, time_starting_at_date <chr>,
    ## #   time_starting_at_time <chr>, time_starting_at_timestamp <int>,
    ## #   time_starting_at_timezone <chr>, time_minute <int>,
    ## #   time_added_time <int>, time_injury_time <int>,
    ## #   coaches_localteam_coach_id <int>, coaches_visitorteam_coach_id <int>,
    ## #   standings_localteam_position <int>,
    ## #   standings_visitorteam_position <int>,
    ## #   assistants_first_assistant_id <int>,
    ## #   assistants_second_assistant_id <int>,
    ## #   assistants_fourth_official_id <int>, leg <chr>, deleted <lgl>

``` r
get_fixtures(dates = c("2019-01-01", "2019-02-01"))
```

    ## # A tibble: 14 x 47
    ##        id league_id season_id stage_id round_id venue_id referee_id
    ##     <int>     <int>     <int>    <int>    <int>    <int>      <int>
    ##  1 1.03e7       501     12963  7508262   147766     8906      15818
    ##  2 1.03e7       501     12963  7508262   147766     8926      17265
    ##  3 1.03e7       501     12963  7508262   147766     8909      14855
    ##  4 1.03e7       501     12963  7508262   147766   288196      17256
    ##  5 1.03e7       501     12963  7508262   147766      219      14466
    ##  6 1.03e7       501     12963  7508262   147766     8922      14853
    ##  7 1.03e7       501     12963  7508262   147767     8926      19316
    ##  8 1.03e7       501     12963  7508262   147767     8928      14468
    ##  9 1.03e7       501     12963  7508262   147767     8909      15815
    ## 10 1.03e7       501     12963  7508262   147767   289858      14859
    ## 11 1.03e7       501     12963  7508262   147767   289869      17847
    ## 12 1.03e7       501     12963  7508262   147767     8943      18748
    ## 13 1.03e7       501     12963  7508262   147759     8909      17256
    ## 14 1.03e7       501     12963  7508262   147768     8906      17847
    ## # … with 40 more variables: localteam_id <int>, visitorteam_id <int>,
    ## #   winner_team_id <int>, weather_report_code <chr>,
    ## #   weather_report_type <chr>, weather_report_icon <chr>,
    ## #   weather_report_temperature_temp <dbl>,
    ## #   weather_report_temperature_unit <chr>, weather_report_clouds <chr>,
    ## #   weather_report_humidity <chr>, weather_report_wind_speed <chr>,
    ## #   weather_report_wind_degree <dbl>, commentaries <lgl>,
    ## #   attendance <int>, pitch <chr>, winning_odds_calculated <lgl>,
    ## #   formations_localteam_formation <chr>,
    ## #   formations_visitorteam_formation <chr>, scores_localteam_score <int>,
    ## #   scores_visitorteam_score <int>, scores_ht_score <chr>,
    ## #   scores_ft_score <chr>, time_status <chr>,
    ## #   time_starting_at_date_time <chr>, time_starting_at_date <chr>,
    ## #   time_starting_at_time <chr>, time_starting_at_timestamp <int>,
    ## #   time_starting_at_timezone <chr>, time_minute <int>,
    ## #   time_added_time <int>, time_injury_time <int>,
    ## #   coaches_localteam_coach_id <int>, coaches_visitorteam_coach_id <int>,
    ## #   standings_localteam_position <int>,
    ## #   standings_visitorteam_position <int>,
    ## #   assistants_first_assistant_id <int>,
    ## #   assistants_second_assistant_id <int>,
    ## #   assistants_fourth_official_id <int>, leg <chr>, deleted <lgl>

``` r
# missing: get by date range for team
```

## Livescores

``` r
get_live()
```

    ## # A tibble: 2 x 29
    ##       id league_id season_id stage_id round_id venue_id referee_id
    ##    <int>     <int>     <int>    <int>    <int>    <int>      <int>
    ## 1 1.19e7       271     12919  7088926   167805     5659      14652
    ## 2 1.19e7       501     12963  7508261   168045       NA      14859
    ## # … with 22 more variables: localteam_id <int>, visitorteam_id <int>,
    ## #   commentaries <lgl>, winning_odds_calculated <lgl>,
    ## #   scores_localteam_score <int>, scores_visitorteam_score <int>,
    ## #   time_status <chr>, time_starting_at_date_time <chr>,
    ## #   time_starting_at_date <chr>, time_starting_at_time <chr>,
    ## #   time_starting_at_timestamp <int>, time_starting_at_timezone <chr>,
    ## #   coaches_localteam_coach_id <int>, coaches_visitorteam_coach_id <int>,
    ## #   standings_localteam_position <int>,
    ## #   standings_visitorteam_position <int>,
    ## #   assistants_first_assistant_id <int>,
    ## #   assistants_second_assistant_id <int>,
    ## #   assistants_fourth_official_id <int>, leg <chr>, deleted <lgl>,
    ## #   group_id <int>

``` r
#get_live_now()
# all 
# inplay
```

## Comments

``` r
get_comments(10333321)
```

    ## # A tibble: 12 x 6
    ##    fixture_id important order goal  minute comment                         
    ##         <int> <lgl>     <int> <lgl>  <int> <chr>                           
    ##  1   10333321 FALSE        12 FALSE     87 Substitution -  Aberdeen. James…
    ##  2   10333321 TRUE         11 FALSE     82 Kris Boyd  - Kilmarnock -  rece…
    ##  3   10333321 FALSE        10 FALSE     79 Substitution -  Kilmarnock. Mik…
    ##  4   10333321 FALSE         9 FALSE     78 Substitution -  Aberdeen. Tommi…
    ##  5   10333321 TRUE          8 FALSE     77 Alan Power  - Kilmarnock -  rec…
    ##  6   10333321 TRUE          7 FALSE     75 Scott Boyd  - Kilmarnock -  rec…
    ##  7   10333321 TRUE          6 FALSE     73 Aaron Tshibola  - Kilmarnock - …
    ##  8   10333321 FALSE         5 FALSE     68 Substitution -  Aberdeen. Niall…
    ##  9   10333321 FALSE         4 FALSE     66 Substitution -  Kilmarnock. Ror…
    ## 10   10333321 FALSE         3 FALSE     60 Substitution -  Kilmarnock. Kri…
    ## 11   10333321 TRUE          2 FALSE     29 Graeme Shinnie  - Aberdeen -  r…
    ## 12   10333321 TRUE          1 FALSE     45 Lewis Ferguson  - Aberdeen -  r…

## Highlights

``` r
get_highlights(10333321)
```

    ## # A tibble: 12 x 6
    ##    fixture_id important order goal  minute comment                         
    ##         <int> <lgl>     <int> <lgl>  <int> <chr>                           
    ##  1   10333321 FALSE        12 FALSE     87 Substitution -  Aberdeen. James…
    ##  2   10333321 TRUE         11 FALSE     82 Kris Boyd  - Kilmarnock -  rece…
    ##  3   10333321 FALSE        10 FALSE     79 Substitution -  Kilmarnock. Mik…
    ##  4   10333321 FALSE         9 FALSE     78 Substitution -  Aberdeen. Tommi…
    ##  5   10333321 TRUE          8 FALSE     77 Alan Power  - Kilmarnock -  rec…
    ##  6   10333321 TRUE          7 FALSE     75 Scott Boyd  - Kilmarnock -  rec…
    ##  7   10333321 TRUE          6 FALSE     73 Aaron Tshibola  - Kilmarnock - …
    ##  8   10333321 FALSE         5 FALSE     68 Substitution -  Aberdeen. Niall…
    ##  9   10333321 FALSE         4 FALSE     66 Substitution -  Kilmarnock. Ror…
    ## 10   10333321 FALSE         3 FALSE     60 Substitution -  Kilmarnock. Kri…
    ## 11   10333321 TRUE          2 FALSE     29 Graeme Shinnie  - Aberdeen -  r…
    ## 12   10333321 TRUE          1 FALSE     45 Lewis Ferguson  - Aberdeen -  r…

## Head2Head

``` r
get_head2head(team1 = 309, team2 = 66)
```

    ## # A tibble: 35 x 50
    ##        id league_id season_id stage_id round_id venue_id referee_id
    ##     <int>     <int>     <int>    <int>    <int>    <int>      <int>
    ##  1 1.03e7       501     12963  7508262   147774     8946      18748
    ##  2 1.03e7       501     12963  7508262   147766     8922      14853
    ##  3 1.03e7       501     12963  7508262   147745     8946      14853
    ##  4 1.87e6       501      7953    56530   129141     8946      15815
    ##  5 1.87e6       501      7953    56530   129128     8922      14853
    ##  6 1.87e6       501      7953    56530   129122     8946      17259
    ##  7 3.79e5       501      1935     3225    52443     8946         NA
    ##  8 3.78e5       501      1935     3225    52284     8877         NA
    ##  9 3.77e5       501      1935     3225    52128     8946         NA
    ## 10 3.79e5       501      1934     3224    52432     8877         NA
    ## # … with 25 more rows, and 43 more variables: localteam_id <int>,
    ## #   visitorteam_id <int>, winner_team_id <int>, weather_report_code <chr>,
    ## #   weather_report_type <chr>, weather_report_icon <chr>,
    ## #   weather_report_temperature_temp <dbl>,
    ## #   weather_report_temperature_unit <chr>, weather_report_clouds <chr>,
    ## #   weather_report_humidity <chr>, weather_report_pressure <int>,
    ## #   weather_report_wind_speed <chr>, weather_report_wind_degree <int>,
    ## #   commentaries <lgl>, pitch <chr>, winning_odds_calculated <lgl>,
    ## #   formations_localteam_formation <chr>,
    ## #   formations_visitorteam_formation <chr>, scores_localteam_score <int>,
    ## #   scores_visitorteam_score <int>, scores_ht_score <chr>,
    ## #   scores_ft_score <chr>, time_status <chr>,
    ## #   time_starting_at_date_time <chr>, time_starting_at_date <chr>,
    ## #   time_starting_at_time <chr>, time_starting_at_timestamp <int>,
    ## #   time_starting_at_timezone <chr>, time_minute <int>,
    ## #   time_added_time <int>, time_injury_time <int>,
    ## #   coaches_localteam_coach_id <int>, coaches_visitorteam_coach_id <int>,
    ## #   standings_localteam_position <int>,
    ## #   standings_visitorteam_position <int>,
    ## #   assistants_first_assistant_id <int>,
    ## #   assistants_second_assistant_id <int>,
    ## #   assistants_fourth_official_id <int>, leg <chr>, deleted <lgl>,
    ## #   scores_localteam_pen_score <int>, scores_visitorteam_pen_score <int>,
    ## #   group_id <int>

## Teams

``` r
get_team(180)
```

    ## # A tibble: 1 x 10
    ##      id legacy_id name  short_code country_id national_team founded
    ##   <int>     <int> <chr> <chr>           <int> <lgl>           <int>
    ## 1   180       696 Kilm… KIL              1161 FALSE            1869
    ## # … with 3 more variables: logo_path <chr>, venue_id <int>,
    ## #   current_season_id <int>

``` r
# by id 
# by season
```

## Players

``` r
get_player(180)
```

    ## # A tibble: 1 x 15
    ##   player_id team_id country_id position_id common_name fullname firstname
    ##       <int>   <int>      <int>       <int> <chr>       <chr>    <chr>    
    ## 1       180      53        462           3 S. Sinclair S. Sinc… Scott    
    ## # … with 8 more variables: lastname <chr>, nationality <chr>,
    ## #   birthdate <chr>, birthcountry <chr>, birthplace <chr>, height <chr>,
    ## #   weight <chr>, image_path <chr>

## Topscores

``` r
get_topscores(season_id = 1273, agg = T)
```

    ## # A tibble: 1 x 4
    ##      id name      league_id is_current_season
    ##   <int> <chr>         <int> <lgl>            
    ## 1  1273 2005/2006       271 FALSE

## Venues

``` r
get_venue(8928)
```

    ## # A tibble: 1 x 7
    ##      id name      surface address    city  capacity image_path             
    ##   <int> <chr>     <chr>   <chr>      <chr>    <int> <chr>                  
    ## 1  8928 Pittodri… grass   Pittodrie… Aber…    22199 https://cdn.sportmonks…

``` r
# by id
# by season id
```

## Rounds

``` r
get_round(round_id = 147767)
```

    ## # A tibble: 1 x 7
    ##       id  name league_id season_id stage_id start      end       
    ##    <int> <int>     <int>     <int>    <int> <chr>      <chr>     
    ## 1 147767    23       501     12963  7508262 2019-01-26 2019-01-27

``` r
get_round(season_id = 12963)
```

    ## # A tibble: 38 x 7
    ##        id  name league_id season_id stage_id start      end       
    ##     <int> <int>     <int>     <int>    <int> <chr>      <chr>     
    ##  1 147745     1       501     12963  7508262 2018-08-04 2018-08-05
    ##  2 147746     2       501     12963  7508262 2018-08-11 2018-08-12
    ##  3 147747     3       501     12963  7508262 2018-08-25 2018-08-26
    ##  4 147748     4       501     12963  7508262 2018-09-01 2018-09-02
    ##  5 147749     5       501     12963  7508262 2018-09-14 2018-09-15
    ##  6 147750     6       501     12963  7508262 2018-09-22 2018-09-23
    ##  7 147751     7       501     12963  7508262 2018-09-29 2018-09-30
    ##  8 147752     8       501     12963  7508262 2018-10-06 2018-10-07
    ##  9 147753     9       501     12963  7508262 2018-10-20 2018-10-21
    ## 10 147754    10       501     12963  7508262 2018-10-23 2018-12-19
    ## # … with 28 more rows

## Odds

``` r
get_odds(10333321)
```

    ## # A tibble: 51 x 17
    ##        id name  suspended bookmaker_data_… bookmaker_data_…
    ##     <int> <chr> <lgl>                <int> <chr>           
    ##  1 1.00e0 3Way… FALSE             25679320 Sbo             
    ##  2 1.00e1 Home… FALSE                   97 Unibet          
    ##  3 8.00e1 3Way… FALSE             25679219 Marathon        
    ##  4 1.20e1 Over… FALSE             25679320 Sbo             
    ##  5 3.80e1 Over… FALSE             25679320 Sbo             
    ##  6 4.70e1 Over… FALSE             25679219 Marathon        
    ##  7 9.76e5 HT/F… FALSE             25679320 Sbo             
    ##  8 9.76e5 Clea… FALSE                    1 10Bet           
    ##  9 8.59e6 Clea… FALSE                    2 bet365          
    ## 10 9.76e5 Both… FALSE             25679219 Marathon        
    ## # … with 41 more rows, and 12 more variables:
    ## #   bookmaker_data_odds_data_label <chr>,
    ## #   bookmaker_data_odds_data_value <chr>,
    ## #   bookmaker_data_odds_data_probability <chr>,
    ## #   bookmaker_data_odds_data_dp3 <chr>,
    ## #   bookmaker_data_odds_data_american <int>,
    ## #   bookmaker_data_odds_data_winning <lgl>,
    ## #   bookmaker_data_odds_data_stop <lgl>,
    ## #   bookmaker_data_odds_data_last_update_date <chr>,
    ## #   bookmaker_data_odds_data_last_update_timezone_type <int>,
    ## #   bookmaker_data_odds_data_last_update_timezone <chr>,
    ## #   bookmaker_data_odds_data_total <chr>,
    ## #   bookmaker_data_odds_data_handicap <chr>

``` r
# by fixture and bookmarker
# by fixture and market
# by fixture id
# inplay odds by fixture id
```

## Coaches

``` r
get_coache(896462)
```

    ## # A tibble: 1 x 12
    ##   coach_id team_id country_id common_name fullname firstname lastname
    ##      <int>   <int>      <int> <chr>       <chr>    <chr>     <chr>   
    ## 1   896462     273       1161 D. McInnes  D. McIn… Derek     McInnes 
    ## # … with 5 more variables: nationality <chr>, birthdate <chr>,
    ## #   birthcountry <chr>, birthplace <chr>, image_path <chr>

## Stages

``` r
get_stage(stage_id = 7508262)
```

    ## # A tibble: 1 x 4
    ##        id name      league_id season_id
    ##     <int> <chr>         <int>     <int>
    ## 1 7508262 1st Phase       501     12963

``` r
get_stage(season_id = 12963)
```

    ## # A tibble: 2 x 5
    ##        id name      type        league_id season_id
    ##     <int> <chr>     <chr>           <int>     <int>
    ## 1 7508261 2nd Phase Group Stage       501     12963
    ## 2 7508262 1st Phase Group Stage       501     12963

``` r
# by season id
```

## Bookmarkers

``` r
get_bookmakers()
```

    ## # A tibble: 42 x 2
    ##       id name       
    ##    <int> <chr>      
    ##  1     1 10Bet      
    ##  2     2 bet365     
    ##  3     3 188Bet     
    ##  4     5 5 Dimes    
    ##  5     7 888Sport   
    ##  6     9 BetFred    
    ##  7    11 Bet-At-Home
    ##  8    13 BetCRIS    
    ##  9    15 Betfair    
    ## 10    17 BetOnline  
    ## # … with 32 more rows

``` r
get_bookmaker(book_id = 25679219)
```

    ## # A tibble: 1 x 2
    ##         id name    
    ##      <int> <chr>   
    ## 1 25679219 Marathon

``` r
# not working?
```

## Markets

``` r
get_markets()
```

    ## # A tibble: 516 x 2
    ##       id name                
    ##    <int> <chr>               
    ##  1     1 3Way Result         
    ##  2    10 Home/Away           
    ##  3    12 Over/Under          
    ##  4    28 Asian Handicap      
    ##  5    37 3Way Result 1st Half
    ##  6    38 Over/Under 1st Half 
    ##  7    47 Over/Under 2nd Half 
    ##  8    63 Double Chance       
    ##  9    69 Team To Score First 
    ## 10    75 Team To Score Last  
    ## # … with 506 more rows

``` r
get_market(id = 10)
```

    ## # A tibble: 1 x 2
    ##      id name     
    ##   <int> <chr>    
    ## 1    10 Home/Away

``` r
# not working?
```

## Team Squads

``` r
get_team_squads(season_id = 12963, team_id = 180)
```

    ## # A tibble: 25 x 40
    ##    player_id position_id number captain injured minutes appearences lineups
    ##        <int>       <int>  <int>   <int> <lgl>     <int>       <int>   <int>
    ##  1    172042           1      1       0 FALSE      1080          12      12
    ##  2    173098           1     13       0 FALSE         0           0       0
    ##  3     12321           2      2       0 FALSE      3131          36      35
    ##  4      3004           2      5       0 FALSE      2054          26      24
    ##  5    172665           2     16       0 FALSE      1490          17      16
    ##  6    174170           2     18       0 FALSE       172           2       2
    ##  7    173080           2      3       0 FALSE      3124          35      35
    ##  8      7057           3      6       0 FALSE      3044          35      34
    ##  9      2302           3      8       0 FALSE      2668          34      29
    ## 10      2259           3     29       0 FALSE      2478          34      29
    ## # … with 15 more rows, and 32 more variables: substitute_in <int>,
    ## #   substitute_out <int>, substitutes_on_bench <int>, goals <int>,
    ## #   assists <int>, saves <int>, inside_box_saves <int>, dispossesed <int>,
    ## #   interceptions <int>, yellowcards <int>, yellowred <int>,
    ## #   redcards <int>, tackles <int>, blocks <int>, hit_post <int>,
    ## #   fouls_committed <int>, fouls_drawn <int>, crosses_total <int>,
    ## #   crosses_accurate <int>, dribbles_attempts <int>,
    ## #   dribbles_success <int>, dribbles_dribbled_past <int>,
    ## #   duels_total <int>, duels_won <int>, passes_total <int>,
    ## #   passes_accuracy <int>, passes_key_passes <int>, penalties_won <int>,
    ## #   penalties_scores <int>, penalties_missed <int>,
    ## #   penalties_committed <int>, penalties_saves <int>

## TV-stations

``` r
get_tv(10333321)
```

    ## # A tibble: 9 x 2
    ##   fixture_id tvstation  
    ##        <int> <chr>      
    ## 1   10333321 BBC Alba   
    ## 2   10333321 bet365     
    ## 3   10333321 bet365.it  
    ## 4   10333321 BetClic.fr 
    ## 5   10333321 Chance     
    ## 6   10333321 Sportingbet
    ## 7   10333321 Tipsport   
    ## 8   10333321 Tipsport SK
    ## 9   10333321 Unibet

``` r
sessionInfo()
```

    ## R version 3.6.0 (2019-04-26)
    ## Platform: x86_64-apple-darwin15.6.0 (64-bit)
    ## Running under: macOS High Sierra 10.13.6
    ## 
    ## Matrix products: default
    ## BLAS:   /Library/Frameworks/R.framework/Versions/3.6/Resources/lib/libRblas.0.dylib
    ## LAPACK: /Library/Frameworks/R.framework/Versions/3.6/Resources/lib/libRlapack.dylib
    ## 
    ## locale:
    ## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ##  [1] sportmonks_0.0.0.9000 testthat_2.1.1        janitor_1.2.0        
    ##  [4] listviewer_2.1.0      xml2_1.2.0            jsonlite_1.6         
    ##  [7] httr_1.4.0            devtools_2.0.2        usethis_1.5.0        
    ## [10] forcats_0.4.0         stringr_1.4.0         dplyr_0.8.0.1        
    ## [13] purrr_0.3.2           readr_1.3.1           tidyr_0.8.3          
    ## [16] tibble_2.1.1          ggplot2_3.1.1         tidyverse_1.2.1      
    ## [19] badger_0.0.4         
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] pkgload_1.0.2      modelr_0.1.4       assertthat_0.2.1  
    ##  [4] rvcheck_0.1.3      cellranger_1.1.0   yaml_2.2.0        
    ##  [7] remotes_2.0.4      sessioninfo_1.1.1  pillar_1.3.1      
    ## [10] backports_1.1.4    lattice_0.20-38    glue_1.3.1        
    ## [13] rlist_0.4.6.1      digest_0.6.18      RColorBrewer_1.1-2
    ## [16] snakecase_0.9.2    rvest_0.3.3        colorspace_1.4-1  
    ## [19] htmltools_0.3.6    plyr_1.8.4         pkgconfig_2.0.2   
    ## [22] broom_0.5.2        haven_2.1.0        scales_1.0.0      
    ## [25] processx_3.3.0     generics_0.0.2     pacman_0.5.1      
    ## [28] withr_2.1.2        lazyeval_0.2.2     cli_1.1.0         
    ## [31] magrittr_1.5       crayon_1.3.4       readxl_1.3.1      
    ## [34] memoise_1.1.0      evaluate_0.13      ps_1.3.0          
    ## [37] fansi_0.4.0        fs_1.3.0           nlme_3.1-139      
    ## [40] pkgbuild_1.0.3     data.table_1.12.2  tools_3.6.0       
    ## [43] prettyunits_1.0.2  hms_0.4.2          munsell_0.5.0     
    ## [46] callr_3.2.0        compiler_3.6.0     rlang_0.3.4       
    ## [49] grid_3.6.0         rstudioapi_0.10    htmlwidgets_1.3   
    ## [52] rmarkdown_1.12     gtable_0.3.0       curl_3.3          
    ## [55] R6_2.4.0           lubridate_1.7.4    knitr_1.22        
    ## [58] utf8_1.1.4         rprojroot_1.3-2    dlstats_0.1.0     
    ## [61] desc_1.2.0         stringi_1.4.3      Rcpp_1.0.1        
    ## [64] tidyselect_0.2.5   xfun_0.6
