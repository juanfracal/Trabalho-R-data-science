library(usethis)
library(pdfetch)
library(quantmod)

# INDEX VALUES SINCE 2010 
#IBOVESPA
getSymbols("^BVSP" ,from = " 2010-01-01", to = "2022-04-01")
chartSeries(BVSP)
#NASDAQ
getSymbols("^IXIC" , from = " 2010-01-01", to = "2022-04-01")
chartSeries(IXIC)
#CMC Crypto 200 Index
getSymbols("^CMC200" , from = " 2010-01-01", to = "2022-04-01")
chartSeries(CMC200)
#Itau FIC De Fundos De Investimento Em Direitos Creditorios De Infraestrutura
getSymbols("IFRA11.SA" , from = " 2010-01-01", to = "2022-04-01")
#Mirae Asset Renda Fixa Pre Fundo De Indice
getSymbols("FIXA11.SA" , from = " 2010-01-01", to = "2022-04-01")
chartSeries(FIXA11.SA)
# Ouro futuro
getSymbols("GC=F" ,from = " 2010-01-01", to = "2022-04-01")
chartSeries(GC=F)
