--Dos clientes que começaram no primeiro dia SQL, quantos deles chegaram no 5º dia?
--No 5º dia tivemos 207 pessoas que estava presente desde o primeiro dia.

WITH Clientes_Primeiro_Dia AS (
    SELECT
        DISTINCT(IdCliente)
    FROM transacoes
    WHERE SUBSTR(DtCriacao,1 , 10) = '2025-08-25'
),

Clientes_Ultimo_Dia AS (
    SELECT
        DISTINCT(IdCliente)
    FROM transacoes
    WHERE SUBSTR(DtCriacao, 1, 10) = '2025-08-29'
),

Tb_Join AS (
    SELECT
        t1.IdCliente AS primCliente,
        t2.IdCliente AS UltCliente
    FROM Clientes_Primeiro_Dia AS t1
    LEFT JOIN Clientes_Ultimo_Dia AS t2
        ON t1.IdCliente = t2.IdCliente
)

SELECT
    COUNT(primCliente),
    COUNT(UltCliente),
    1. * COUNT(ultCliente) / COUNT(primCliente)
FROM Tb_Join;
