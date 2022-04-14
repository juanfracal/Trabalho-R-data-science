library(usethis)
library(pdfetch)
library(quantmod)

dt <- "2010-01-01"

# INDEX VALUES SINCE 2010 
#IBOVESPA (OK)
getSymbols("^BVSP" ,from = " 2010-01-01", to = "2022-04-01", auto.assign= F)
#NASDAQ (No caso o SP500, composto pelas 500 maioresA empresas listadas na bolsa de NY)
getSymbols("^GSPC" , from = " 2010-01-01", to = "2022-04-01", auto.assign= F)
#CMC Crypto 200 Index (2019)
getSymbols("^CMC200" , from = " 2010-01-01", to = "2022-04-01", auto.assign= F)
#Mirae Asset Renda Fixa Pre Fundo De Indice (2018)
getSymbols("FIXA11.SA" , from = " 2010-01-01", to = "2022-04-01", auto.assign= F)
# Ouro futuro (OK)
getSymbols("GC=F" ,from = " 2010-01-01", to = "2022-04-01", auto.assign= F)
#Bitcoin (#2014)
getSymbols("BTC-USD" ,from = " 2010-01-01", to = "2022-04-01", auto.assign= F)


chartSeries(BVSP)
chartSeries(IXIC)
chartSeries(CMC200)
chartSeries(FIXA11.SA)
chartSeries(GC=F)
chartSeries(BTC-USD)
