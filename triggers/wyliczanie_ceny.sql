CREATE OR ALTER TRIGGER wyliczanie_ceny ON Bilety
AFTER INSERT
AS
    IF (ROWCOUNT_BIG() = 0)
	RETURN;
    UPDATE Bilety
    SET cena = (CASE WHEN Ulga IS NOT NULL THEN (ROUND(Cena_bazowa*CAST((1-U.Zniżka/100.0) as MONEY),2)) ELSE R.Cena_bazowa END)
    FROM Bilety AS B
    INNER JOIN Rodzaje_biletów AS R
        ON R.Rodzaj_biletu = B.Rodzaj_biletu
    INNER JOIN Klienci AS K
       ON B.ID_klienta = K.ID_klienta
    INNER JOIN Ulgi AS U
       ON U.Rodzaj_ulgi = K.Ulga
    INNER JOIN inserted AS I
      ON I.ID_biletu = B.ID_biletu
