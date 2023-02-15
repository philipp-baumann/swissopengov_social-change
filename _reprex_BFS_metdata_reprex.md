*Local `.Rprofile` detected at `/home/spectral-cockpit/git/philipp-baumann/swissopengov_social-change/.Rprofile`*

``` r
library("BFS")
library("pxweb")
#> pxweb 0.16.2: R tools for the PX-WEB API.
#> https://github.com/ropengov/pxweb

# Goal: Download data and metadata about social welfare
# Source: https://www.bfs.admin.ch/bfs/de/home/statistiken/soziale-sicherheit/sozialhilfe/sozialhilfebeziehende/wirtschaftliche-sozialhilfe.assetdetail.23605870.html

get_pxweb_social_welfare <- function(number_bfs = "px-x-1304030000_121") {
  data <- BFS::bfs_get_data(number_bfs = number_bfs, language = "de")
  return(data)
}

get_pxweb_meta_social_welfare <- function(number_bfs = "px-x-1304030000_121") {
  meta <- BFS::bfs_get_data_comments(number_bfs = number_bfs, language = "de")
  return(meta)
}

get_pxweb_pkg_meta <- function(number_bfs = "px-x-1304030000_121") {
  language <- "de"
  # create the BFS api url
  pxweb_api_url <- paste0("https://www.pxweb.bfs.admin.ch/api/v1/", 
    language, "/", number_bfs, "/", number_bfs, ".px")
  px_meta <- pxweb::pxweb_get(pxweb_api_url)
  return(px_meta)
}


# just fetch the data via high-level function
dat_in_social_welfare <- get_pxweb_social_welfare()
#>   Downloading large query (in 162 batches):
#>   |                                                                              |                                                                      |   0%  |                                                                              |                                                                      |   1%  |                                                                              |=                                                                     |   1%  |                                                                              |=                                                                     |   2%  |                                                                              |==                                                                    |   2%
#> Error in pxweb_advanced_get(url = url, query = query, verbose = verbose): Too Many Requests (RFC 6585) (HTTP 429).

# fetch the data with relatively lower-level interface
meta_pxweb_social_welfare <- get_pxweb_pkg_meta()
#> Error in pxweb_advanced_get(url = url, query = query, verbose = verbose): Too Many Requests (RFC 6585) (HTTP 429).

# fetch metadata via high-level function
meta_social_welfare <- get_pxweb_meta_social_welfare()
#> Warning in open.connection(con, "rb"): cannot open URL
#> 'https://www.pxweb.bfs.admin.ch/api/v1/de/px-x-1304030000_121/px-x-1304030000_121.px':
#> HTTP status was '429 Unknown Error'
#> Error in open.connection(con, "rb"): cannot open the connection to 'https://www.pxweb.bfs.admin.ch/api/v1/de/px-x-1304030000_121/px-x-1304030000_121.px'

str(meta_pxweb_social_welfare$variables)
#> Error in str(meta_pxweb_social_welfare$variables): object 'meta_pxweb_social_welfare' not found

# do some manual debugging
language <- "de"
number_bfs <- "px-x-1304030000_121"
url_bfs <- "https://www.bfs.admin.ch/bfs/de/home/statistiken/soziale-sicherheit/sozialhilfe/sozialhilfebeziehende/wirtschaftliche-sozialhilfe.assetdetail.23605870.html"

html_raw <- xml2::read_html(url_bfs)
html_table <- rvest::html_node(html_raw, ".table")
df_table <- rvest::html_table(html_table)
number_bfs <- df_table$X2[grepl("px", df_table$X2)]

pxweb_api_url <- paste0("https://www.pxweb.bfs.admin.ch/api/v1/", language, "/", number_bfs, "/", number_bfs, ".px")
df_json <- jsonlite::fromJSON(txt = pxweb_api_url)

variables <- df_json$variables$code
values <- df_json$variables$values
# This should not be hard-coded
df <- rbind(c("*", "*","*","*"))
names(df) <- variables
#> Error in names(df) <- variables: 'names' attribute [7] must be the same length as the vector [4]
dims <- as.list(df)
pxq <- pxweb::pxweb_query(dims)
#> Error in pxweb_query.list(dims): Assertion on 'x' failed: Must have Object.

sessioninfo::session_info()
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.2.1 (2022-06-23)
#>  os       Rocky Linux 8.7 (Green Obsidian)
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  en_US.UTF-8
#>  ctype    en_US.UTF-8
#>  tz       Europe/Zurich
#>  date     2023-02-10
#>  pandoc   2.0.6 @ /usr/bin/ (via rmarkdown)
#> 
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  ! package     * version date (UTC) lib source
#>  P anytime       0.3.9   2020-08-27 [?] CRAN (R 4.2.1)
#>  P backports     1.4.1   2021-12-13 [?] CRAN (R 4.2.1)
#>  P BFS         * 0.4.4   2022-12-14 [?] CRAN (R 4.2.1)
#>  P checkmate     2.1.0   2022-04-21 [?] CRAN (R 4.2.1)
#>  P cli           3.6.0   2023-01-09 [?] CRAN (R 4.2.1)
#>  P curl          5.0.0   2023-01-12 [?] CRAN (R 4.2.1)
#>  P digest        0.6.31  2022-12-11 [?] CRAN (R 4.2.1)
#>  P dplyr         1.1.0   2023-01-29 [?] CRAN (R 4.2.1)
#>  P evaluate      0.20    2023-01-17 [?] CRAN (R 4.2.1)
#>  P fansi         1.0.4   2023-01-22 [?] CRAN (R 4.2.1)
#>  P fastmap       1.1.0   2021-01-25 [?] CRAN (R 4.2.1)
#>  P fs            1.6.1   2023-02-06 [?] CRAN (R 4.2.1)
#>  P generics      0.1.3   2022-07-05 [?] CRAN (R 4.2.1)
#>  P glue          1.6.2   2022-02-24 [?] RSPM (R 4.2.0)
#>  P htmltools     0.5.4   2022-12-07 [?] RSPM (R 4.2.1)
#>  P httr          1.4.4   2022-08-17 [?] CRAN (R 4.2.1)
#>  P janitor       2.2.0   2023-02-02 [?] CRAN (R 4.2.1)
#>  P jsonlite      1.8.4   2022-12-06 [?] CRAN (R 4.2.1)
#>  P knitr         1.42    2023-01-25 [?] CRAN (R 4.2.1)
#>  P lifecycle     1.0.3   2022-10-07 [?] RSPM (R 4.2.0)
#>  P lubridate     1.9.2   2023-02-10 [?] CRAN (R 4.2.1)
#>  P magrittr      2.0.3   2022-03-30 [?] RSPM (R 4.2.0)
#>  P pillar        1.8.1   2022-08-19 [?] RSPM (R 4.2.0)
#>  P pkgconfig     2.0.3   2019-09-22 [?] RSPM (R 4.2.0)
#>  P purrr         1.0.1   2023-01-10 [?] CRAN (R 4.2.1)
#>  P pxweb       * 0.16.2  2022-10-31 [?] CRAN (R 4.2.1)
#>  P R6            2.5.1   2021-08-19 [?] RSPM (R 4.2.0)
#>  P Rcpp          1.0.10  2023-01-22 [?] CRAN (R 4.2.1)
#>    renv          0.16.0  2022-09-29 [1] CRAN (R 4.2.1)
#>  P reprex        2.0.2   2022-08-17 [?] CRAN (R 4.2.1)
#>  P rlang         1.0.6   2022-09-24 [?] RSPM (R 4.2.0)
#>  P rmarkdown     2.20    2023-01-19 [?] CRAN (R 4.2.1)
#>  P rvest         1.0.3   2022-08-19 [?] CRAN (R 4.2.1)
#>  P selectr       0.4-2   2019-11-20 [?] CRAN (R 4.2.1)
#>  P sessioninfo   1.2.2   2021-12-06 [?] RSPM (R 4.2.0)
#>  P snakecase     0.11.0  2019-05-25 [?] CRAN (R 4.2.1)
#>  P stringi       1.7.12  2023-01-11 [?] CRAN (R 4.2.1)
#>  P stringr       1.5.0   2022-12-02 [?] CRAN (R 4.2.1)
#>  P tibble        3.1.8   2022-07-22 [?] RSPM (R 4.2.0)
#>  P tidyRSS       2.0.6   2022-08-25 [?] CRAN (R 4.2.1)
#>  P tidyselect    1.2.0   2022-10-10 [?] RSPM (R 4.2.0)
#>  P timechange    0.2.0   2023-01-11 [?] CRAN (R 4.2.1)
#>  P utf8          1.2.3   2023-01-31 [?] CRAN (R 4.2.1)
#>  P vctrs         0.5.2   2023-01-23 [?] CRAN (R 4.2.1)
#>  P withr         2.5.0   2022-03-03 [?] RSPM (R 4.2.0)
#>  P xfun          0.37    2023-01-31 [?] CRAN (R 4.2.1)
#>  P xml2          1.3.3   2021-11-30 [?] CRAN (R 4.2.1)
#>  P yaml          2.3.7   2023-01-23 [?] CRAN (R 4.2.1)
#> 
#>  [1] /home/spectral-cockpit/git/philipp-baumann/swissopengov_social-change/renv/library/R-4.2/x86_64-pc-linux-gnu
#>  [2] /home/spectral-cockpit/git/philipp-baumann/swissopengov_social-change/renv/sandbox/R-4.2/x86_64-pc-linux-gnu/6e5b3dc8
#> 
#>  P ── Loaded and on-disk path mismatch.
#> 
#> ──────────────────────────────────────────────────────────────────────────────
```

<sup>Created on 2023-02-10 with [reprex v2.0.2](https://reprex.tidyverse.org)</sup>

<details style="margin-bottom:10px;">

<summary>Standard output and standard error</summary>

``` sh
✖ Install the styler package in order to use `style = TRUE`.
```


</details>
