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

#############################################

