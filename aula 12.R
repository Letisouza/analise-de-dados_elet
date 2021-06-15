library(dplyr)
library(pdftools)
library(textreadr)
library(stringr)

# Abrindo pdf
aula12 <- read_pdf('documentos/Aula_12_-_1506.pdf', ocr = T)

# Juntando páginas em apenas um documento 
aula12_total <- aula12 %>% 
  group_by(element_id) %>% 
  mutate(all_text = paste(text, collapse = " | ")) %>% 
  select(element_id, all_text) %>% 
  unique()

# Extraindo datas
datas <- str_extract_all(aula12_total$all_text, "\\d{2}/\\d{2}")

# Mudando "/" por "-" nas datas
aula12_modificado <- gsub("15/06", "15-06", aula12_total$all_text)

data_hifen <- str_extract_all(aula12_modificado, "\\d{2}-\\d{2}")



