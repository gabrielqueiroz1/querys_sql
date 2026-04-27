--Do inicaio ao fim do curso (2025/08/25 e 2025/08/29), quantos
--clientes assinaram a lista de presença?

--Na primeira query podemos observar que NO TOTAL tivemos
--1550 assinaturas na lista de presença

--Na segunda query temos a quantidade real de pessoas que 
--assinaram a lista de presença pelo menos 1x

SELECT
    DISTINCT(t1.IdCliente) AS IdCliente,
    t1.DtCriacao
FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE SUBSTR(t1.DtCriacao, 1, 10) >= '2025-08-25'
AND SUBSTR(t1.DtCriacao, 1, 10) <= '2025-08-29'
AND t3.IdProduto = 11

ORDER BY 1, 2;

SELECT
    COUNT(DISTINCT(t1.IdCliente)) AS QtdePresenca
FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE SUBSTR(t1.DtCriacao, 1, 10) >= '2025-08-25'
AND SUBSTR(t1.DtCriacao, 1, 10) <= '2025-08-29'
AND t3.IdProduto = 11;