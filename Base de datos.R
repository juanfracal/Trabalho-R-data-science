#Integrantes: Juan Francisco, Renan Olivier e Guilherme Vaccari
#Nosso objetivo é criar diferentes carteiras com distribuições diferentes de diversos ativos como Renda Variável, ouro e criptomoedas.
#A ideia é usar a literatura clássica financeira para encontrar a alocação ideal para cada nível de risco
#Por último, responderíamos a pergunta: Vale apena investir em criptoativos?

#pega as rotinas das bibliotecas necessárias

suppressPackageStartupMessages(require (timeSeries))
suppressPackageStartupMessages(require (fPortfolio)) 
suppressPackageStartupMessages(require(quantmod))
suppressPackageStartupMessages(require(caTools))
suppressPackageStartupMessages(require(forecastHybrid))
suppressPackageStartupMessages(require(tidyquant))

#Lista dos tickers dos ativos usados na construção do portifólio 
#BVSP é indicativo do IBOVESPA, benchmark do mercado acionário brasileiro
#GSPC é indicativo do SP500, benchmark do mercado acionário americano
#GC=F é indicativo dos contratos de ouro, hedge anti-inflacionário
#BTC-USD é indicativo do Bitcoin em dólar, principal criptomoeda do mercado criptográfico
#ETH-USD é indicativo do Ethereum em dólar, principal plataforma de Defi do mercado criptográfico

portfolio = c("BTC-USD","ETH-USD","^BVSP","^GSPC","GC=F")
getSymbols(portfolio, src="yahoo", from="2017-01-01")
barChart(`BTC-USD`,theme='white.mono',bar.type='hlc')
barChart(`ETH-USD`,theme='white.mono',bar.type='hlc')
barChart(`GC=F`,theme='white.mono',bar.type='hlc')
barChart(`BVSP`,theme='white.mono',bar.type='hlc')
barChart(`GSPC`,theme='white.mono',bar.type='hlc')

TickerList <- c("^BVSP", "^GSPC", "GC=F", "BTC-USD", "ETH-USD")

#lê os preços de fechamento das ações e mantém apenas elas para uso de análise

ClosingPricesRead <- NULL
for (Ticker in TickerList)
  ClosingPricesRead <- cbind(ClosingPricesRead,
                             getSymbols.yahoo(Ticker, from="2017-01-01", verbose=FALSE, auto.assign=FALSE)[,6]) 
# [,6] = mantém preços ajustados

#mantém apenas as datas com preços de fechamento

ClosingPrices <- ClosingPricesRead[apply(ClosingPricesRead,1,function(x) all(!is.na(x))),]

#converte preços para retornos diários

returns <- as.timeSeries((tail(ClosingPrices,-1) / as.numeric(head(ClosingPrices,-1)))-1)

#calcula fronteira eficiente

Frontier <- portfolioFrontier(returns)

#monta o gráfico da fronteira
plot(Frontier,1)
plot(Frontier,3)
plot(Frontier,7)

#gera as médias e a matrix de covariância dos retornos dos preços dos ativos

getStatistics(Frontier)$mean #input de dados na fronteira eficiente
cor(returns)

#gerar gráfico de risco e retorno anualizado
#converter de retorno diário para anualizado e pontos de risco na fronteira eficiente

riskReturnPoints <- frontierPoints(Frontier) #pega valores de risco e retorno na fronteira
annualizedPoints <- data.frame(targetRisk=riskReturnPoints[, "targetRisk"] * sqrt(252),
                               targetReturn=riskReturnPoints[,"targetReturn"] * 252)

plot(annualizedPoints)

#Gráfico do índice Sharpe para cada ponto na fronteira

riskFreeRate <- 0.1265
plot((annualizedPoints[,"targetReturn"] - riskFreeRate) / annualizedPoints[,"targetRisk"], xlab="point on efficient frontier", ylab="Sharpe ratio")

#gera gráfico de alocação para cada ativo para cada ponto da fronteira eficiente 
#gráfico de pesos na fronteira

allocations <- getWeights(Frontier@portfolio) #pega alocações em cada ponto da fronteira eficiente
colnames(allocations) <- TickerList
barplot(t(allocations), col=rainbow(ncol(allocations)+2), legend=colnames(allocations), xlab="sucetibilidade a risco", ylab="proporção de alocação")

allocations

annualizedPoints

#portifólios com restrições diferentes

constraints <- "minW[1:length(TickerList)]=-1"

Frontier <- portfolioFrontier(returns, constraints = constraints)
Frontier.LongOnly <- portfolioFrontier(returns)

riskReturnPoints <- frontierPoints(Frontier)
annualizedPoints <- data.frame(targetRisk=riskReturnPoints[, "targetRisk"] * sqrt(252),
                               targetReturn=riskReturnPoints[,"targetReturn"] * 252)
riskReturnPoints.LongOnly <- frontierPoints(Frontier.LongOnly)
annualizedPoints.LongOnly <- data.frame(targetRisk=riskReturnPoints.LongOnly[, "targetRisk"] * sqrt(252),
                                        targetReturn=riskReturnPoints.LongOnly[,"targetReturn"] * 252)

xlimit <- range(annualizedPoints[,1], annualizedPoints.LongOnly[,1])
ylimit <- range(annualizedPoints[,2], annualizedPoints.LongOnly[,2])

plot(annualizedPoints.LongOnly, xlim=xlimit, ylim=ylimit, pch=16, col="blue")
points(annualizedPoints, col="red", pch=16)
legend("right", legend=c("long only","constrained"), col=c("blue","red"), pch=16)

#referencias (vistas em 13/04, 14/04 e 01/06):
#https://www.youtube.com/watch?v=uwuPQUa2TjI&t=457s&ab_channel=codebliss
#https://www.rdocumentation.org/packages/zoo/versions/1.8-9/topics/na.locf
#https://www.youtube.com/watch?v=7rFsu48oBn8&ab_channel=C%C3%B3digoQuant-Finan%C3%A7asQuantitativas
#https://www.youtube.com/watch?v=SN4vpCY95k0
#https://www.youtube.com/watch?v=O33dF532pRo&ab_channel=ElliotNoma
#https://rpubs.com/Lucas_Venturini/661262
#aula 18 2 Diogo Robaina
#https://elliotnoma.wordpress.com/2013/01/22/construct-a-stock-portfolio-using-r/
