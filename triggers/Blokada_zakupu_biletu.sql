CREATE OR ALTER TRIGGER Blokada_zakupu_biletu ON Bilety
AFTER INSERT
AS
IF (ROWCOUNT_BIG() = 0)
RETURN;
IF EXISTS(
	SELECT *
	FROM Mandaty AS M
	INNER JOIN inserted AS I
		ON I.ID_klienta = M.ID_klienta
)
BEGIN
	RAISERROR ('Dodano bilet dla osoby z niezap³aconymi mandatami', 1, 1);
	ROLLBACK TRANSACTION;
	RETURN
END;
GO