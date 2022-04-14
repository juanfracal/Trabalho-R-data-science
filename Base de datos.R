library(usethis)
#Base de datos finaceira :
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
library(tidyverse)

dt <- "2017-01-01"
df <- "2022-04-01"
# INDEX VALUES SINCE 2010 
#IBOVESPA (OK)
getSymbols("^BVSP" ,from =dt , to = df, auto.assign= F)
#NASDAQ (No caso o SP500, composto pelas 500 maioresA empresas listadas na bolsa de NY)
getSymbols("^GSPC" , from =dt, to = df, auto.assign= F)
#CMC Crypto 200 Index (2019)
getSymbols("^CMC200" , from =dt , to = df, auto.assign= F)
#Mirae Asset Renda Fixa Pre Fundo De Indice (2018)
getSymbols("FIXA11.SA" , from =dt , to = df, auto.assign= F)
# Ouro futuro (OK)
getSymbols("GC=F" ,from =dt, to = df, auto.assign= F)
#Bitcoin (#2014
getSymbols("BTC-USD" ,from =dt, to = df, auto.assign= F)
#Selic (Usando APIs do Banco Central):

