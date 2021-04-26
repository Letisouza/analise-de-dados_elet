# Extração, transformação e leitura (etl)

# extração: puxar dados originais
# transformação: modificar a estrutura da informação
# leitura: salvar e carregar os dados em um repositório

# áreas do processo: data source, staging area, data target e BI (nível descritivo e diagnóstico)/BA (nível preditivo e prescritivo).

# -> staging area é a fase de conslidação, agregação e tratamento (higienização) dos dados.


# Extração, leitura e transformação (elt) - Big Data

# tranformar apenas os dados que se vai usar.

#################### Atividade 26/04 ########################

#1) ETL possui 3 áreas de processo: extração, transformação e leitura. A extração se refere ao momento de puxar os dados originais
#de qualquer local em que esteja disponível, seja um site, um documento etc. A transformação se refere ao tratamento desses dados,
#modificando a estrutura das informações e convertendo em formatos úteis e desejados. Já a leitura, última parte do processo, tem
#a ver com o salvamento desses dados trasnformados, de modo que todos os passos de análise serão feitos nessa base nova que foi salva.

#2) Agora que entendemos ETL, podemos falar de ELT. Direcionado para big data, o ELT inverte a ordem de processamento, fazendo a leitura
#dos dados antes da transformação. O foco em ELT é obter e processar em análise apenas informações desejadas, por isso a leitura é
#realizada e depois as tranformações e tratamentos são inicados, modificando os dados a partir do que se deseja, para depois gerar qualquer 
#outcome desejado em como observar estes dados.

# questão 2

# carrega a base de snistros de transito do site da PCR
sinistrosRecife2019Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/3531bafe-d47d-415e-b154-a881081ac76c/download/acidentes-2019.csv', sep = ';', encoding = 'UTF-8')

sinistrosRecife2020Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/fc1c8460-0406-4fff-b51a-e79205d1f1ab/download/acidentes_2020-novo.csv', sep = ';', encoding = 'UTF-8')

sinistrosRecife2021Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/2caa8f41-ccd9-4ea5-906d-f66017d6e107/download/acidentes_2021-jan.csv', sep = ';', encoding = 'UTF-8')

library(dplyr)

sinistrosRecife2019Raw <- sinistrosRecife2019Raw %>% 
  select(!endereco_cruzamento)

sinistrosRecife2019Raw <- sinistrosRecife2019Raw %>% 
  select(!numero_cruzamento)

sinistrosRecife2019Raw <- sinistrosRecife2019Raw %>% 
  select(!referencia_cruzamento)

sinistrosRecife2019Raw <- sinistrosRecife2019Raw %>% 
  rename(data = DATA)

# junta as bases de dados com comando rbind (juntas por linhas)

sinistrosRecifeRaw <- rbind(sinistrosRecife2019Raw, sinistrosRecife2020Raw, sinistrosRecife2021Raw)

# observa a estrutura dos dados
str(sinistrosRecifeRaw)

# modifca a data para formato date
sinistrosRecifeRaw$data <- as.Date(sinistrosRecifeRaw$data, format = "%Y-%m-%d")

# modifica natureza do sinistro de texto para fator
sinistrosRecifeRaw$natureza_acidente <- as.factor(sinistrosRecifeRaw$natureza_acidente)

sinistrosRecifeRaw$tipo <- as.factor(sinistrosRecifeRaw$tipo)

# cria funçaõ para substituir not available (na) por 0
naZero <- function(x) {
  x <- ifelse(is.na(x), 0, x)
}

# aplica a função naZero a todas as colunas de contagem
sinistrosRecifeRaw[, 15:25] <- sapply(sinistrosRecifeRaw[, 15:25], naZero)

# exporta em formato nativo do R
saveRDS(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.rds")

# exporta em formato tabular (.csv) - padrão para interoperabilidade
write.csv2(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.csv")
