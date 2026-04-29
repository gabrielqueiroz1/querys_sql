--Quando que chegamos em 3 mil clientes?

WITH tb_qtde_clientes AS (
    SELECT
        SUBSTR(DtCriacao, 1, 10) AS DataDia,
        COUNT(IdCliente) AS QtdeCliente
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
    *
FROM tb_acumulado_cliente
WHERE acmQtdeClientes >= 3000
ORDER BY 3 ASC
LIMIT 1