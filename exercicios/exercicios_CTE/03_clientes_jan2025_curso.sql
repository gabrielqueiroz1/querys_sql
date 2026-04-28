--Dentre os clientes de janeiro/2025, quantos assistiram o curso de SQL?

--Clientes de janeiro de 2025
WITH Clientes_Jan_2025 AS (
    SELECT
        DISTINCT(IdCliente)
    FROM transacoes
    WHERE SUBSTR(DtCriacao, 1, 10) >= '2025-01-01'
    AND SUBSTR(DtCriacao, 1, 10) < '2025-02-01'
),

--Clientes de janeiro/2025 que assistiram o curso de SQL

Clientes_Curso_SQL AS (
    SELECT
        DISTINCT(IdCliente)
    FROM transacoes AS t1
    WHERE SUBSTR(DtCriacao, 1, 10) >= '2025-08-25'
    AND SUBSTR(DtCriacao, 1, 10) < '2025-08-30'
)

SELECT
    COUNT(t1.IdCliente) AS ClienteJan,
    COUNT(t2.IdCliente) AS ClienteCursoSQL
FROM Clientes_Jan_2025 AS t1
LEFT JOIN Clientes_Curso_SQL AS t2
    ON t1.IdCliente = t2.idCliente