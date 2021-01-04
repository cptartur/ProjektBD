CREATE OR ALTER FUNCTION Sprzeda¿_w_punkcie (@ID_punktu INT)
RETURNS TABLE
AS
RETURN
(
	SELECT YEAR(B.Data_zakupu) AS Rok, MONTH(B.Data_zakupu) AS Miesi¹c, SUM(B.Cena) AS Zysk
	FROM Bilety AS B
	GROUP BY YEAR(B.Data_zakupu), MONTH(B.Data_zakupu)
);
GO