--Lista de pedidos realizados no fim de semana

SELECT
    DtCriacao,
    datetime(substr(DtCriacao, 1, 19)) AS new_date_hour,
    date(substr(DtCriacao, 1, 19)) AS new_date,
    strftime('%w', datetime(substr(DtCriacao, 1, 10))) AS day_week
FROM transacoes
WHERE day_week = '0'
OR day_week = '6'


SELECT
    DtCriacao,
    datetime(substr(DtCriacao, 1, 19)) AS new_date_hour,
    date(substr(DtCriacao, 1, 19)) AS new_date,
    strftime('%w', datetime(substr(DtCriacao, 1, 10))) AS day_week
FROM transacoes
WHERE day_week IN('0', '6')

