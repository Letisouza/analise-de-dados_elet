# Atividades

# Criando um dataframe

nome <- c("Leticia", "Daniel", "Danillo", "Mariana")

idade <- c(23, 22, 25, 21)

cidade <- c("Paulista", "Recife", "Recife", "Jaboatão")

curso <- c("Ciência Política", "Direito", "Relações Internacionais", "Ciência Política")

instituicao <- c("UFPE", "Católica", "Estácio", "UFPE")

perfil_alunos <- data.frame(nome, idade, cidade, curso, instituicao)
str(perfil_alunos)
head(perfil_alunos)

# Criando variáveis

dnormal <- rnorm(150)
dnormal

dbinomial <- rbinom(150, 1, 0.3)
dbinomial

index <- seq(1, length(dbinomial))
index

# Amostragem e Bootstrapping

bootstrappingnormal50 <- replicate(50, sample(dnormal, 10, replace = TRUE))
bootstrappingnormal50

bootstrappingnormal75 <- replicate(75, sample(dnormal, 10, replace = TRUE))
bootstrappingnormal75

bootstrappingnormal100 <- replicate(100, sample(dnormal, 10, replace = TRUE))
bootstrappingnormal100


# Calculando com o R

hist(dnormal)

dnormal_central <- dnormal - mean(dnormal)
hist(dnormal_central)


# Indexação

dnormal[35]
dnormal[dnormal > 2 & dnormal < 3]

# Controle e repetição

perfil_alunos$codificacao <- ifelse(perfil_alunos$instituicao == "UFPE", 0, 1)
head(perfil_alunos)


# Criando funções

    # função para saudar quem entrou na UFPE recentemente

novato <- function(nro) {
  if (nro == 1) {
    cat("Bem-Vinda(o)\n")
  }
}

novato(1)

    
# Funções vetorizadas


sapply(perfil_alunos[ ,2], mean)

