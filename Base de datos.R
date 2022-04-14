#automatizar tarefas repetitivas
library(usethis)
#Base de dados finaceira :
library(quantmod)
#Manipulação de dados:
library(data.table)
#Criar vizualizações:
library(plotly)
#Manipular os dados:
library(dplyr)
#Utilizar a função na.locf:
library(zoo)
#organização dos dados
library(tibble)
library(tidyverse)

#definindo datas
dt <- "2017-01-01"
df <- "2022-04-01"

# INDEX VALUES SINCE 2017 
#IBOVESPA
getSymbols("^BVSP" ,from =dt , to = df, auto.assign= F)
#NASDAQ (No caso o SP500, composto pelas 500 maioresA empresas listadas na bolsa de NY)
getSymbols("^GSPC" , from =dt, to = df, auto.assign= F)
#CMC Crypto 200 Index (2019)
getSymbols("^CMC200" , from =dt , to = df, auto.assign= F)
# Ouro futuro
getSymbols("GC=F" ,from =dt, to = df, auto.assign= F)
#Bitcoin 
getSymbols("BTC-USD" ,from =dt, to = df, auto.assign= F)
#Selic (Usando APIs do Banco Central)
url_selic <- paste0('http://api.bcb.gov.br/dados/serie/bcdata.sgs.11/dados?formato=csv&dataInicial=',
                    format(dates[1], '%d/%m/%Y'), '&dataFinal=', format(dates[2], '%d/%m/%Y'))
selic <- fread(url_selic)
selic$data <- as.Date(selic$data, from=dt, to=df, format = '%d/%m/%Y')
selic$valor <- as.numeric(gsub(",", ".", gsub("\\.", "", selic$valor)))
# IPCA (Usando APIs do Banco Central)
url_IPCA <- paste0('http://api.bcb.gov.br/dados/serie/bcdata.sgs.433/dados?formato=csv&dataInicial=',
                   format(dates[1], '%d/%m/%Y'), '&dataFinal=', format(dates[2], '%d/%m/%Y'))
IPCA <- fread(url_IPCA)
IPCA$data <- as.Date(IPCA$data, from=dt, to=df, format = '%d/%m/%Y')
IPCA$valor <- as.numeric(gsub(",", ".", gsub("\\.", "", IPCA$valor)))
# CDI (Usando APIs do Banco Central)
url_CDI <- paste0('http://api.bcb.gov.br/dados/serie/bcdata.sgs.12/dados?formato=csv&dataInicial=',
                  format(dates[1], '%d/%m/%Y'), '&dataFinal=', format(dates[2], '%d/%m/%Y'))
CDI <- fread(url_CDI)
CDI$data <- as.Date(CDI$data, from=dt, to=df, format = '%d/%m/%Y')
CDI$valor <- as.numeric(gsub(",", ".", gsub("\\.", "", CDI$valor)))

