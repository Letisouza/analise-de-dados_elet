# Atividades

# Criando um dataframe

nome <- c("Leticia", "Daniel", "Danillo", "Mariana")

idade <- c(23, 22, 25, 21)

cidade <- c("Paulista", "Recife", "Recife", "Jaboatão")

curso <- c("Ciência Política", "Direito", "Relações Internacionais", "Ciência Política")

perfil_alunos <- data.frame(nome, idade, cidade, curso)
str(perfil_alunos)
head(perfil_alunos)
