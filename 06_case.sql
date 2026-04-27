--Intervalos
--de 0 a 500          -> Ponei
--de 501 a 1000       -> Ponei preminum
--de 1001 a 5000      -> Mago Aprendiz
--de 5001 a 10000     -> Mago mestre
--+10000           -> Mago supremo


SELECT
    idCliente,
    QtdePontos,
    CASE
        WHEN QtdePontos <= 500   THEN 'Ponei'
        WHEN QtdePontos <= 1000  THEN 'Ponei Preminum'
        WHEN QtdePontos <= 5000  THEN 'Mago Aprendiz'
        WHEN QtdePontos <= 10000 THEN 'Mago Mestre'
    ELSE 'Mago Supremo'
    END AS NomeGrupo,
    CASE
        WHEN QtdePontos <= 1000 THEN 1
    ELSE 0
    END AS flPonei,
    CASE
        WHEN QtdePontos > 1000 THEN 1
    ELSE 0
    END AS flMago
FROM clientes
WHERE flPonei = 1