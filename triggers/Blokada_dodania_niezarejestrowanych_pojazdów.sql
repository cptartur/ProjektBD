CREATE OR ALTER TRIGGER Blokada_dodania_niezarejestrowanych_pojazdów ON Kursy
AFTER INSERT
AS
IF (ROWCOUNT_BIG() = 0)
RETURN;
IF EXISTS (
	SELECT *
	FROM inserted AS I
	INNER JOIN Pojazdy AS P
		ON P.ID_pojazdu = I.ID_pojazdu
	WHERE P.Numer_rejestracyjny IS NULL
)
BEGIN
	RAISERROR ('Nie mo¿na dodaæ niezarejestrowanego pojazdu do linii', 1, 1)
	ROLLBACK TRANSACTION
	RETURN
END;
GO