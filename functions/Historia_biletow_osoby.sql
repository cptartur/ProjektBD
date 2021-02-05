CREATE OR ALTER FUNCTION Historia_biletow_osoby (@klient AS INT)
RETURNS TABLE
AS
RETURN
	SELECT ID_biletu,Rodzaj_biletu,Cena,Data_zakupu,Data_wygaśnięcia,ID_punktu_sprzedaży,
	K.ID_klienta,Imię,Nazwisko,PESEL,Ulga FROM Bilety as B
	JOIN Klienci as K on B.ID_klienta = K.ID_klienta
	WHERE K.ID_klienta = @klient
GO
