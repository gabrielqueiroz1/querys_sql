--Dos clientes que começaram no primeiro dia SQL, quantos deles chegaram no 5º dia?
--No 5º dia tivemos 207 pessoas que estava presente desde o primeiro dia.

SELECT *
FROM transacoes AS t1
WHERE t1.IdCliente IN (
    SELECT 
        DISTINCT(IdCliente)
    FROM transacoes
    WHERE SUBSTR(DtCriacao, 1, 10) = '2025-08-25'
)
AND SUBSTR(t1.DtCriacao, 1, 10) = '2025-08-29';

SELECT
    COUNT(DISTINCT(IdCliente)) AS QtdeClientes
FROM transacoes AS t1
WHERE t1.IdCliente IN (
    SELECT 
        DISTINCT(IdCliente)
    FROM transacoes
    WHERE SUBSTR(DtCriacao, 1, 10) = '2025-08-25'
)
AND SUBSTR(t1.DtCriacao, 1, 10) = '2025-08-29';


SELECT 
    COUNT(DISTINCT(IdCliente))
FROM transacoes
WHERE SUBSTR(DtCriacao, 1, 10) = '2025-08-25';

SELECT 
    COUNT(DISTINCT(IdCliente))
FROM transacoes
WHERE SUBSTR(DtCriacao, 1, 10) >= '2025-08-25'
AND SUBSTR(DtCriacao, 1, 10) < '2025-08-30';

SELECT
    SUBSTR(DtCriacao, 1, 10) AS DtCriacao,
    COUNT(DISTINCT(IdCliente)) AS QtdeCliente
FROM transacoes
WHERE SUBSTR(DtCriacao, 1, 10) >= '2025-08-25'
AND SUBSTR(DtCriacao, 1, 10) < '2025-08-30'
GROUP BY 1;