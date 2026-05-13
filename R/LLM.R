#utilisation du LLM GROQ

library(ellmer)
library(dplyr)
library(stringr)

input <- readRDS("data/raw/data_wiki_raw.rds")

input <- input |>
  mutate(type = NA)

if(ncol(input) == 7) {
    cat("\n \t === Bonjour, la variable est déjà retirée ===")
} else {
  input <- input |> 
    select(-Réf)
}







