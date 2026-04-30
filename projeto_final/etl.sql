WITH tb_transacoes AS (
    SELECT
        IdTransacao,
        IdCliente,
        QtdePontos,
        DATETIME(SUBSTR(DtCriacao, 1, 19)) AS DtCriacao,
        JULIANDAY('{date}') - JULIANDAY(SUBSTR(DtCriacao, 1, 10)) AS DtDiff,
        CAST(STRFTIME("%H", SUBSTR(DtCriacao, 1, 19)) AS INTEGER) AS DtHora
    FROM transacoes
    WHERE DtCriacao < '{date}'
),

tb_cliente AS (
    SELECT
        IdCliente,
        DATETIME(SUBSTR(DtCriacao, 1, 19)) AS DtCriacao,
        JULIANDAY('{date}') - JULIANDAY(SUBSTR(DtCriacao, 1, 10)) AS idadeBase
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
),

tb_transacao_produto AS (
    SELECT
        t1.*,
        t3.DescNomeProduto,
        t3.DescCategoriaProduto
    FROM tb_transacoes AS t1
    LEFT JOIN transacao_produto AS t2
        ON t1.IdTransacao = t2.IdTransacao
    LEFT JOIN produtos AS t3
        ON t2.IdProduto = t3.IdProduto
),

tb_cliente_produto AS (
    SELECT
        IdCliente,
        DescNomeProduto,
        COUNT(*) AS QtdeVida,
        COUNT(CASE WHEN DtDiff <= 56 THEN IdTransacao END) AS Qtde56,
        COUNT(CASE WHEN DtDiff <= 28 THEN IdTransacao END) AS Qtde28,
        COUNT(CASE WHEN DtDiff <= 14 THEN IdTransacao END) AS Qtde14,
        COUNT(CASE WHEN DtDiff <= 7 THEN IdTransacao END) AS Qtde7
    FROM tb_transacao_produto
    GROUP BY 1, 2
),

tb_cliente_produto_rn AS (

    SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY IdCliente ORDER BY QtdeVida DESC) AS rnVida,
        ROW_NUMBER() OVER(PARTITION BY IdCliente ORDER BY Qtde56 DESC) AS rn56,
        ROW_NUMBER() OVER(PARTITION BY IdCliente ORDER BY Qtde28 DESC) AS rn28,
        ROW_NUMBER() OVER(PARTITION BY IdCliente ORDER BY Qtde14 DESC) AS rn14,
        ROW_NUMBER() OVER(PARTITION BY IdCliente ORDER BY Qtde7 DESC) AS rn7
    FROM tb_cliente_produto
),

tb_cliente_dia AS (
    SELECT
        IdCliente,
        STRFTIME("%w", DtCriacao) AS DtDia,
        COUNT(*) AS QtdeTransacao
    FROM tb_transacoes
    WHERE DtDiff <= 28
    GROUP BY 1, 2
),

tb_cliente_dia_rn AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY QtdeTransacao DESC) AS rnDia
    FROM tb_cliente_dia
),

tb_cliente_periodo AS (
    SELECT
        idCliente,
        CASE
            WHEN DtHora BETWEEN 7 AND 12 THEN 'Manhã'
            WHEN DtHora BETWEEN 13 AND 18 THEN 'Tarde'
            WHEN DtHora BETWEEN 19 AND 23 THEN 'Noite'
            ELSE 'Madrugada'
        END AS periodoDia,
        COUNT(*) AS QtdeTransacoes
    FROM tb_transacoes
    WHERE DtDiff <= 28
    GROUP BY 1, 2
),

tb_cliente_periodo_rn AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY QtdeTransacoes DESC) AS rnPeriodo
    FROM tb_cliente_periodo
),

tb_join_idade_base AS ( 
    SELECT
        t1.*,
        t2.idadeBase,
        t3.DescNomeProduto AS produtoVida,
        t4.DescNomeProduto AS produto56,
        t5.DescNomeProduto AS produto28,
        t6.DescNomeProduto AS produto14,
        t7.DescNomeProduto AS produto7,
        COALESCE(t8.DtDia, -1) AS DtDia,
        COALESCE(t9.periodoDia, 'SEM INFORMACAO') AS periodoMaisTransacao28
    FROM tb_sumario_transacoes AS t1
    LEFT JOIN tb_cliente AS t2
        ON t1.IdCliente = t2.IdCliente
    LEFT JOIN tb_cliente_produto_rn AS t3
        ON t1.IdCliente = t3.IdCliente
        AND t3.rnVida = 1
    LEFT JOIN tb_cliente_produto_rn AS t4
        ON t1.IdCliente = t4.IdCliente
        AND t4.rn56 = 1
    LEFT JOIN tb_cliente_produto_rn AS t5
        ON t1.IdCliente = t5.IdCliente
        AND t5.rn28 = 1
    LEFT JOIN tb_cliente_produto_rn AS t6
        ON t1.IdCliente = t6.IdCliente
        AND t6.rn14 = 1
    LEFT JOIN tb_cliente_produto_rn AS t7
        ON t1.IdCliente = t7.IdCliente
        AND t7.rn7 = 1
    LEFT JOIN tb_cliente_dia_rn AS t8
        ON t1.IdCliente = t8.IdCliente
        AND t8.rnDia = 1
    LEFT JOIN tb_cliente_periodo_rn AS t9
        ON t1.IdCliente = t9.IdCliente
        AND t9.rnPeriodo = 1
)


SELECT
    '{date}' AS dtRef,
    *,
    1. * QtdeTransacoesD28 / QtdeTransacoesVida AS engajamento28Vida
FROM tb_join_idade_base