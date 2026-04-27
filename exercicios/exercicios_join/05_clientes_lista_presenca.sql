--Quais clientes assinaram a lista de presença no dia 2025/08/25

SELECT
    DISTINCT(t1.IdCliente) AS IdCliente,
    t2.IdProduto AS ListaPresenca
FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
    ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
    ON t2.IdProduto = t3.IdProduto

WHERE SUBSTR(t1.DtCriacao, 1, 10) = '2025-08-25'
AND t3.IdProduto = 11

ORDER BY 1;

SELECT
    COUNT(DISTINCT(t1.IdCliente)) AS QtdePresenca
FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
    ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
    ON t2.IdProduto = t3.IdProduto

WHERE SUBSTR(t1.DtCriacao, 1, 10) = '2025-08-25'
AND t3.IdProduto = 11;
