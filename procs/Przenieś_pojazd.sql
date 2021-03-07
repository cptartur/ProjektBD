CREATE OR ALTER PROCEDURE Przenie�_pojazd
	@ID_pojazdu INT,
	@ID_zajezdni_pocz�tkowej INT,
	@ID_zajezdni_docelowej INT
AS
	IF NOT EXISTS (
		SELECT P.ID_pojazdu
		FROM Pojazdy AS P
		WHERE (P.ID_pojazdu = @ID_pojazdu) AND (P.ID_zajezdni = @ID_zajezdni_pocz�tkowej)
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
		RAISERROR ('Zajezdnia pocz�tkowa nie istnieje', 16, 2)
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

	IF @ID_zajezdni_docelowej = @ID_zajezdni_pocz�tkowej
	BEGIN
		RAISERROR('Zajednia pocz�tkowa nie mo�e by� taka sama jak docelowa', 16, 5)
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
		DECLARE @Pojemno��_autobus�w INT
		SET @Pojemno��_autobus�w = (
			SELECT (Z.Pojemno��_autobus�w - Z.Liczba_autobus�w)
			FROM Zajezdnie AS Z
			WHERE Z.ID_zajezdni = @ID_zajezdni_docelowej
		)

		IF @Pojemno��_autobus�w <= 0
		BEGIN
			RAISERROR ('Zajezdnia docelowa jest pe�na', 16, 6)
			RETURN
		END

		UPDATE Zajezdnie
		SET Liczba_autobus�w = 
		(
			CASE
				WHEN ID_zajezdni = @ID_zajezdni_pocz�tkowej THEN (Liczba_autobus�w - 1)
				WHEN ID_zajezdni = @ID_zajezdni_docelowej THEN (Liczba_autobus�w + 1)
				ELSE Liczba_autobus�w
			END
		)
		UPDATE Pojazdy
		SET ID_zajezdni = @ID_zajezdni_docelowej
		WHERE ID_pojazdu = @ID_pojazdu
	END
	ELSE
	BEGIN
		DECLARE @Pojemno��_tramwaj�w INT
		SET @Pojemno��_tramwaj�w = (
			SELECT (Z.Pojemno��_tramwaj�w - Z.Pojemno��_tramwaj�w)
			FROM Zajezdnie AS Z
			WHERE Z.ID_zajezdni = @ID_zajezdni_docelowej
		)

		IF @Pojemno��_tramwaj�w <= 0
		BEGIN
			RAISERROR ('Zajezdnia docelowa jest pe�na', 16, 6)
			RETURN
		END
		
		UPDATE Zajezdnie
		SET Liczba_tramwaj�w = 
		(
			CASE
				WHEN ID_zajezdni = @ID_zajezdni_pocz�tkowej THEN (Liczba_tramwaj�w - 1)
				WHEN ID_zajezdni = @ID_zajezdni_docelowej THEN (Liczba_tramwaj�w + 1)
				ELSE Liczba_autobus�w
			END
		)
		UPDATE Pojazdy
		SET ID_zajezdni = @ID_zajezdni_docelowej
		WHERE ID_pojazdu = @ID_pojazdu
	END