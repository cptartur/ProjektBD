CREATE OR ALTER TRIGGER wyliczanie_daty_wygasniecia_biletu ON Bilety
AFTER INSERT
AS
	UPDATE Bilety
	SET Data_wygaśnięcia = (SELECT DATEADD(DD,Okres_w_dniach,Data_zakupu) from Rodzaje_biletów as R
				JOIN Bilety as B on R.Rodzaj_biletu = B.Rodzaj_biletu
				JOIN Klienci as K on B.ID_klienta = K.ID_klienta
				JOIN Ulgi as U on K.Ulga = U.Rodzaj_ulgi
				WHERE B.ID_biletu = (SELECT Max(ID_biletu) FROM Bilety) )
	WHERE ID_biletu = (SELECT Max(ID_biletu) FROM Bilety)
