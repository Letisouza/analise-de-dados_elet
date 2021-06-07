library(poliscidata)
library(data.table)
library(funModeling) 
library(tidyverse) 

base <- world

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


