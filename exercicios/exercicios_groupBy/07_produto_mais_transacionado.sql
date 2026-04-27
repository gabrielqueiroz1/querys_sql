--Qual o produto mais transacionado?
--Resposta: ChatMessage(5) = 202210
--Vale ressaltar que neste caso específico uma compra tem apenas um produto
--mas em casos reais faria sentido usarmos o SUM() para ver a quantidade
--de produtos na compra, porque uma compra pode ter N produtos do mesmo tipo
--ou não
SELECT
    transacao_produto.IdProduto,
    CASE
        WHEN produtos.DescNomeProduto <> 'NULL' THEN produtos.DescNomeProduto
        ELSE 'N/A'
        END AS DescNomeProduto,
    COUNT(transacao_produto.IdProduto) AS QtdeTransacaoProduto
FROM transacao_produto
LEFT JOIN produtos
ON transacao_produto.IdProduto = produtos.IdProduto
GROUP BY transacao_produto.IdProduto
ORDER BY 3 DESC
LIMIT 1;

--Lista dos produtos transacionados
SELECT
    transacao_produto.IdProduto,
    CASE
        WHEN produtos.DescNomeProduto <> 'NULL' THEN produtos.DescNomeProduto
        ELSE 'N/A'
        END AS DescNomeProduto,
    COUNT(transacao_produto.IdProduto) AS QtdeTransacaoProduto
FROM transacao_produto
LEFT JOIN produtos
ON transacao_produto.IdProduto = produtos.IdProduto
GROUP BY transacao_produto.IdProduto
ORDER BY 3 DESC;

--Solução com o que estudamos até o momento

SELECT
    IdProduto,
    COUNT(IdProduto) AS QtdeTransacaoProduto
FROM transacao_produto
GROUP BY IdProduto
ORDER BY 2 DESC;
