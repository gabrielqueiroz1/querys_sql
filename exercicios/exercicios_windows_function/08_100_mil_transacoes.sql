--Quando tivemos 100 mil transações?

WITH tb_qtd_transacao AS (
    SELECT
        SUBSTR(DtCriacao, 1, 10) AS DtDia,
        COUNT(IdTransacao) AS QtdeTransacoes
    FROM transacoes
    GROUP BY 1
),

tb_acumulado_transcoes AS (
    SELECT
        *,
        SUM(QtdeTransacoes) OVER (ORDER BY DtDia) AS acmTransacoes
    FROM tb_qtd_transacao
)

SELECT
    *
FROM tb_acumulado_transcoes
WHERE acmTransacoes >= 100000
ORDER BY 1
LIMIT 1