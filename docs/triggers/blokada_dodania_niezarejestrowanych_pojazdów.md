# Blokada_dodania_niezarejestrowanych_pojazdów

## Warunek uruchomienia

`ON Kursy AFTER INSERT`

## Opis działania

Zablokuj możliwość dodawania do kursów pojazdów, które nie mają ustawionego numeru rejestracyjnego.

## Kod źródłowy

```sql
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
    RAISERROR ('Nie można dodać niezarejestrowanego pojazdu do linii', 16, 1)
    ROLLBACK TRANSACTION
    RETURN
END;
GO
```

[link do kodu](../../triggers/Blokada_dodania_niezarejestrowanych_pojazdów.sql)
