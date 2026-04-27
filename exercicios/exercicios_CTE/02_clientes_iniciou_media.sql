-- Quem iniciou o curso no primeiro dia, em média assistiu quantas aulas?


--Quem participou do primeiro dia das aulas
WITH Clientes_Primeiro_Dia AS (
    SELECT
        DISTINCT(IdCliente)
    FROM transacoes
    WHERE SUBSTR(DtCriacao, 1, 10) = '2025-08-25'
),

--Quem participou em todos os dias do curso
Clientes_Dias_Assistido AS (
    SELECT
        DISTINCT(IdCliente),
        SUBSTR(DtCriacao, 1, 10) AS presenteDia
    FROM transacoes
    WHERE SUBSTR(DtCriacao, 1, 10) >= '2025-08-25'
    AND SUBSTR(DtCriacao, 1, 10) < '2025-08-30'
),

--Quem participou do primeiro dia e continou indo as outras aulas
tb_cliente_dias AS (
    SELECT
        t1.IdCliente,
        COUNT(DISTINCT(t2.presenteDia)) AS Qtdedias
    FROM Clientes_Primeiro_Dia AS t1
    LEFT JOIN Clientes_Dias_Assistido AS t2
        ON t1.IdCliente = t2.IdCliente
    GROUP BY t1.IdCliente
)

--Cálculo da média da frequência de presença
SELECT * FROM tb_cliente_dias
