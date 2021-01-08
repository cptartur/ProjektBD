CREATE OR ALTER TRIGGER wyliczanie_ceny ON Bilety
AFTER INSERT
AS
	UPDATE Bilety
	SET Cena = (SELECT ROUND(Cena_bazowa*CAST((1-U.Zniżka/100.0) as MONEY),2) from Rodzaje_biletów as R
				JOIN Bilety as B on R.Rodzaj_biletu = B.Rodzaj_biletu
				JOIN Klienci as K on B.ID_klienta = K.ID_klienta
				JOIN Ulgi as U on K.Ulga = U.Rodzaj_ulgi
				WHERE B.ID_biletu = (SELECT Max(ID_biletu) FROM Bilety) )
	WHERE ID_biletu = (SELECT Max(ID_biletu) FROM Bilety)
