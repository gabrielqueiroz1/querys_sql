--Qual o dia da semana MAIS ativo de cada usuário?

WITH qtd_transacao_semana_cliente AS (
    SELECT
        idCliente,
        STRFTIME('%w', SUBSTR(DtCriacao, 1, 10)) AS DiaSemana,
        CASE
            WHEN STRFTIME('%w', SUBSTR(DtCriacao, 1, 10)) = '0' THEN 'Domingo'
            WHEN STRFTIME('%w', SUBSTR(DtCriacao, 1, 10)) = '1' THEN 'Segunda-Feira'
            WHEN STRFTIME('%w', SUBSTR(DtCriacao, 1, 10)) = '2' THEN 'Terça-Feira'
            WHEN STRFTIME('%w', SUBSTR(DtCriacao, 1, 10)) = '3' THEN 'Quarta-Feira'
            WHEN STRFTIME('%w', SUBSTR(DtCriacao, 1, 10)) = '4' THEN 'Quinta-Feira'
            WHEN STRFTIME('%w', SUBSTR(DtCriacao, 1, 10)) = '5' THEN 'Sexta-Feira'
            ELSE 'Sábado'
        END AS NomeDiaSemana,
        COUNT(DISTINCT IdTransacao) AS QtdeTransacao
    FROM transacoes
    GROUP BY 1, 2
),

tb_rn AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY QtdeTransacao DESC) AS rnTransacao
    FROM qtd_transacao_semana_cliente
)

SELECT
    *
FROM tb_rn
WHERE rnTransacao = 1