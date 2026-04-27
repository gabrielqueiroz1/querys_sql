--Quantidade de transações de Lovers em 2024
--1ª Opção iniciando pela tabela FATO de transações
--2ª Opção iniciando pela tabela Produtos
--3ª Opção iniciando pela tabela DIM de transação produto

SELECT
    t3.DescCategoriaProduto AS CategoriaProduto,
    COUNT(DISTINCT(t1.IdTransacao)) AS QtdeTransacaoLovers
FROM transacoes AS t1
LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao
LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto
WHERE t1.DtCriacao >= '2024-01-01'
AND t1. DtCriacao < '2025-01-01'
AND t3.DescCategoriaProduto = 'lovers'
GROUP BY 1;

SELECT
    t1.IdProduto AS IdProduto,
    COUNT(DISTINCT(t2.IdTransacao)) AS QtdeTransacao,
    t1.DescNomeProduto AS NomeProduto,
    t1.DescCategoriaProduto AS DescCategoriaProduto
FROM produtos AS t1
LEFT JOIN transacao_produto AS t2
ON t1.IdProduto = t2.IdProduto
LEFT JOIN transacoes t3
ON t2.IdTransacao = t3.IdTransacao
WHERE t1.DescCategoriaProduto = 'lovers'
AND t3.DtCriacao >= '2024-01-01'
AND t3.DtCriacao < '2025-01-01'
GROUP BY 3;


SELECT
    t2.IdProduto AS IdProduto,
    COUNT(DISTINCT(t1.IdTransacao)) AS QtdeTransacao,
    t2.DescNomeProduto AS NomeProduto,
    t2.DescCategoriaProduto AS DescCategoriaProduto
FROM transacao_produto AS t1
LEFT JOIN produtos AS t2
ON t1.IdProduto = t2.IdProduto
LEFT JOIN transacoes t3
ON t1.IdTransacao = t3.IdTransacao
WHERE t2.DescCategoriaProduto = 'lovers'
AND t3.DtCriacao >= '2024-01-01'
AND t3.DtCriacao < '2025-01-01'
GROUP BY 3;