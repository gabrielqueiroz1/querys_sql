--Quantidade de transacao em cada dia dos clientes do curso de SQL

WITH tb_qtd_transacoes_cliente AS(
    SELECT
        IdCliente,
        SUBSTR(DtCriacao, 1, 10) AS DiaTransacao,
        COUNT(IdTransacao) AS QtdeTransacaoCliente
    FROM transacoes
    WHERE SUBSTR(DtCriacao, 1, 10) >= '2025-08-25'
    AND SUBSTR(DtCriacao, 1, 10) < '2025-08-30'
    GROUP BY 1, 2
),

tb_lag AS (

    SELECT
        *,
        SUM(QtdeTransacaoCliente) OVER(PARTITION BY IdCliente ORDER BY DiaTransacao) AS QtdeTransacaoClienteAcum,
        LAG(QtdeTransacaoCliente) OVER(PARTITION BY IdCliente ORDER BY DiaTransacao) AS LagTransacao
    FROM tb_qtd_transacoes_cliente
)

SELECT * FROM tb_lag