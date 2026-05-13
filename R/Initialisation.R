#fdafaa
library(rvest)
library(dplyr)
library(httr)
library(jsonlite)
url <- "https://fr.wikipedia.org/wiki/Box-office_mondial_des_films_d%27horreur"

page_web <- read_html(url)

data_web <- page_web |>
  html_node(".wikitable") |> 
  html_table()

data_web <- data.frame(data_web)

if (!dir.exists("data/raw/")) {
  dir.create("data/raw/", recursive = T)
}

saveRDS(data_web, "data/raw/data_wiki_raw.rds")


  
