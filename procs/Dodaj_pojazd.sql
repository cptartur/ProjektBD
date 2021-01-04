CREATE OR ALTER PROCEDURE Dodaj_pojazd
	@ID_pojazdu INT,
	@Typ_pojazdu NVARCHAR(50),
	@Producent NVARCHAR(50),
	@Model NVARCHAR(50),
	@Data_zakupu DATE,
	@Numer_rejestracyjny NCHAR(10) = NULL,
	@ID_zajezdni INT = NULL
AS
	SET NOCOUNT ON
	IF @ID_zajezdni IS NOT NULL AND EXISTS (
			SELECT *
			FROM Zajezdnie AS Z
			WHERE Z.ID_zajezdni = @ID_zajezdni
		)
	BEGIN
		DECLARE @miejsce int = 0;
		IF @Typ_pojazdu = 'autobus'
			SELECT @miejsce  = (
				SELECT (Pojemno��_autobus�w - Liczba_autobus�w) AS Miejsce
				FROM Zajezdnie AS Z
				WHERE Z.ID_zajezdni = @ID_zajezdni
			)
		ELSE
			SELECT @miejsce = (
				SELECT (Pojemno��_tramwaj�w - Liczba_tramwaj�w) AS Miejsce
				FROM Zajezdnie AS Z
				WHERE Z.ID_zajezdni = @ID_zajezdni
			)
		IF @miejsce > 0
			BEGIN
				INSERT INTO Pojazdy
				VALUES
				(@ID_pojazdu, @Typ_pojazdu, @Producent, @Model, @Data_zakupu, @Numer_rejestracyjny, @ID_zajezdni);

				IF @Typ_pojazdu = 'autobus'
				BEGIN
					UPDATE Zajezdnie
					SET Liczba_autobus�w = Liczba_autobus�w + 1
					WHERE ID_zajezdni = @ID_zajezdni
				END
				ELSE
				BEGIN
					UPDATE Zajezdnie
					SET Liczba_tramwaj�w = Liczba_tramwaj�w + 1
					WHERE ID_zajezdni = @ID_zajezdni
				END
			END
		ELSE
			RAISERROR ('Wybrana zajezdnia jest pe�na', 1, 1)
			RETURN
	END
	ELSE
	BEGIN
		INSERT INTO Pojazdy
		VALUES
		(@ID_pojazdu, @Typ_pojazdu, @Producent, @Model, @Data_zakupu, @Numer_rejestracyjny, NULL);
	END
