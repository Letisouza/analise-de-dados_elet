library(poliscidata)
library(data.table)
library(funModeling) 
library(tidyverse) 

base <- world

# Valores ausentes

# checar quantidades de na
status(base)

# criando a shadow matrix
x <- as.data.frame(abs(is.na(base)))

head(x)

# mantém apenas variáveis que possuem NA
y <- x[which(sapply(x, sd) > 0)]

# teste de aleatoriedade: correlação entre as variáveis NA
cor(y)

###############################

# Outliers 

library(plotly)

# carregar dados covid19 Pernambuco
covid19PE <- fread('https://dados.seplag.pe.gov.br/apps/basegeral.csv')

covid19PEMun <- covid19PE %>% count(municipio, sort = T, name = 'casos') %>% mutate(casos2 = sqrt(casos), casosLog = log10(casos))

# Distância interquartil

# gráfico pra identificar outliers
plot_ly(y = covid19PEMun$casos2, type = "box", text = covid19PEMun$municipio, boxpoints = "all", jitter = 0.3)
# verifica os valores outliers
boxplot.stats(covid19PEMun$casos2)$out
boxplot.stats(covid19PEMun$casos2, coef = 2)$out # o 2 muda de 1.5 pra 2 a distãncia interquartil.

# Determina as posições dos outliers na base.
covid19PEOut <- boxplot.stats(covid19PEMun$casos2)$out
covid19PEOutIndex <- which(covid19PEMun$casos2 %in% c(covid19PEOut))
covid19PEOutIndex

# gráfico pra identificar outliers
plot_ly(y = covid19PEMun$casosLog, type = "box", text = covid19PEMun$municipio, boxpoints = "all", jitter = 0.3)
# verifica os valores outliers
boxplot.stats(covid19PEMun$casosLog)$out
boxplot.stats(covid19PEMun$casosLog, coef = 2)$out # o 2 muda de 1.5 pra 2 a distãncia interquartil.

# Determina as posições dos outliers na base.
covid19PEOutlog <- boxplot.stats(covid19PEMun$casosLog)$out
covid19PEOutIndexlog <- which(covid19PEMun$casosLog %in% c(covid19PEOut))
covid19PEOutIndexlog

# filtro de Hamper

# Determina as posições dos outliers
lower_bound <- median(covid19PEMun$casos2) - 3 * mad(covid19PEMun$casos2, constant = 1)
upper_bound <- median(covid19PEMun$casos2) + 3 * mad(covid19PEMun$casos2, constant = 1)
(outlier_ind <- which(covid19PEMun$casos2 < lower_bound | covid19PEMun$casos2 > upper_bound))

# Determina as posições dos outliers
lower_bound <- median(covid19PEMun$casosLog) - 3 * mad(covid19PEMun$casosLog, constant = 1)
upper_bound <- median(covid19PEMun$casosLog) + 3 * mad(covid19PEMun$casosLog, constant = 1)
(outlier_ind <- which(covid19PEMun$casosLog < lower_bound | covid19PEMun$casosLog > upper_bound))

# teste de Rosner

library(EnvStats)

# seleciona os outliers que são estatiticamente significantes.
covid19PERosner <- rosnerTest(covid19PEMun$casos2, k = 10)
covid19PERosner

covid19PERosner2 <- rosnerTest(covid19PEMun$casosLog, k = 10)
covid19PERosner2

###############################

# Imputação


(ToothGrowthNASeed <- round(runif(10, 1, 50))) # criamos 10 valores aleatórios

(ToothGrowth$len[ToothGrowthNASeed] <- NA) # imputamos NA nos valores aleatórios

# Imputação numérica por tendência central

library(Hmisc) # facilita imputação de tendência central

# Média
ToothGrowth$len <- impute(ToothGrowth$len, fun = mean)

is.imputed(ToothGrowth$len) # teste se o valor foi imputado
table(is.imputed(ToothGrowth$len)) # tabela de imputação por sim / não


# imputação de valores semelhantes (hot deck) por instâncias
ToothGrowth$len[ToothGrowthNASeed] <- NA # imputamos NA nos valores aleatórios

library(VIM) # facilita imputação de valores semelhantes
ToothGrowth2 <- kNN(ToothGrowth)
