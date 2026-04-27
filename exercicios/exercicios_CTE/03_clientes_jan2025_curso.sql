--Dentre os clientes de janeiro/2025, quantos assistiram o curso de SQL?

--Clientes de janeiro de 2025
WITH Clientes_Jan_2025 AS (
    SELECT
        DISTINCT(IdCliente)
    FROM transacoes
    WHERE SUBSTR(DtCriacao, 1, 10) >= '2025-01-01'
    AND SUBSTR(DtCriacao, 1, 10) < '2025-02-01'
),

--Clientes que assistiram o curso de SQL
Clientes_Curso_SQL AS (
    SELECT
        DISTINCT(IdCliente)
    FROM transacoes
    WHERE SUBSTR(DtCriacao, 1, 10) >= '2025-08-25'
    AND SUBSTR(DtCriacao, 1, 10) < '2025-08-30'
),

Tb_Join AS (
    SELECT
        t2.IdCliente
    FROM Clientes_Jan_2025 AS t1
    LEFT JOIN Clientes_Curso_SQL AS t2
        ON t1.IdCliente = t2.IdCliente
    WHERE t2.IdCliente IS NOT NULL
)

SELECT
    COUNT(*) AS QtdeCliente
FROM Tb_Join
