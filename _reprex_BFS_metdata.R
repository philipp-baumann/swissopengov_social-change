library("BFS")
library("pxweb")

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

# fetch the data with relatively lower-level interface
meta_pxweb_social_welfare <- get_pxweb_pkg_meta()

# fetch metadata via high-level function
meta_social_welfare <- get_pxweb_meta_social_welfare()

str(meta_pxweb_social_welfare$variables)

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
# why this is hard-coded? is this given by by the PxWeb spec?
df <- rbind(c("*", "*","*","*"))
names(df) <- variables
dims <- as.list(df)
pxq <- pxweb::pxweb_query(dims)

sessioninfo::session_info()
