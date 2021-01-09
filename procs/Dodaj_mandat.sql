CREATE OR ALTER PROCEDURE Dodaj_mandat
	@Imię nvarchar(50),
	@Nazwisko nvarchar(50),
	@PESEL BIGINT,
	@Adres nvarchar(150),
	@Kwota MONEY,
	@Id_kontrolera INT,
	@Id_klienta INT
AS
	IF NOT EXISTS (
					SELECT * 
					FROM Kontrolerzy
					WHERE ID_kontrolera = @Id_kontrolera)
	   AND @Id_kontrolera IS NOT NULL
	BEGIN
		RAISERROR('Próbujesz dać mandat na nieistniejącego kontrolera',16,1)
		RETURN;
	END
	ELSE IF NOT EXISTS (
					SELECT * 
					FROM Klienci
					WHERE ID_klienta = @Id_klienta)
		AND @Id_klienta IS NOT NULL
	BEGIN
		RAISERROR('Próbujesz wystawić mandat na nieistniejącego klienta',16,2)
	END
	ELSE
	BEGIN
		INSERT INTO Mandaty
		VALUES(@Imię,@Nazwisko,@PESEL,@Adres,@Kwota,@Id_kontrolera,@Id_klienta)
	END
