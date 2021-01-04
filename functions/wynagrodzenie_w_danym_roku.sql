CREATE OR ALTER FUNCTION Wynagrodzenie_w_danym_roku (@rok INT)
RETURNS TABLE
AS
RETURN
(
	SELECT SUM(W.Pensja) AS Wynagrodzenie
	FROM Wynagrodzenia W
	WHERE W.Rok = @rok
);
GO