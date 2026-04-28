-- Qual o dia com maior engajamento de cada aluno e que iniciou o curso no dia 01?

WITH tb_clientes_d1 AS (
    SELECT
        DISTINCT(IdCliente)
    FROM transacoes
    WHERE SUBSTR(DtCriacao, 1, 10) = '2025-08-25'
),

tb_engajamento_cliente_dia AS (

    SELECT
        DISTINCT(t1.IdCliente),
        COUNT(t2.IdCliente) AS QtdeInteracoes,
        SUBSTR(t2.DtCriacao, 1, 10) AS DataEngajamento
    FROM tb_clientes_d1 AS t1
    LEFT JOIN transacoes AS t2
        ON t1.IdCliente = t2.IdCliente
        AND SUBSTR(DtCriacao, 1, 10) >= '2025-08-25'
        AND SUBSTR(DtCriacao, 1, 10) < '2025-08-30'
    GROUP BY 1, 3
    ORDER BY 1, 3 DESC

),

tb_row_number AS (

    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY IdCliente
            ORDER BY QtdeInteracoes DESC, DataEngajamento) AS RowNumber
    FROM tb_engajamento_cliente_dia
)

SELECT
    *
FROM tb_row_number
WHERE RowNumber = 1