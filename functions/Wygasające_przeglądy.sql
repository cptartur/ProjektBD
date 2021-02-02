CREATE OR ALTER FUNCTION Wygasaj�ce_przegl�dy (@Rok INT, @Miesi�c INT = 1, @Dzie� INT = 1)
RETURNS @Wygasaj�ce_przegl�dy TABLE
(
	ID_pojazdu INT PRIMARY KEY NOT NULL,
	Data_wyga�ni�cia DATE NOT NULL
)
AS
BEGIN
	DECLARE @Data DATE
	SET @Data = CAST(CAST(@Miesi�c AS varchar) + '-' + CAST(@Dzie� AS varchar) + '-' + CAST(@Rok AS varchar) AS date)
	
	INSERT INTO @Wygasaj�ce_przegl�dy(ID_pojazdu, Data_wyga�ni�cia)
	SELECT P.ID_pojazdu, P.Data_wyga�ni�cia
	FROM Przegl�dy AS P
	WHERE P.Data_wyga�ni�cia < @Data
	RETURN
END