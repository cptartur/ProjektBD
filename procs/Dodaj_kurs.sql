CREATE OR ALTER PROCEDURE Dodaj_kurs
	@Nr_kursu INT,
	@Nr_linii INT,
	@ID_pojazdu INT,
	@ID_kierowcy INT,
	@Rozk³ad [Przystanek_w_rozk³adzie] READONLY
AS
	IF NOT EXISTS (
		SELECT *
		FROM Linie AS L
		WHERE L.Numer_linii = @Nr_linii
	)
	BEGIN
		RAISERROR ('Taka linia nie istnieje', 1, 1)
		RETURN;
	END

	IF EXISTS (
		SELECT *
		FROM Kursy AS K
		WHERE (K.Nr_kursu = K.Nr_kursu) AND (K.Numer_linii = @Nr_linii)
	)
	BEGIN
		RAISERROR ('Kurs o podanym numerze ju¿ istnieje', 1, 2)
		RETURN;
	END

	IF EXISTS (
		SELECT *
		FROM @Rozk³ad AS L
		CROSS JOIN @Rozk³ad AS R
		WHERE (L.Numer_przystanku < R.Numer_przystanku) AND (L.Godzina_odjazdu > R.Godzina_odjazdu)
	)
	BEGIN
		RAISERROR ('Nieprawid³owa kolejnoœæ przystanków', 1, 3)
		RETURN;
	END

	IF NOT EXISTS (
		SELECT *
		FROM Pojazdy
		WHERE ID_pojazdu = @ID_pojazdu
	)
	BEGIN
		RAISERROR ('Pojazd o podanym ID nie istnieje', 1, 4)
		RETURN;
	END

	IF NOT EXISTS (
		SELECT *
		FROM Kierowcy
		WHERE ID_kierowcy = @ID_kierowcy
	)
	BEGIN
		RAISERROR ('Kierowca o podanym ID nie istnieje', 1, 5)
		RETURN;
	END

	IF EXISTS (
		SELECT *
		FROM @Rozk³ad AS R
		LEFT JOIN Przystanki AS P
			ON P.Nazwa_przystanku = R.Nazwa_przystanku
		WHERE P.Nazwa_przystanku IS NULL
	)
	BEGIN
		RAISERROR ('Niektóre z podanych przystanków nie istniej¹', 1, 6)
		RETURN;
	END

	BEGIN TRY
		DECLARE @Pierwszy_przystanek NVARCHAR(50)
		DECLARE @Ostatni_przystanek NVARCHAR(50)
		SET @Pierwszy_przystanek = (
			SELECT TOP 1 Nazwa_przystanku
			FROM @Rozk³ad
			ORDER BY Numer_przystanku 
		)
		SET @Ostatni_przystanek = (
			SELECT TOP 1 Nazwa_przystanku
			FROM @Rozk³ad
			ORDER BY Numer_przystanku DESC
		)

		INSERT INTO Kursy
		VALUES (@Nr_kursu, @Nr_linii, @ID_pojazdu, @Pierwszy_przystanek, @Ostatni_przystanek, @ID_kierowcy)

		INSERT INTO Rozk³ady_jazdy
		SELECT @Nr_linii, R.Nazwa_przystanku, @Nr_kursu, R.Godzina_odjazdu
		FROM @Rozk³ad AS R
	END TRY
	BEGIN CATCH
		SELECT
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_STATE() AS ErrorState,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage;
	END CATCH