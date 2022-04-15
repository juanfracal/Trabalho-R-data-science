#Integrantes: Juna Francisco, Renan Olivier e Guilherme Vaccari
#Nosso objetivo é criar diferentes carteiras com distribuições diferentes de diversos ativos como Renda Variável, Renda fixa, ouro e criptomoedas.
#Depois comparariamos as carteiras em relação aos Retornos, Risco, Sharpe, Volatilidade anualizada e Máx. Drawdown.
#automatizar tarefas repetitivas
library(usethis)
#Base de dados finaceira (Utilizamos este pacote para levar base de dados do Yahoo Finance diretamente para o R) :
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

#definindo datas para "filtrar" os valores da base de dados do Yahoo Finance 
dt <- "2017-01-01"
df <- "2022-04-01"

# INDEX VALUES SINCE 2017 
#IBOVESPA (índice de ações da bolsa brasileira, há 400 empresas listadas mas apenas 82 ações compondo o índice)
#getSymbols() pertence ao pacote quantmod, trazendo base de datos diretamente do Yahoo Finance. Para isso colocamos o código do ativo no site e definimos as datas
getSymbols("^BVSP" ,from =dt , to = df, auto.assign= F)
#NASDAQ (No caso o SP500, composto pelas 500 maioresA empresas listadas na bolsa de NY)
getSymbols("^GSPC" , from =dt, to = df, auto.assign= F)
#CMC Crypto 200 Index (2019) 200 maiores criptoativos por capitalização de mercado (marketcap)
getSymbols("^CMC200" , from =dt , to = df, auto.assign= F)
# Ouro futuro
getSymbols("GC=F" ,from =dt, to = df, auto.assign= F)
#Bitcoin 
getSymbols("BTC-USD" ,from =dt, to = df, auto.assign= F)
#Para a Renda fixa utilizamos o banco de dados disponibilizado pelo próprio Banco Central
#Novamente filtraremos o período no qual trabalharemos e trocando caracteres da base de datos 
#Selic (Usando APIs do Banco Central)
url_selic <- paste0('http://api.bcb.gov.br/dados/serie/bcdata.sgs.11/dados?formato=csv&dataInicial=',
                    format(dates[1], '%d/%m/%Y'), '&dataFinal=', format(dates[2], '%d/%m/%Y'))
selic <- fread(url_selic)
#Definimos a data da base de datos: 
selic$data <- as.Date(selic$data, from=dt, to=df, format = '%d/%m/%Y')
#Troca de carateres
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

#referencias (vistas em 13/04 e 14/04):
#https://medium.com/@gabriela.koreeda/an%C3%A1lise-de-uma-carteira-de-renda-fixa-em-r-d13510e95ada
#https://github.com/gabrielakoreeda/carteira-investimentos/blob/master/carteira.R
#https://www.rdocumentation.org/packages/zoo/versions/1.8-9/topics/na.locf
#https://www.youtube.com/watch?v=uwuPQUa2TjI&t=457s&ab_channel=codebliss
#https://www.rdocumentation.org/packages/zoo/versions/1.8-9/topics/na.locf
#https://www.youtube.com/watch?v=7rFsu48oBn8&ab_channel=C%C3%B3digoQuant-Finan%C3%A7asQuantitativas
