#Instalar pacotes pdfetch e quantmod em "Tools" 
library(pdfetch)
library(quantmod)

#Importa os valores do índice Bovespa para o R
pdfetch_YAHOO("^BVSP")
#Define BVSP
BOVESPA=pdfetch_YAHOO("^BVSP")
#gRÁFICO 
plot.ts(BOVESPA$`^BVSP.open`)
#Definindo um intervalo de tempo com quantmod
#Neste caso desde 2010
getSymbols("^BVSP" ,from = " 2010-01-01")
getSymbols("^IXIC", from = " 2010-01-01")
getSymbols("^BTC-USD", from = " 2010-01-01")
getSymbols("^IXIC", from = " 2010-01-01")
getSymbols("^IXIC", from = " 2010-01-01")
getSymbols("^IXIC", from = " 2010-01-01")
