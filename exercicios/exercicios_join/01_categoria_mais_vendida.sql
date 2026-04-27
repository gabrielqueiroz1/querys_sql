--Categoria que mais vende
--Resposta -> Chat

SELECT
    t2.DescCategoriaProduto,
    COUNT(DISTINCT t1.IdTransacao) AS QtdeTransacao
FROM transacao_produto AS t1
LEFT JOIN produtos AS t2
ON t1.IdProduto = t2.IdProduto
GROUP BY 1
ORDER BY 2 DESC;

SELECT
    t1.DescCategoriaProduto,
    COUNT(DISTINCT t2.IdTransacao) AS QtdeTransacao
FROM produtos AS t1
LEFT JOIN transacao_produto AS t2
ON t1.IdProduto = t2.IdProduto
GROUP BY 1
ORDER BY 2 DESC;