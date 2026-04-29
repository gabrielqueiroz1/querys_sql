DELETE FROM relatorio_diario
WHERE STRFTIME('%w', SUBSTR(DataDia, 1, 10)) = '0';

SELECT * FROM relatorio_diario;