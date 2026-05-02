--Qual a quantidade de transações acumuladas ao longo do tempo em dias?

DROP TABLE IF EXISTS relatorio_diario;

CREATE TABLE IF NOT EXISTS relatorio_diario AS 

WITH tb_qtd_transacoes AS (
    SELECT
        SUBSTR(DtCriacao, 1, 10) AS DataDia,
        COUNT(IdTransacao) AS QtdeTransacao
    FROM transacoes
    GROUP BY 1
    ORDER BY 1
),

tb_acumulado_transacoes AS (
    SELECT
        *,
        SUM(QtdeTransacao) OVER(ORDER BY DataDia) AS acumQtdeTransacao
    FROM tb_qtd_transacoes
)

SELECT * FROM tb_acumulado_transacoes;

SELECT * FROM relatorio_diario;