--Os clientes mais antigos tem mais frequência de transação?
--Diferentes maneiras de pensar na solução esta descrito abaixo:

SELECT
    t1.IdCliente,
    MAX(JULIANDAY(SUBSTR(t2.DtCriacao, 1, 10))) - JULIANDAY(SUBSTR(t1.DtCriacao, 1, 10)) AS TempoBase,
    COUNT(t2.IdTransacao) AS QtdeTransacao
FROM clientes AS t1
LEFT JOIN transacoes AS t2
    ON t1.IdCliente = t2.IdCliente
GROUP BY t1.IdCliente
ORDER BY 1, 2 DESC;

SELECT
    t1.IdCliente,
    JULIANDAY('2025-09-01') - JULIANDAY(SUBSTR(t1.DtCriacao, 1, 10)) AS TempoBase,
    COUNT(t2.IdTransacao) AS QtdeTransacao
FROM clientes AS t1
LEFT JOIN transacoes AS t2
    ON t1.IdCliente = t2.IdCliente
GROUP BY 1, 2;


WITH Cliente_Transacao_Antigo AS (
    SELECT
        IdCliente,
        IdTransacao,
        DtCriacao
    FROM transacoes
    WHERE SUBSTR(DtCriacao, 1, 10) >= '2024-01-01'
    AND SUBSTR(DtCriacao, 1, 10) < '2024-10-01'
)

SELECT
    t2.IdCliente,
    MAX(JULIANDAY(SUBSTR(t1.DtCriacao, 1, 10))) - JULIANDAY(SUBSTR(t2.DtCriacao, 1, 10)) AS TempoTransacao,
    COUNT(t1.IdTransacao) AS QtdeTransacao
FROM Cliente_Transacao_Antigo AS t1
LEFT JOIN clientes AS t2
    ON t1.IdCliente = t2.IdCliente
GROUP BY 1
ORDER BY 1, 2 DESC;

WITH Cliente_Transacao_Recente AS (
    SELECT
        IdCliente,
        IdTransacao,
        DtCriacao
    FROM transacoes
    WHERE SUBSTR(DtCriacao, 1, 10) >= '2025-01-01'
    AND SUBSTR(DtCriacao, 1, 10) < '2026-01-01'
)

SELECT
    t2.IdCliente,
    MAX(JULIANDAY(SUBSTR(t1.DtCriacao, 1, 10))) - JULIANDAY(SUBSTR(t2.DtCriacao, 1, 10)) AS TempoTransacao,
    COUNT(t1.IdTransacao) AS QtdeTransacao
FROM Cliente_Transacao_Recente AS t1
LEFT JOIN clientes AS t2
    ON t1.IdCliente = t2.IdCliente
GROUP BY 1
ORDER BY 1, 2 DESC;