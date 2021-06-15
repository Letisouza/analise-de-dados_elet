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


########################################################

nome <- c("Leticia", "Danillo", "Mariana", "Daniel", "Caio")
curso <- c("Ciência Política", "Relações Internacionais", "Ciência Política"," Direito", "Ciência Política")
idade <- c(23, 22, 22, 24, 33)
país <- c("Colômbia", "Brasil", "Canadá", "França", "França")

base1 <- data.frame(nome, curso, idade, país)

nome <- c("leticia s", "danillo a", "mariana b", "daniel d", "caio m")
inst <- c("UFPE", "Estácio", "UFPE", "UNICAP", "UFPE")

base2 <- data.frame(nome, inst)

# Unindo bases diferentes por aprximação de padrão de caracteres
library(fuzzyjoin)

base3 <- stringdist_join(base1, base2, mode='left')

# Criando uma nova base com nova variável dada a presença de uma categoria na variável 'curso'
base4 <- base3 %>% mutate(tag_CP = ifelse(grepl(paste("Ciência Política", collapse="|"), curso), '1', '0'))

                       


