#Integrantes: Juan Francisco, Renan Olivier e Guilherme Vaccari
#Nosso objetivo é criar diferentes carteiras com distribuições diferentes de diversos ativos como Renda Variável, Renda fixa, ouro e criptomoedas.
#Depois comparariamos as carteiras em relação aos Retornos, Risco, Sharpe, Volatilidade anualizada e Máx. Drawdown.
#Por último, responderíamos a pergunta: Vale apena investir em criptoativos?

#Integrantes: Juan Francisco, Renan Olivier e Guilherme Vaccari
#Nosso objetivo é criar diferentes carteiras com distribuições diferentes de diversos ativos como Renda Variável, Renda fixa, ouro e criptomoedas.
#Depois comparariamos as carteiras em relação aos Retornos, Risco, Sharpe, Volatilidade anualizada e Máx. Drawdown.
#Por último, responderíamos a pergunta: Vale apena investir em criptoativos?

#pega as rotinas das bibliotecas necessárias

suppressPackageStartupMessages(require (timeSeries))
suppressPackageStartupMessages(require (fPortfolio)) 
suppressPackageStartupMessages(require(quantmod))
suppressPackageStartupMessages(require(caTools))

#Lista dos tickers dos ativos usados na construção do portifólio 

TickerList <- c("^BVSP", "^GSPC","^CMC200", "GC=F", "BTC-USD")

#lê os preços de fechamento das ações e mantém apenas elas para uso de análise

ClosingPricesRead <- NULL
for (Ticker in TickerList)
  ClosingPricesRead <- cbind(ClosingPricesRead,
                             getSymbols.yahoo(Ticker, from="1950-01-01", verbose=FALSE, auto.assign=FALSE)[,6]) # [,6] = mantém preços ajustados

#mantém apenas as datas com preços de fechamento

ClosingPrices <- ClosingPricesRead[apply(ClosingPricesRead,1,function(x) all(!is.na(x))),]

#converte preços para retornos diários

returns <- as.timeSeries((tail(ClosingPrices,-1) / as.numeric(head(ClosingPrices,-1)))-1)

#calcula fronteira eficiente

Frontier <- portfolioFrontier(returns)

#monta o gráfico da fronteira

plot(Frontier,1) 

#gera as médias e a matrix de covariância dos retornos dos preços dos ativos

getStatistics(Frontier)$mean #input de dados na fronteira eficiente
cor(returns)

#gerar gráfico de risco e retorno anualizado
#converter de retorno diário para anualizado e pontos de risco na fronteira eficiente

riskReturnPoints <- frontierPoints(Frontier) # get risk and return values for points on the efficient frontier
annualizedPoints <- data.frame(targetRisk=riskReturnPoints[, "targetRisk"] * sqrt(252),
                               targetReturn=riskReturnPoints[,"targetReturn"] * 252)

plot(annualizedPoints)

#Gráfico do índice Sharpe para cada ponto na fronteira

riskFreeRate <- 0.02
plot((annualizedPoints[,"targetReturn"] - riskFreeRate) / annualizedPoints[,"targetRisk"], xlab="point on efficient frontier", ylab="Sharpe ratio")

#gera gráfico de alocação para cada ativo para cada ponto da fronteira eficiente 
#gráfico de pesos na fronteira

allocations <- getWeights(Frontier@portfolio) #pega alocações em cada ponto da fronteira eficiente
colnames(allocations) <- TickerList
barplot(t(allocations), col=rainbow(ncol(allocations)+2), legend=colnames(allocations))

allocations

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

#outras restrições

constraints <- c("minW[1:length(TickerList)]=.10","maxW[1:length(TickerList)]=.60")


#referencias (vistas em 13/04, 14/04 e 01/06):
#https://medium.com/@gabriela.koreeda/an%C3%A1lise-de-uma-carteira-de-renda-fixa-em-r-d13510e95ada
#https://github.com/gabrielakoreeda/carteira-investimentos/blob/master/carteira.R
#https://www.rdocumentation.org/packages/zoo/versions/1.8-9/topics/na.locf
#https://www.youtube.com/watch?v=uwuPQUa2TjI&t=457s&ab_channel=codebliss
#https://www.rdocumentation.org/packages/zoo/versions/1.8-9/topics/na.locf
#https://www.youtube.com/watch?v=7rFsu48oBn8&ab_channel=C%C3%B3digoQuant-Finan%C3%A7asQuantitativas
#https://www.youtube.com/watch?v=SN4vpCY95k0
