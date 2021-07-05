# Extraindo base
base <- read.csv2("bases_originais/basegeral.csv")

library(tidyverse)

# Total de casos confirmados e óbitos

library(lubridate)

base$semana_epi <- as.POSIXlt(base$dt_notificacao)
base$semana_epi <- epiweek(base$semana_epi)

base_classe_agg <- base %>% 
  select(municipio, semana_epi, dt_notificacao, classe, evolucao) %>% 
  filter(classe == "CONFIRMADO") %>% 
  group_by(municipio, semana_epi, classe) %>% 
  summarise(total = n()) %>% 
  rename(tipo = classe)
  
base_obito_agg <- base %>% 
  select(municipio, semana_epi, dt_notificacao, classe, evolucao) %>% 
  filter(evolucao == "OBITO") %>% 
  group_by(municipio, semana_epi, evolucao) %>% 
  summarise(total = n()) %>% 
  rename(tipo = evolucao)
  
base2_agg <- union(base_classe_agg, base_obito_agg) %>% 
  arrange(municipio, semana_epi)

# Base IBGE: enriquecimento

library(readxl)
ibge <- read_excel("bases_originais/tabela6579.xlsx")

ibge$indexador <- str_detect(ibge$`Tabela 6579 - População residente estimada`,"(PE)") 
ibge_PE <- ibge %>%   
  filter(indexador == T)

ibge_PE <- ibge_PE %>% 
  rename(municipio = `Tabela 6579 - População residente estimada`,
         pop = ...2)

ibge_PE <- ibge_PE %>% 
  mutate(municipio = str_remove_all(municipio, "(PE)")) %>% 
  mutate(municipio = gsub("[:space:][()]", "", municipio)) %>% 
  mutate(municipio = str_trim(municipio))

ibge_PE_final <- ibge_PE %>% 
  select(municipio, pop) %>% 
  mutate(municipio = str_to_upper(municipio))

base_joinned <- left_join(base2_agg, ibge_PE_final, by = "municipio")

# Incidência  e letalidade a cada 100000 mil habitantes

base_final <- base_joinned %>% 
  group_by(municipio, semana_epi, tipo, total, pop) %>% 
  summarise(prop = total/100000)

# Extração

write.csv2(base_final, "bases_tratadas/base_final.csv")

