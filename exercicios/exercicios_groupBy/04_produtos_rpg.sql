SELECT
    COUNT(*)
FROM produtos
WHERE DescCategoriaProduto = 'rpg';

SELECT
    DescCategoriaProduto,
    COUNT(*) AS QtdeProdutos
FROM produtos
GROUP BY DescCategoriaProduto
ORDER BY COUNT(*) DESC;
