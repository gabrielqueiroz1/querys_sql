SELECT
    t1.*,
    t2.*
FROM clientes AS t1
LEFT JOIN transacoes AS t2
ON t1.IdCliente = t2.IdCliente
WHERE t1.DtCriacao >= '2025-01-01'
ORDER BY t1.DtCriacao