--Quantidade de pontos por dia

SELECT
    substr(DtCriacao, 1, 10) AS DtCriacao,
    ROUND(AVG(QtdePontos), 2) AS ValorMedioDia
FROM transacoes
WHERE QtdePontos > 0
GROUP BY substr(DtCriacao, 1, 10)
ORDER BY DtCriacao
LIMIT 5;

--Ideia caso não tivessemos registros por hora
SELECT
    DtCriacao,
    ROUND(AVG(QtdePontos), 2) AS ValorMedioDia
FROM transacoes
WHERE QtdePontos > 0
GROUP BY substr(DtCriacao, 1, 10)
ORDER BY DtCriacao
LIMIT 5;

--Quantidade média de pontos por dia em TODA a tabela
--Resposta: 5259
SELECT
    SUM(QtdePontos) AS TotalPontos,
    COUNT(DISTINCT(substr(DtCriacao, 1, 10))) AS DtCriacaoUnico,
    SUM(QtdePontos) / COUNT(DISTINCT(substr(DtCriacao, 1, 10))) AS ValorMedioDia
FROM transacoes
WHERE QtdePontos > 0;
