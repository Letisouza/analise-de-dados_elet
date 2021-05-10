library(data.table)

enderecobase <- 'bases_originais/largeData.csv'

# medindo extração 1 (via amostragem com read.csv)

base1 <- read.csv2(enderecobase, nrows=20)  

AmostraClasses <- sapply(base1, class) # encontra a classe da amostra

# passa as classes a partir da amostra para criar novo objeto com a base original + nova coluna de classes
system.time(base1nova <- data.frame(read.csv2("bases_originais/largeData.csv", colClasses = AmostraClasses)))  

# medindo extração 2 (via função fread, que já faz amostragem automaticamente)
system.time(base2 <- fread(enderecobase))

# prints na pasta "documentos": print1: extração / print2: extração 2.