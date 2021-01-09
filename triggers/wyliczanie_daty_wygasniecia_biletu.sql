CREATE OR ALTER TRIGGER wyliczanie_daty_wygasniecia_biletu ON Bilety
AFTER INSERT
AS
	UPDATE Bilety
	SET Data_wygaśnięcia = DATEADD (DD, R.Okres_w_dniach, I.Data_zakupu)
	FROM inserted as I
	JOIN Rodzaje_biletów AS R
    ON I.Rodzaj_biletu = R.Rodzaj_biletu
