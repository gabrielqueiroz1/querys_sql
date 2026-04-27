SELECT
    COUNT(*) AS QtdeTransacoes,
    COUNT(DISTINCT(IdCliente)) AS QtdClientesTransacoes
FROM transacoes
WHERE DtCriacao >= '2025-07-01' AND DtCriacao < '2025-08-01'
