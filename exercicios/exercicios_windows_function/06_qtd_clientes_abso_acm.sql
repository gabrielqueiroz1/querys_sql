--Quantidade de usuários cadastrados (absolutos e acumulados) ao longo do tempo:

WITH tb_qtde_clientes AS (
    SELECT
        SUBSTR(DtCriacao, 1, 10) AS DataDia,
        COUNT(IdCliente) AS QtdeCliente
    FROM clientes
    GROUP BY 1
)

SELECT
    *,
    SUM(QtdeCliente) OVER (ORDER BY DataDia) AS acmQtdeClientes
FROM tb_qtde_clientes
