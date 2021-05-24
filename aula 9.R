# Tidyverse

library(funModeling)
library(tidyverse)

# base mtcars

# Olhar o comportamento dos dados
glimpse(mtcars)

# Revela a estrutura dos dados, se há missings etc
status(mtcars)

# Frequência de variáveis em fator
freq(mtcars) # na base, não há nenhuma variável não numérica

# Gráfico de frequência das variáveis
plot_num(mtcars)

# Dados estatísticos básicos de variáveis numéricas
profiling_num(mtcars)


# base toothgrowth

glimpse(ToothGrowth)
status(ToothGrowth)
freq(ToothGrowth)
plot_num(ToothGrowth)
profiling_num(ToothGrowth)

###################################

# Pivotando bases long para wide

base_dentes <- ToothGrowth %>% pivot_wider(names_from = supp, values_from = dose)

library(poliscidata)

glimpse(world)

world <- world %>% 
  select(country, gini10, dem_level4)

base_world <- world %>% pivot_wider(names_from = dem_level4, values_from = gini10)

###################################

glimpse(world)
status(world)

# Tirando os NA da variável
world_valid <- drop_na(world, gini10)

status(world_valid)

###################################

library(readxl)

polity5 <- read_excel("bases_originais/p5v2018.xls")

polity5 <- polity5 %>% 
  filter(year == 2014) %>% 
  select(country, polity, polity2)

# Juntando bases de dados

world_polity2014 <- left_join(world_valid, polity5, by = c('country' = 'country'))

status(world_polity2014)

world_polity2014_valid <- drop_na(world_polity2014, polity, polity2)

###################################

glimpse(world_polity2014_valid)

# Validando a transformação dos dados

library(validate)

validacao <- validator(gini10 != is.na(gini10), polity != is.na(polity), polity2 != is.na(polity2))

confronto <- confront(world_polity2014_valid, validacao)
summary(confronto)

plot(confronto)
