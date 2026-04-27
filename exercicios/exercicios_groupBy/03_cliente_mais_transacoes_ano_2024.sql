SELECT
    idCliente,
    COUNT(IdTransacao) AS QtdeTransacao
FROM transacoes
WHERE DtCriacao >= '2024-01-01'
AND DtCriacao < '2025-01-01'

GROUP BY IdCliente
ORDER BY COUNT(IdTransacao) DESC
LIMIT 1