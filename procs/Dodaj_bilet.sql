CREATE OR ALTER PROCEDURE Dodaj_bilet
	@Id_klienta INT,
	@Rodzaj_biletu nvarchar(50),
	@Data_zakupu date,
	@Id_punktu_sprzedaży INT
AS
	IF NOT EXISTS (
					SELECT * 
					FROM Punkty_sprzedaży
					WHERE ID_punktu = @Id_punktu_sprzedaży)
	BEGIN
		RAISERROR('Nie ma takiego punktu sprzedaży',16,1)
		RETURN;
	END
	ELSE IF NOT EXISTS (
					SELECT * 
					FROM Klienci
					WHERE ID_klienta = @Id_klienta)
	BEGIN
		RAISERROR('Nie ma takiego klienta',16,2)
	END
	ELSE
	BEGIN
		INSERT INTO Bilety
		VALUES(@Id_klienta,@Rodzaj_biletu,-1,@Data_zakupu,@Data_zakupu,@Id_punktu_sprzedaży)
	END