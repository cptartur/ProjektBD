CREATE OR ALTER VIEW Pojazdy_od_producenta
AS
SELECT P.Producent, COUNT(*) AS Ilo��
FROM Pojazdy AS P
GROUP BY P.Producent