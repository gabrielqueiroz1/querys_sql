--Vendas do tipo presença e 5
--Solução sem sentido abaixo
SELECT
    IdProduto,
    SUM(CASE
            WHEN IdProduto = 11 THEN 1
            ELSE 0
    END) AS ListaPresenca,

    SUM(CASE
            WHEN IdProduto = 5 THEN 1
            ELSE 0
    END) AS MesagemChat,

    SUM(CASE
            WHEN IdProduto = 15 THEN 1
            ELSE 0
    END) AS Ponei
FROM transacao_produto
WHERE IdProduto IN(11, 5, 15)
GROUP BY IdProduto;

--Solução mais eficiente
SELECT
    IdProduto,
    COUNT(*) AS QtdTransacao
FROM transacao_produto
GROUP BY IdProduto;

--Usuario que mais juntou pontos no mês de Julho

SELECT 
    IdCliente,
    SUM(QtdePontos) AS ClienteMaisPontos,
    COUNT(IdTransacao) AS QtdeTransacao
FROM transacoes
WHERE DtCriacao >= '2025-07-01' AND DtCriacao < '2025-08-01'
GROUP BY IdCliente
HAVING SUM(QtdePontos) >= 4000
ORDER BY SUM(QtdePontos) DESC;