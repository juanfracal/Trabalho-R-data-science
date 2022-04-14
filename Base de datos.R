library(usethis)
library(pdfetch)
library(quantmod)

dt <- "2010-01-01"

# INDEX VALUES SINCE 2010 
#IBOVESPA
getSymbols("^BVSP" ,from = " 2010-01-01", to = "2022-04-01")
#NASDAQ
getSymbols("^IXIC" , from = " 2010-01-01", to = "2022-04-01")
#CMC Crypto 200 Index
getSymbols("^CMC200" , from = " 2010-01-01", to = "2022-04-01")
#Mirae Asset Renda Fixa Pre Fundo De Indice
getSymbols("FIXA11.SA" , from = " 2010-01-01", to = "2022-04-01")
# Ouro futuro
getSymbols("GC=F" ,from = " 2010-01-01", to = "2022-04-01")
#Bitcoin 
getSymbols("BTC-USD" ,from = " 2010-01-01", to = "2022-04-01")


chartSeries(BVSP)
chartSeries(IXIC)
chartSeries(CMC200)
chartSeries(FIXA11.SA)
chartSeries(GC=F)
chartSeries(BTC-USD)
