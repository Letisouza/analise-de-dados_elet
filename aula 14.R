library(tidyverse)
library(stringr)

# extraindo base

base <- read.csv2("bases_originais/basegeral.csv")

# Corrijindo NAs

skimr::skim(base$dt_primeiros_sintomas)

base$dt_primeiros_sintomas <- Hmisc::impute(base$dt_primeiros_sintomas, "random")

# calculando, para cada municipio, o total de casos confirmado e negativos

glimpse(base)

neg <- as.data.table(table(base$classe == "NEGATIVO", by = base$municipio)) %>% 
  filter(V2 == T)

conf <- as.data.table(table(base$classe == "CONFIRMADO", by = base$municipio)) %>% 
  filter(V2 == T)


# Criando uma variável binária se o sintoma tem tosse ou não

base2 <- base %>% mutate(sintomas_tosse = ifelse(grepl(paste("TOSSE", collapse="|"), sintomas), '1', '0'))


# Calculando casos confirmados e negativos tiveram tosse

neg2 <- as.data.table(table(base2$classe == "NEGATIVO" & base2$sintomas_tosse == 1, by = base2$municipio)) %>% 
  filter(V2 == T)

conf2 <- as.data.table(table(base2$classe == "CONFIRMADO" & base2$sintomas_tosse == 1, by = base2$municipio)) %>% 
  filter(V2 == T)
            
# Estimando média móvel de 7 dias de negativos e confirmados

library(zoo)

base_neg <- base %>%
  arrange(as.Date(dt_notificacao)) %>% 
  filter(classe == "NEGATIVO") %>% 
  mutate(negativo_m = round(rollmean(x = table(classe), 7, align = "right", fill = NA), 2))

base_conf <- base %>%
  arrange(as.Date(dt_notificacao)) %>% 
  filter(classe == "CONFIRMADO") %>% 
  mutate(confirmado_m = round(rollmean(x = table(classe), 7, align = "right", fill = NA), 2))



