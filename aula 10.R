# Criando fatores

# cria-se um objeto com os valores desejados
raca <- c(1, 2, 3, 4, 2, 3, 1)

# cria-se um objeto as categorias desejadas
recode <- c(branco = 1, preto = 2, pardo = 3, indígena = 4)

# Reorganiza-se o objeto atribuindo os valores às categorias(níveis) e utilizando as estruturas de character como 
# nome desses níveis.
raca <- factor(raca, levels = recode, labels = names(recode))

######################################

library(ade4)
library(arules)
library(poliscidata)


str(world)

# Seleção de colunas
worldselect <- world[ ,1:30]
# Dessa seleção, separar colunas que são fatores para serem colocadas em um objeto de reconhecimento
worldfactor <- unlist(lapply(worldselect, is.factor))
# Salvar em nova base apenas colunas reconhecidas como fatores do banco original
worldfactor <- worldselect[ ,worldfactor]
# Tranformação da base com fatores em dummy
worlddummy <- acm.disjonctif(worldfactor)

library(forcats)

# Contar frequência de categorias de fatores.
fct_count(worldfactor$religoin)
# Reclassificar casos para maior frequência, segunda maior ferquência e outros.
fct_lump(worldfactor$religoin, n = 2)

######################################

library(data.table)
library(dplyr)

# Tranformçao em data.table
worldselectDT <- worldselect %>% 
  setDT()

# Reg linear
worldselectDT[ ,lm(formula = hdi ~ dem_level4 + lifeex_f + gender_unequal + spendeduc + spendhealth)]

######################################

# Manipulação de dados: média de expectativa de vida de mulheres e homens por religião em países democráticos. 
worldselect %>% 
  filter(dem_level4 == "Full Democ") %>% 
  rename(religion = religoin) %>% 
  group_by(religion) %>% 
  summarize(media_f = mean(lifeex_f), media_m = mean(lifeex_m))


