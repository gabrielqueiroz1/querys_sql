
--Selecionando todos os clientes que estão com o e-mail cadastrado
--SELECT *
--FROM clientes
--WHERE flEmail = 1

--Selecionando todas transações de produtos onde o valor é igual a 50
--SELECT *
--FROM transacao_produto
--WHERE vlProduto = 50

--Selecionando todos os clientes que tem uma quantidade de pontos maior que 500
--SELECT *
--FROM clientes
--WHERE qtdePontos > 500
--ORDER BY qtdePontos DESC

--Selecionando todos os produtos que tem a palavra "churn" na descrição de produto
--SELECT *
--FROM produtos
--WHERE DescNomeProduto LIKE '%churn%'

--Selecionando todos os produtos que tem a palavra "churn" na descrição de categoria
--Menos custosa

--SELECT *
--FROM produtos
--WHERE DescCategoriaProduto = 'churn_model'

--SELECT
--    idCliente,
--    COUNT(idCliente) OVER(PARTITION BY idCliente) AS QTD
--FROM clientes
--GROUP BY IdCliente


SELECT
    DISTINCT(IdCliente),
    SUBSTR(DtCriacao, 1, 10)
FROM transacoes
WHERE SUBSTR(DtCriacao, 1, 10) >= '2025-08-25'
AND SUBSTR(DtCriacao, 1, 10) < '2025-08-30'
ORDER BY 1