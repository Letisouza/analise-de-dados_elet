# Criando fatores

# cria-se um objeto com os valores desejados
raca <- c(1, 2, 3, 4, 2, 3, 1)

# cria-se um objeto as categorias desejadas
recode <- c(branco = 1, preto = 2, pardo = 3, indígena = 4)

# Reorganiza-se o objeto atribuindo os valores às categorias(níveis) e utilizando as estruturas de character como 
# nome desses níveis.
raca <- factor(raca, levels = recode, labels = names(recode))

######################################

