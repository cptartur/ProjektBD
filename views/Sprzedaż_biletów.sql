CREATE OR ALTER VIEW Sprzeda¿_biletów
AS
SELECT YEAR(B.Data_zakupu) AS Rok, MONTH(B.Data_zakupu) AS Miesi¹c, SUM(B.Cena) AS Suma_sprzedanych_biletów 
FROM Bilety AS B
INNER JOIN Punkty_sprzeda¿y AS P
	ON P.ID_punktu = B.ID_punktu_sprzeda¿y
GROUP BY YEAR(B.Data_zakupu), MONTH(B.Data_zakupu)