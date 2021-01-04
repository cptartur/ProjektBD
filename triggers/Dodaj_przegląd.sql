CREATE OR ALTER TRIGGER Dodaj_przegl¹d ON Pojazdy
AFTER INSERT
AS
IF (ROWCOUNT_BIG() = 0)
RETURN;
INSERT INTO Przegl¹dy
SELECT I.ID_pojazdu, I.Data_zakupu, (DATEADD(DAY, 180, I.Data_zakupu))
FROM inserted I
GO