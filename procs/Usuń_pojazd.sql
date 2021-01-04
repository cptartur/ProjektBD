CREATE OR ALTER PROCEDURE Usu�_pojazd @ID_pojazdu INT
AS
	SET NOCOUNT ON
	IF NOT EXISTS (SELECT *
		FROM Pojazdy
		WHERE ID_pojazdu = @ID_pojazdu
	)
	BEGIN
		RAISERROR('Pojazd nie istnieje', 1, 1)
		RETURN
	END

	DECLARE @Typ_pojazdu VARCHAR(50)
	SELECT @Typ_pojazdu = (
		SELECT Typ_pojazdu
		FROM Pojazdy AS P
		WHERE P.ID_pojazdu = @ID_pojazdu
	)

	DECLARE @ID_zajezdni INT
	SET @ID_zajezdni = (
		SELECT ID_zajezdni
		FROM Pojazdy AS P
		WHERE P.ID_pojazdu = @ID_pojazdu
	)

	IF @Typ_pojazdu = 'autobus'
	BEGIN
		UPDATE Zajezdnie
		SET Liczba_autobus�w = Liczba_autobus�w - 1
		WHERE ID_zajezdni = @ID_zajezdni
	END
	ELSE
	BEGIN
		UPDATE Zajezdnie
		SET Liczba_tramwaj�w = Liczba_tramwaj�w - 1
		WHERE ID_zajezdni = @ID_zajezdni
	END

	BEGIN
		DELETE FROM Pojazdy
		WHERE ID_pojazdu = @ID_pojazdu
	END