--Qual a média de clientes entrantes na base?

WITH tb_qtde_clientes AS (
    SELECT
        SUBSTR(DtCriacao, 1, 10) AS DataDia,
        COUNT(DISTINCT IdCliente) AS QtdeCliente
    FROM clientes
    GROUP BY 1
),

tb_acumulado_cliente AS (
    SELECT
        *,
        SUM(QtdeCliente) OVER (ORDER BY DataDia) AS acmQtdeClientes
    FROM tb_qtde_clientes
)

SELECT
    ROUND(AVG(QtdeCliente), 2) AS mediaClientes
FROM tb_qtde_clientes

