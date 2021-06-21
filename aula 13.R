# Criando e convertendo sequências de datas e tempos

data_date <- seq(as.Date("1998-04-12 05:30"), as.Date("2021-04-12 00:00"), 
                 by = "day")
str(data_date)

data_xct <- seq(as.POSIXct("1998-04-12 05:30"), as.POSIXct("2021-04-12 00:00"), 
                by = "month")

str(data_xct)

data_xlt <- seq(as.POSIXlt("1998-04-12 05:30"), as.POSIXlt("2021-04-12 00:00"), 
                by = "hour")

str(data_xlt)

# Componentes e Operações

library(lubridate)

# Dias da semana
wday(data_xct, label = T, abbr = T)

data_xlt + minutes(60)

year(data_date)

##############################################

# Abrindo base de covid
url = 'https://raw.githubusercontent.com/wcota/covid19br/master/cases-brazil-states.csv' 
covidBR = read.csv2(url, encoding='latin1', sep = ',') 

# Modificando data
covidBR$date <- as.Date(covidBR$date, format = "%Y-%m-%d") 
str(covidBR)

# Predição: vetores e variáveis auxiliares
covidBR$dia <- seq(1:length(covidBR$date)) 

predDia = data.frame(dia = covidBR$dia) 
predSeq = data.frame(dia = seq(max(covidBR$dia)+1, max(covidBR$dia)+180))

predDia <- rbind(predDia, predSeq)

library(drc)

fitLL <- drm(deaths ~ dia, fct = LL2.5(),
             data = covidBR, robust = 'mean')

# Prevendo para frente com base em predDia
predLL <- data.frame(predicao = ceiling(predict(fitLL, predDia))) 
predLL$data <- seq.Date(as.Date('2020-03-12'), by = 'day', length.out = length(predDia$dia)) 

predLL <- merge(predLL, covidBR, by.x ='data', by.y = 'date', all.x = T) 

# Visualização interativa de dados

library(plotly)

plot_ly(predLL) %>% 
  add_trace(x = ~data, y = ~predicao, type = 'scatter', mode = 'lines', name = "Mortes - Predição") %>% 
  add_trace(x = ~data, y = ~deaths, name = "Mortes - Observados", mode = 'lines') %>% 
  layout(
    title = 'Predição de Mortes de COVID 19 no Brasil', 
    xaxis = list(title = '', showgrid = FALSE), 
    yaxis = list(title = 'Mortes por Dia', showgrid = FALSE),
    hovermode = "compare")

# Manipulação de datas e séries temporais

library(zoo) 
library(tidyverse)

covidBR <- covidBR %>% mutate(newDeathsMM7 = round(rollmean(x = newDeaths, 7, align = "right", fill = NA), 2))

covidBR <- covidBR %>% mutate(newDeathsL7 = dplyr::lag(newDeaths, 7)) 

plot_ly(covidBR) %>% 
  add_trace(x = ~date, y = ~newDeaths, type = 'scatter', mode = 'lines', name = "Novas Mortes") %>% 
  add_trace(x = ~date, y = ~newDeathsMM7, name = "Novas Mortes MM7", mode = 'lines') %>% 
  layout(title = "Novas Mortes de COVID19 no Brasil", 
    xaxis = list(title = '', showgrid = FALSE), 
    yaxis = list(title = 'Novas Mortes por Dia', showgrid = FALSE),
    hovermode = "compare")

