SELECT
    idCliente,
    SUM(QtdePontos) AS PontosPositivo
FROM transacoes
WHERE DtCriacao >= '2025-05-01' AND DtCriacao < '2025-06-01'
AND QtdePontos > 0
GROUP BY idCliente
ORDER BY SUM(QtdePontos) DESC
LIMIT 1

--apenas o nome do cliente
SELECT
    idCliente
FROM transacoes
WHERE DtCriacao >= '2025-05-01' AND DtCriacao < '2025-06-01'
AND QtdePontos > 0
GROUP BY idCliente
ORDER BY SUM(QtdePontos) DESC
LIMIT 1