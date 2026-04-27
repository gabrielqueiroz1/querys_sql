--Listar todas as transações adicionando uma nova coluna
--sinalizando "alto", "médio" e "baixo" para o valor dos pontos
--[<10;<500;>=500]

SELECT 
    IdTransacao,
    QtdePontos,
    CASE
        WHEN QtdePontos < 10   THEN 'baixo'
        WHEN QtdePontos < 500  THEN 'medio'
        WHEN QtdePontos >= 500 THEN 'alto'
    END AS categoria_valores
FROM transacoes
ORDER BY QtdePontos DESC
