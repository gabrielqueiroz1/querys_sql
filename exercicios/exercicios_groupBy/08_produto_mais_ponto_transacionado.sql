--Qual o produto com mais pontos transacionado
SELECT
    IdProduto,
    SUM(vlProduto * QtdeProduto) AS TotalPontos,
    COUNT(QtdeProduto) AS QtdePontosTransacionados
FROM transacao_produto
GROUP BY 1
ORDER BY 2 DESC;
