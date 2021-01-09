CREATE OR ALTER TRIGGER wstawienie_Id_klienta_przez_pesel ON Mandaty
AFTER INSERT
AS
    IF (ROWCOUNT_BIG() = 0)
	RETURN;
    UPDATE Mandaty
    SET Mandaty.Id_klienta = (
		CASE WHEN EXISTS (
			SELECT ID_klienta 
			FROM Klienci 
			WHERE I.PESEL = Klienci.PESEL) 
		THEN (
			SELECT ID_klienta 
			FROM Klienci 
			WHERE I.PESEL = Klienci.PESEL) 
		ELSE NULL END)
    FROM Mandaty AS M
    INNER JOIN inserted AS I
      ON I.ID_mandatu = M.ID_mandatu
