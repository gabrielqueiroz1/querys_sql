--De quanto em quanto tempo as pessoas voltam a assistir o tmw?

WITH tb_cliente_dia AS (
    SELECT
        DISTINCT(IdCliente),
        SUBSTR(DtCriacao, 1, 10) AS DataDia
    FROM transacoes
    WHERE SUBSTR(DtCriacao, 1, 4) = '2025'
    ORDER BY 1, 2
),

tb_lag AS (

    SELECT
        IdCliente,
        DataDia,
        LAG(DataDia) OVER(PARTITION BY IdCliente ORDER BY DataDia) AS LagRecorrencia
    FROM tb_cliente_dia
),

tb_diff_data AS (
    SELECT
        *,
        JULIANDAY(DataDia) - JULIANDAY(LagRecorrencia) AS DataDiff
    FROM tb_lag
),

avg_cliente AS (

    SELECT
        IdCliente,
        AVG(DataDiff) AS AvgDia
    FROM tb_diff_data
    GROUP BY 1
)

SELECT
    AVG(avgDia)
FROM avg_cliente
