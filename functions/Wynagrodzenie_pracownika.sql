CREATE OR ALTER FUNCTION Wynagrodzenie_pracownika(@ID_pracownika INT, @Rok INT, @Miesi�c INT)
RETURNS TABLE
AS
RETURN
(
	SELECT ID_kierowcy AS ID_pracownika,  Wynagrodzenie AS Wynagrodzenie_w_miesi�cu
	FROM Wynagrodzenia
	WHERE (ID_kierowcy = @ID_pracownika) AND
		(Rok = @Rok) AND (Miesi�c = @Miesi�c)
)