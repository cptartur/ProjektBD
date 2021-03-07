CREATE OR ALTER PROCEDURE Przenieœ_pojazd
	@ID_pojazdu INT,
	@ID_zajezdni_pocz¹tkowej INT,
	@ID_zajezdni_docelowej INT
AS
	IF NOT EXISTS (
		SELECT P.ID_pojazdu
		FROM Pojazdy AS P
		WHERE (P.ID_pojazdu = @ID_pojazdu) AND (P.ID_zajezdni = @ID_zajezdni_pocz¹tkowej)
	)
	BEGIN
		RAISERROR('Podanego pojazdu nie ma w zajezdni', 16, 1)
		RETURN
	END

	IF NOT EXISTS (
		SELECT Z.ID_zajezdni
		FROM Zajezdnie AS Z
		WHERE @ID_zajezdni_docelowej = Z.ID_zajezdni
	)
	BEGIN
		RAISERROR ('Zajezdnia pocz¹tkowa nie istnieje', 16, 2)
		RETURN
	END

	IF NOT EXISTS (
		SELECT Z.ID_zajezdni
		FROM Zajezdnie AS Z
		WHERE @ID_zajezdni_docelowej = Z.ID_zajezdni
	)
	BEGIN
		RAISERROR ('Zajezdnia docelowa nie istnieje', 16, 3)
		RETURN
	END

	IF NOT EXISTS (
		SELECT P.ID_pojazdu
		FROM Pojazdy AS P
		WHERE @ID_pojazdu = P.ID_pojazdu
	)
	BEGIN
		RAISERROR ('Pojazd nie istnieje', 16, 4)
		RETURN
	END

	IF @ID_zajezdni_docelowej = @ID_zajezdni_pocz¹tkowej
	BEGIN
		RAISERROR('Zajednia pocz¹tkowa nie mo¿e byæ taka sama jak docelowa', 16, 5)
		RETURN
	END

	DECLARE @Typ_pojazdu VARCHAR(50)
	SET @Typ_pojazdu = (
		SELECT Typ_pojazdu
		FROM Pojazdy AS P
		WHERE @ID_pojazdu = P.ID_pojazdu
	)

	IF @Typ_pojazdu = 'autobus'
	BEGIN
		DECLARE @Pojemnoœæ_autobusów INT
		SET @Pojemnoœæ_autobusów = (
			SELECT (Z.Pojemnoœæ_autobusów - Z.Liczba_autobusów)
			FROM Zajezdnie AS Z
			WHERE Z.ID_zajezdni = @ID_zajezdni_docelowej
		)

		IF @Pojemnoœæ_autobusów <= 0
		BEGIN
			RAISERROR ('Zajezdnia docelowa jest pe³na', 16, 6)
			RETURN
		END

		UPDATE Zajezdnie
		SET Liczba_autobusów = 
		(
			CASE
				WHEN ID_zajezdni = @ID_zajezdni_pocz¹tkowej THEN (Liczba_autobusów - 1)
				WHEN ID_zajezdni = @ID_zajezdni_docelowej THEN (Liczba_autobusów + 1)
				ELSE Liczba_autobusów
			END
		)
		UPDATE Pojazdy
		SET ID_zajezdni = @ID_zajezdni_docelowej
		WHERE ID_pojazdu = @ID_pojazdu
	END
	ELSE
	BEGIN
		DECLARE @Pojemnoœæ_tramwajów INT
		SET @Pojemnoœæ_tramwajów = (
			SELECT (Z.Pojemnoœæ_tramwajów - Z.Pojemnoœæ_tramwajów)
			FROM Zajezdnie AS Z
			WHERE Z.ID_zajezdni = @ID_zajezdni_docelowej
		)

		IF @Pojemnoœæ_tramwajów <= 0
		BEGIN
			RAISERROR ('Zajezdnia docelowa jest pe³na', 16, 6)
			RETURN
		END
		
		UPDATE Zajezdnie
		SET Liczba_tramwajów = 
		(
			CASE
				WHEN ID_zajezdni = @ID_zajezdni_pocz¹tkowej THEN (Liczba_tramwajów - 1)
				WHEN ID_zajezdni = @ID_zajezdni_docelowej THEN (Liczba_tramwajów + 1)
				ELSE Liczba_autobusów
			END
		)
		UPDATE Pojazdy
		SET ID_zajezdni = @ID_zajezdni_docelowej
		WHERE ID_pojazdu = @ID_pojazdu
	END