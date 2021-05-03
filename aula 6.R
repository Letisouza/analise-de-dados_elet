# Extraindo bases de dados

install.packages('jsonlite')
install.packages('XML')
install.packages('rvest')

# arquivo .xml (o site fonte é meio estranho, então não achei nada compatível, preferi repetir o exemplo. Queria a base da nasa,
# mas tinha um erro no codigo de xml que não deixava o R ler)

library(XML)

coursesreed <- xmlToDataFrame("http://aiweb.cs.washington.edu/research/projects/xmltk/xmldata/data/courses/reed.xml")

# arquivo .csv

bikesPEdados <- read.csv2("http://dados.recife.pe.gov.br/dataset/7fac73fa-c0bb-4bae-9c21-2a45b82016a2/resource/e6e4ac72-ff15-4c5a-b149-a1943386c031/download/estacoesbike.csv")

# arquivo json

library(jsonlite)

file <- "http://dados.recife.pe.gov.br/dataset/7fac73fa-c0bb-4bae-9c21-2a45b82016a2/resource/8f22ab97-2c18-411a-afcc-1ffbf0922605/download/metadados-estacoesbike.json"

bikesPEmetadado <- fromJSON(file)
bikesPEmetadado <- as.data.frame(bikesPEmetadado)

# arquivo html

library(rvest)

arquivo <- read_html("https://pt.wikipedia.org/wiki/Harry_Potter_(s%C3%A9rie_de_filmes)")
tabelas <- html_nodes(arquivo, "table")
hp <- html_table(tabelas[3], fill = T)
hp <- as.data.frame(hp)


####################################################


# Carga incremental de dados

solicitacoes156 <- read.csv2("http://dados.recife.pe.gov.br/dataset/99eea78a-1bd9-4b87-95b8-7e7bae8f64d4/resource/9afa68cf-7fd9-4735-b157-e23da873fef7/download/156_diario.csv", sep = ';', encoding = 'UTF-8')

solicitacoes156New <- read.csv2("http://dados.recife.pe.gov.br/dataset/99eea78a-1bd9-4b87-95b8-7e7bae8f64d4/resource/9afa68cf-7fd9-4735-b157-e23da873fef7/download/156_diario.csv", sep = ';', encoding = 'UTF-8')

# chave substituta

solicitacoes156$chave_substituta = apply(solicitacoes156[, c(5, 6, 9)], MARGIN = 1, FUN = function(i) paste(i, collapse = ""))

solicitacoes156New$chave_substituta = apply(solicitacoes156New[, c(5, 6, 9)], MARGIN = 1, FUN = function(i) paste(i, collapse = ""))

# verificando aplicação da chave

incremento_solicitacoes156 <- (!solicitacoes156New$chave_substituta %in% solicitacoes156$chave_substituta)

# juntando bases

solicitacao156 <- rbind(solicitacoes156, solicitacoes156[incremento_solicitacoes156, ])


###############################################

# fazendo scraping de html do wikipedia

arquivo <- read_html("https://pt.wikipedia.org/wiki/Harry_Potter_(s%C3%A9rie_de_filmes)")
tabelas <- html_nodes(arquivo, "table")
hp2 <- html_table(tabelas[5], fill = T)
hp2 <- as.data.frame(hp2)

# ou

library(tidyverse)

url <- "https://pt.wikipedia.org/wiki/Harry_Potter_(s%C3%A9rie_de_filmes)"
tabelas_2 <- url %>% read_html %>% html_nodes("table")
elenco <- as.data.frame(html_table(tabelas_2[5]))

