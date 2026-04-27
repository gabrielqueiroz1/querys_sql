--Lista de transações com o produto "Resgatar Ponei"

SELECT
    trc_p.idTransacaoProduto,
    trc_p.IdTransacao,
    trc_p.IdProduto,
    prod.DescNomeProduto,
    prod.DescCategoriaProduto
FROM transacao_produto AS trc_p
LEFT JOIN produtos AS prod
ON trc_p.IdProduto = prod.IdProduto
WHERE trc_p.IdProduto = 15


SELECT *
FROM transacao_produto
WHERE IdProduto = 15