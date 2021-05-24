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

########


