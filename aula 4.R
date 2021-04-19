# criação de dataframe: 500 casos, 6 variáveis.

# 2 variáveis normais

set.seed(1); normal1 <- rnorm(500, mean = 2.5, sd = 2)
set.seed(2); normal2 <- rnorm(500, mean = 5, sd = 1)

# 1 variável poisson

set.seed(3); poisson <- rpois(500, 25)

# 1 variável binomial negativa

set.seed(4); binomialneg <- rnbinom(500, 4, prob = 0.8)

# 1 variável binomial

set.seed(5); binomial <- rbinom(500, 1, 0.5)

# 1 variável index 

index <- seq(1, length(normal2))

# dataframe e 1 variável categorica baseada na binomial

df <- data.frame(normal1, normal2, index, poisson, binomialneg, binomial)

df$codequali <- ifelse(df$binomial == 0, "zero","um")

head(df)
summary(df)

# centralizar variáveis normais

central_normal1 <- normal1 - mean(normal1)
central_normal2 <- normal2 - mean(normal2)

# modificando variáveis de contagem

df$poisson

poisson_mod <- ifelse(df$poisson == 0, 1, poisson)
poisson_mod


df$binomialneg

binomialneg_mod <- ifelse(df$binomialneg == 0, 1, binomialneg)
binomialneg_mod


# criando novo dataframe

bootstrapping1 <- replicate(1, sample(normal1, 100, replace = TRUE))
bootstrapping1
bootstrapping2 <- replicate(1, sample(normal2, 100, replace = TRUE))
bootstrapping2
bootstrapping3 <- replicate(1, sample(poisson, 100, replace = TRUE))
bootstrapping3
bootstrapping4 <- replicate(1, sample(binomialneg, 100, replace = TRUE))
bootstrapping4
bootstrapping5 <- replicate(1, sample(binomial, 100, replace = TRUE))
bootstrapping5
bootstrapping6 <- replicate(1, sample(index, 100, replace = TRUE))
bootstrapping6

bootstrapping_df <- data.frame(bootstrapping1, bootstrapping2, bootstrapping3, bootstrapping4, bootstrapping5, bootstrapping6)
summary(bootstrapping_df)
head(bootstrapping_df)
