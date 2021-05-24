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





