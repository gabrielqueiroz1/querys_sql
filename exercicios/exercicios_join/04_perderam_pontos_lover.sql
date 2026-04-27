--Quais clientes maus perderam pontos por Lover?
--IdProduto -> 1 e 3 ou DescCategoriaProduto -> lovers


SELECT
    t1.IdCliente AS IdCliente,
    SUM(t1.QtdePontos) AS QtdePontosNegativos
FROM transacoes AS t1
LEFT JOIN transacao_produto AS t2
    ON t1.IdTransacao = t2.IdTransacao
LEFT JOIN produtos AS t3
    ON t2.IdProduto = t3.IdProduto
WHERE t3.DescCategoriaProduto = 'lovers'
GROUP BY 1
ORDER BY SUM(t1.QtdePontos) ASC;

--Quanto ele gastou com cada IdProduto
SELECT
    t1.IdCliente AS IdCliente,
    t3.IdProduto AS CategoriaProduto,
    SUM(t1.QtdePontos) AS QtdePontosNegativos
FROM transacoes AS t1
LEFT JOIN transacao_produto AS t2
    ON t1.IdTransacao = t2.IdTransacao
LEFT JOIN produtos AS t3
    ON t2.IdProduto = t3.IdProduto
WHERE t3.DescCategoriaProduto = 'lovers'
GROUP BY 1, 2
ORDER BY SUM(t1.QtdePontos) ASC;