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
 