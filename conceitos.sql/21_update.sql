SELECT * FROM relatorio_diario;

UPDATE relatorio_diario
SET QtdeTransacao = 190000
WHERE DataDia >= '2025-08-25';

SELECT * FROM relatorio_diario;