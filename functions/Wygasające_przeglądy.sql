CREATE OR ALTER FUNCTION Wygasaj¹ce_przegl¹dy (@Rok INT, @Miesi¹c INT = 1, @Dzieñ INT = 1)
RETURNS @Wygasaj¹ce_przegl¹dy TABLE
(
	ID_pojazdu INT PRIMARY KEY NOT NULL,
	Data_wygaœniêcia DATE NOT NULL
)
AS
BEGIN
	DECLARE @Data DATE
	SET @Data = CAST(CAST(@Miesi¹c AS varchar) + '-' + CAST(@Dzieñ AS varchar) + '-' + CAST(@Rok AS varchar) AS date)
	
	INSERT INTO @Wygasaj¹ce_przegl¹dy(ID_pojazdu, Data_wygaœniêcia)
	SELECT P.ID_pojazdu, P.Data_wygaœniêcia
	FROM Przegl¹dy AS P
	WHERE P.Data_wygaœniêcia < @Data
	RETURN
END