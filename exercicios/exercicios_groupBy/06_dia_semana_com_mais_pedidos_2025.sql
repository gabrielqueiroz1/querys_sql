--Qual o dia da semana com mais pedidos em 2025?
--Resposta: Segunda com 18158
SELECT
    strftime('%w', substr(DtCriacao, 1, 10)) AS DiaSemanaNumero,
    CASE
        WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '0' THEN 'Domingo'
        WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '1' THEN 'Segunda'
        WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '2' THEN 'Terça'
        WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '3' THEN 'Quarta'
        WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '4' THEN 'Quinta'
        WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '5' THEN 'Sexta'
    ELSE 'Sábado'
    END AS DiaSemana,
    COUNT(IdTransacao) AS TotalPontos
FROM transacoes
WHERE substr(DtCriacao, 1, 4) = '2025'
GROUP BY strftime('%w', substr(DtCriacao, 1, 10))
ORDER BY COUNT(IdTransacao) DESC
LIMIT 1;

SELECT
    strftime('%w', substr(DtCriacao, 1, 10)) AS DiaSemanaNumero,
    CASE
        WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '0' THEN 'Domingo'
        WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '1' THEN 'Segunda'
        WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '2' THEN 'Terça'
        WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '3' THEN 'Quarta'
        WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '4' THEN 'Quinta'
        WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '5' THEN 'Sexta'
    ELSE 'Sábado'
    END AS DiaSemana,
    COUNT(IdTransacao) AS TotalPontos
FROM transacoes
WHERE DtCriacao >= '2025-01-01'
AND DtCriacao < '2026-01-01'
GROUP BY strftime('%w', substr(DtCriacao, 1, 10));

--Reduzindo a query sem o nome dos dias da semana

SELECT
    strftime('%w', substr(DtCriacao, 1, 10)) AS DiaSemanaNumero,
    COUNT(IdTransacao) AS TotalPontos
FROM transacoes
WHERE substr(DtCriacao, 1, 4) = '2025'
GROUP BY 1;
