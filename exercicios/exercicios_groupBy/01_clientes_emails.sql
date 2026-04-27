SELECT
    SUM(flEmail) AS QtdeEmail
FROM clientes;


SELECT *
FROM transacoes
LIMIT 10;

SELECT *
FROM transacao_produto
LIMIT 10;

SELECT *
FROM produtos
LIMIT 10;

SELECT *
FROM clientes
LIMIT 10;


SELECT
    SUBSTR(DtCriacao, 1, 7) AS AnoMes,
    COUNT(IdTransacao) AS QtdeTransacao
FROM transacoes
GROUP BY 1
ORDER BY 1;

SELECT
    t1.*,
    t2.*
FROM clientes AS t1
LEFT JOIN transacoes AS t2
ON t1.IdCliente = t2.IdCliente
WHERE t1.DtCriacao >= '2025-01-01'
ORDER BY t1.DtCriacao
LIMIT 10;