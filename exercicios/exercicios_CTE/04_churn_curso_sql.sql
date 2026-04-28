--Qual a curva de Retenção e Churn do curso de SQL

WITH tb_clientes_d1 AS (
    SELECT
        DISTINCT(IdCliente)
    FROM transacoes
    WHERE SUBSTR(DtCriacao, 1, 10) = '2025-08-25'
),

tb_churn_retencao AS (
    SELECT
        SUBSTR(t2.DtCriacao, 1, 10) AS DtDia,
        COUNT(DISTINCT(t1.IdCliente)) AS QtdeCliente,
        ROUND(100 * (1. * COUNT(DISTINCT(t1.IdCliente)) / (SELECT COUNT(*) FROM tb_clientes_d1)), 1) AS pctRetencao,
        ROUND(100 * (1 - 1. * COUNT(DISTINCT(t1.IdCliente)) / (SELECT COUNT(*) FROM tb_clientes_d1)), 1) AS pctChurn
    FROM tb_clientes_d1 AS t1
    LEFT JOIN transacoes AS t2
        ON t1.IdCliente = t2.IdCliente
    WHERE SUBSTR(t2.DtCriacao, 1, 10) >= '2025-08-25'
    AND SUBSTR(t2.DtCriacao, 1, 10) < '2025-08-30'
    GROUP BY 1
)

SELECT * FROM tb_churn_retencao