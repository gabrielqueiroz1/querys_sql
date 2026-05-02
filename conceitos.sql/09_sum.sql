--Pontos ganho em Julho

--SELECT
--    SUM(qtdePontos) AS PontosGanhosJulho
--FROM transacoes
--WHERE DtCriacao >= '2025-07-01' AND DtCriacao < '2025-08-01'
--AND QtdePontos >= 1

--Pontos ganhos, trocados e geral em Julho
--QTD Transações positivas e trocas

SELECT
    SUM(QtdePontos) AS QtdePontosJulho,
    SUM(CASE
        WHEN QtdePontos > 0 THEN QtdePontos
    END) AS QtdePontosGerados,

    COUNT(CASE
        WHEN QtdePontos > 0 THEN QtdePontos
    END) AS QtdeTransacaoPositivo,
    
    SUM(CASE
        WHEN QtdePontos < 0 THEN QtdePontos
    END * - 1) AS QtdePontosTrocados,

    COUNT(CASE
        WHEN QtdePontos < 0 THEN QtdePontos
    END) AS QtdeTransacao

FROM transacoes
WHERE DtCriacao >= '2025-07-01' AND DtCriacao < '2025-08-01'
ORDER BY QtdePontos ASC
