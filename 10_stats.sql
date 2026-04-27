--Estatisticas gerais do saldo da conta do cliente

SELECT
    IdCliente,
    SUM(CASE
        WHEN QtdePontos > 0 THEN QtdePontos
   END) AS PontosGanhos,

    CASE
        WHEN QtdePontos > 0 THEN 1
    ELSE 0
    END AS AlgumPonto
FROM clientes
GROUP BY idCliente

--Quantas pessoas tem a Twitch

SELECT
    SUM(flTwitch) AS QtdeTwitch
FROM clientes