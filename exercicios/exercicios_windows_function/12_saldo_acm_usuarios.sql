--Saldo de pontos acumulados de cada usuário

WITH tb_qtd_pontos_clientes AS (
    SELECT
        SUBSTR(DtCriacao, 1, 10) AS DtDia,
        Idcliente,
        SUM(QtdePontos) AS totalPontos,
        SUM(CASE
                WHEN QtdePontos > 0 THEN QtdePontos
            END) AS pontosPositivos
    FROM transacoes
    GROUP BY 2, 1
)

SELECT
    *,
    SUM(totalPontos) OVER (PARTITION BY IdCliente ORDER BY DtDia, IdCliente) AS acmPontos,
    SUM(pontosPositivos) OVER (PARTITION BY IdCliente ORDER BY DtDia, IdCliente) AS totalPontosPositivos
FROM tb_qtd_pontos_clientes