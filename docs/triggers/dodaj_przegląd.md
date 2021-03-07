# Dodaj_przegląd

## Warunek uruchomienia

`ON Pojazdy AFTER INSERT`

## Opis działania

Po dodaniu wierszy nowych pojazdów do tabeli `Pojazdy`, wstaw do tabeli `Przeglądy` planowaną datę przeglądu pojazdu.

## Kod źródłowy

```sql
CREATE OR ALTER TRIGGER Dodaj_przegląd ON Pojazdy
AFTER INSERT
AS
IF (ROWCOUNT_BIG() = 0)
RETURN;
INSERT INTO Przeglądy
SELECT I.ID_pojazdu, I.Data_zakupu, (DATEADD(DAY, 180, I.Data_zakupu))
FROM inserted I
GO
```

[link do kodu](../../triggers/Dodaj_przegląd.sql)
