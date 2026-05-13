#utilisation du LLM GROQ

library(ellmer)
library(dplyr)
library(stringr)

input <- readRDS("data/raw/data_wiki_raw.rds")
output_file <- "data/clean/data_wiki_clean.rds"
batch_size <- 10

input <- input |>
  mutate(type = NA)

if(ncol(input) == 7) {
    cat("\n \t === Bonjour, la variable est déjà retirée ===")
} else {
  input <- input |> 
    select(-Réf)
}

api_key <- Sys.getenv("GROQ_API_KEY")

if (!file.exists(output_file)){
  df <- readRDS(input)
} else {
  df <- readRDS(output_file)
}


prompt_text <- "You are a classifier. Use one word between religion and other to categorize each film based on their name"

chat <- ellmer::chat_groq(
  system_prompt = prompt_text,
  model = "llama-3.3-70b-versatile",
  api_key = api_key
)


for (i in nrow(input)){
  res <- chat$chat(input$Titre)
}

texte <- as.character(res)
categorization <- str_extract_all(texte, "\\w+")
categorization

z <- data.frame(categorization)
colnames(z) <- "blabla"

z <- z |> 
  filter(blabla == "Religion" | blabla == "Other")

colnames(z) <- "type"

output <- input |> 
  mutate(z)

table(output$type)

