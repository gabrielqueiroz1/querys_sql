--Quantidade de transacao em cada dia do curso de SQL

WITH tb_qtd_transacoes_dia AS (
    SELECT
        SUBSTR(DtCriacao, 1, 10)AS DiaTransacao,
        COUNT(IdTransacao) AS QtdeTransacaoDia
    FROM transacoes
    WHERE SUBSTR(DtCriacao, 1, 10) >= '2025-08-25'
    AND SUBSTR(DtCriacao, 1, 10) < '2025-08-30'
    GROUP BY 1
)

SELECT
    *,
    SUM(QtdeTransacaoDia) OVER (ORDER BY DiaTransacao) AS QtdeTrasacaoAcumulada
FROM tb_qtd_transacoes_dia