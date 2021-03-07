CREATE OR ALTER PROCEDURE Dodaj_kurs
	@Nr_kursu INT,
	@Nr_linii INT,
	@ID_pojazdu INT,
	@ID_kierowcy INT,
	@Rozk³ad [Przystanek_w_rozk³adzie] READONLY
AS
	SET NOCOUNT ON
	IF NOT EXISTS (
		SELECT L.Numer_linii
		FROM Linie AS L
		WHERE L.Numer_linii = @Nr_linii
	)
	BEGIN
		RAISERROR ('Taka linia nie istnieje', 16, 1)
		RETURN;
	END

	IF EXISTS (
		SELECT K.Nr_kursu
		FROM Kursy AS K
		WHERE (K.Nr_kursu = @Nr_kursu) AND (K.Numer_linii = @Nr_linii)
	)
	BEGIN
		RAISERROR ('Kurs o podanym numerze ju¿ istnieje', 16, 2)
		RETURN;
	END

	IF EXISTS (
		SELECT *
		FROM @Rozk³ad AS L
		CROSS JOIN @Rozk³ad AS R
		WHERE (L.Numer_przystanku < R.Numer_przystanku) AND (L.Godzina_odjazdu > R.Godzina_odjazdu)
	)
	BEGIN
		RAISERROR ('Nieprawid³owa kolejnoœæ przystanków', 16, 3)
		RETURN;
	END

	IF NOT EXISTS (
		SELECT P.ID_pojazdu
		FROM Pojazdy AS P
		WHERE P.ID_pojazdu = @ID_pojazdu
	)
	BEGIN
		RAISERROR ('Pojazd o podanym ID nie istnieje', 16, 4)
		RETURN;
	END

	IF NOT EXISTS (
		SELECT K.ID_kierowcy
		FROM Kierowcy AS K
		WHERE K.ID_kierowcy = @ID_kierowcy
	)
	BEGIN
		RAISERROR ('Kierowca o podanym ID nie istnieje', 16, 5)
		RETURN;
	END

	IF EXISTS (
		SELECT R.Numer_przystanku
		FROM @Rozk³ad AS R
		LEFT JOIN Przystanki AS P
			ON P.Nazwa_przystanku = R.Nazwa_przystanku
		WHERE P.Nazwa_przystanku IS NULL
	)
	BEGIN
		RAISERROR ('Niektóre z podanych przystanków nie istniej¹', 16, 6)
		RETURN;
	END

	BEGIN
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
	END