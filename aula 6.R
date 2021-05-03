# Extraindo bases de dados

install.packages('jsonlite')
install.packages('XML')
install.packages('rvest')

# arquivo .xlm (o site fonte é meio estranho, então não achei nada compatível, preferi repetir o exemplo. Queria a base da nasa,
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

#arquivo html

library(rvest)

arquivo <- read_html("https://pt.wikipedia.org/wiki/Harry_Potter_(s%C3%A9rie_de_filmes)")
tabelas <- html_nodes(arquivo, "table")
hp <- html_table(tabelas[3], fill = T)
hp <- as.data.frame(hp)

