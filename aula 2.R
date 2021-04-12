# Bootsatraping: repetição
# Exemplo com amostragem com a função replicate()
# Estrutura declarada de repetição: for (i in -) { 

# } 

# Funções vetorizadas: apply(), sapply(), mapply()

# Indexação: []. Indexação de conjunto de dados: [c(, ,)]


#       *********Atividades 12/04************

#Instalação de pacotes

install.packages("caret")
library("caret")

install.packages("dplyr")
library("dplyr")

install.packages("ggplot2")
library("ggplot2")

install.packages("tidyr")
library("tidyr")

install.packages("data.table")
library("data.table")


# Criação de objetos complexos

vetor1 <- c(2,4,6,8,10)

vetor2 <- c(T, T, T, F, F)

vetor3 <- factor(c("A", "B", "C", "1", "2"),
                 levels = c("LETRA", "NÚMERO"),
                 labels = c("LETRA", "LETRA", "LETRA", "NÚMERO", "NÚMERO"))

df <- data.frame(vetor1, vetor2, vetor3)
str(df)

lista1 <- list(vetor1, vetor2, vetor3, df)
lista1
