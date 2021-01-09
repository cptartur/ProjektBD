CREATE OR ALTER PROCEDURE Dodaj_bilet
	@Id_klienta INT,
	@Rodzaj_biletu nvarchar(50),
	@Data_zakupu date,
	@Id_punktu_sprzedaży INT
AS
	INSERT INTO Bilety
	VALUES(@Id_klienta,@Rodzaj_biletu,-2,@Data_zakupu,@Data_zakupu,@Id_punktu_sprzedaży)
