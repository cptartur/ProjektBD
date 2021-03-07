CREATE OR ALTER FUNCTION Znajd�_tras� 
(
	@Przystanek_pocz�tkowy NVARCHAR(50), 
	@Przystanek_docelowy NVARCHAR(50), 
	@Godzina_odjazdu TIME(0)
)
RETURNS TABLE
AS
RETURN
(
	SELECT TOP 5 Numer_linii, Godzina_odjazu
	FROM Rozk�ady_jazdy R1
	WHERE (Nazwa_przystanku LIKE @Przystanek_pocz�tkowy) AND EXISTS 
	(
		SELECT *
		FROM Rozk�ady_jazdy R2
		WHERE (Nazwa_przystanku LIKE @Przystanek_docelowy) AND (R1.Numer_linii = R2.Numer_linii) AND (R2.Godzina_odjazu >= R1.Godzina_odjazu)
	) AND Godzina_odjazu >= @Godzina_odjazdu
	ORDER BY Godzina_odjazu
);
GO