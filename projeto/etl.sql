WITH tb_transacoes AS (
    SELECT
        IdTransacao,
        IdCliente,
        QtdePontos,
        DATETIME(SUBSTR(DtCriacao, 1, 19)) AS DtCriacao,
        JULIANDAY('now') - JULIANDAY(SUBSTR(DtCriacao, 1, 10)) AS DtDiff
    FROM transacoes
),

tb_cliente AS (
    SELECT
        IdCliente,
        DATETIME(SUBSTR(DtCriacao, 1, 19)) AS DtCriacao,
        JULIANDAY('now') - JULIANDAY(SUBSTR(DtCriacao, 1, 10)) AS idadeBase
    FROM clientes
),

tb_sumario_transacoes AS (

SELECT
    IdCliente,
    COUNT(IdTransacao) AS QtdeTransacoesVida,
    COUNT(CASE
            WHEN DtDiff <= 56 THEN IdTransacao END) AS QtdeTransacoesD58,
    COUNT(CASE
            WHEN DtDiff <= 28 THEN IdTransacao END) AS QtdeTransacoesD28,
    COUNT(CASE
            WHEN DtDiff <= 14 THEN IdTransacao END) AS QtdeTransacoesD14,
    COUNT(CASE
            WHEN DtDiff <= 7 THEN IdTransacao END) AS QtdeTransacoesD7,
    SUM(QtdePontos) AS saldoPontos,

    MIN(DtDiff) AS diasUltimaTransacao,

    SUM(CASE
            WHEN QtdePontos > 0 THEN QtdePontos ELSE 0 END) AS QtdePontosPositivoVida,
    SUM(CASE
            WHEN QtdePontos > 0 AND DtDiff <= 56 THEN QtdePontos ELSE 0 END) AS QtdePontosPositivoD56,
    SUM(CASE
            WHEN QtdePontos > 0 AND DtDiff <= 28 THEN QtdePontos ELSE 0 END) AS QtdePontosPositivoD28,
    SUM(CASE
            WHEN QtdePontos > 0 AND DtDiff <= 14 THEN QtdePontos ELSE 0 END) AS QtdePontosPositivoD14,
    SUM(CASE
            WHEN QtdePontos > 0 AND DtDiff <= 7 THEN QtdePontos ELSE 0 END) AS QtdePontosPositivoD7,

    SUM(CASE
            WHEN QtdePontos < 0 THEN QtdePontos ELSE 0 END) AS QtdePontosNegativo,
    SUM(CASE
            WHEN QtdePontos < 0 AND DtDiff <= 56 THEN QtdePontos ELSE 0 END) AS QtdePontosNegativoD56,
    SUM(CASE
            WHEN QtdePontos < 0 AND DtDiff <= 28 THEN QtdePontos ELSE 0 END) AS QtdePontosNegativoD28,
    SUM(CASE
            WHEN QtdePontos < 0 AND DtDiff <= 14 THEN QtdePontos ELSE 0 END) AS QtdePontosNegativoD14,
    SUM(CASE
            WHEN QtdePontos < 0 AND DtDiff <= 7 THEN QtdePontos ELSE 0 END) AS QtdePontosNegativoD7
FROM tb_transacoes
GROUP BY 1
)

SELECT
    t1.*,
    t2.idadeBase
FROM tb_sumario_transacoes AS t1
LEFT JOIN tb_cliente AS t2
    ON t1.IdCliente = t2.IdCliente

