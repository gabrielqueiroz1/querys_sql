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
            WHEN DtDiff <= 7 THEN IdTransacao END) AS QtdeTransacoesD07,
    MIN(DtDiff) AS diasUltimaTransacao
FROM tb_transacoes
GROUP BY 1
)

SELECT
    t1.*,
    t2.idadeBase
FROM tb_sumario_transacoes AS t1
LEFT JOIN tb_cliente AS t2
    ON t1.IdCliente = t2.IdCliente

