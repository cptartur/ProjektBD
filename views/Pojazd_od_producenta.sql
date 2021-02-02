CREATE OR ALTER VIEW Pojazdy_od_producenta
AS
SELECT P.Producent, COUNT(*) AS Iloœæ
FROM Pojazdy AS P
GROUP BY P.Producent