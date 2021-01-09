CREATE OR ALTER TRIGGER wyliczanie_daty_wygasniecia_biletu ON Bilety
AFTER INSERT
AS
	UPDATE Bilety
	SET Data_wygaśnięcia = DATEADD (DD, R.Okres_w_dniach, I.Data_zakupu)
	FROM Bilety AS B
	JOIN Rodzaje_biletów AS R 
	ON B.Rodzaj_biletu = R.Rodzaj_biletu
	JOIN inserted AS I 
	ON I.ID_biletu = B.ID_biletu
