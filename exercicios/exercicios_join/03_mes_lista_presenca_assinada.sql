--Qual o mês que tivemos mais lista de presença assinada?
--Mês com mais lista de presença assinada -> 2024-03 com 2526 transacoes
--Se prensarmos com a streak é 2747 do mesmo mês 2024-03
SELECT
    substr(t1.DtCriacao, 1, 7) AS AnoMes,
    substr(t1.DtCriacao, 8, -2) AS Mes,
    t3.DescNomeProduto AS NomeProduto,
    COUNT(DISTINCT(t1.IdTransacao)) AS QtdeTransacao
FROM transacoes AS t1
LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao
LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto
WHERE t3.IdProduto = 11
GROUP BY 1
ORDER BY 4 DESC
LIMIT 1;

SELECT
    substr(t1.DtCriacao, 1, 7) AS AnoMes,
    substr(t1.DtCriacao, 8, -2) AS Mes,
    t3.DescNomeProduto AS NomeProduto,
    COUNT(DISTINCT(t1.IdTransacao)) AS QtdeTransacao
FROM transacoes AS t1
LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao
LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto
WHERE t3.DescCategoriaProduto = 'present'
GROUP BY 1
ORDER BY 4 DESC
LIMIT 1;