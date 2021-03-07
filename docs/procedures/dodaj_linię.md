# Dodaj_linię

## Parametry wejściowe

| Nazwa       | Typ          |
| ----------- | ------------ |
| Numer_lini  | INT          |
| Typ_pojazdu | NVARCHAR(50) |

## Opis działania

Sprawdź czy numer linii jest w poprawnym zakresie:

* [1, 99] dla tramwajów,
* [100, 999] dla autobusów.

i dodaj linię do bazy danych.

## Kod źródłowy

```sql
CREATE OR ALTER PROCEDURE Dodaj_linię 
    @Numer_lini INT, 
    @Typ_pojazdu NVARCHAR(50)
AS
    SET NOCOUNT ON
    IF EXISTS (
        SELECT L.Numer_linii
        FROM Linie AS L
        WHERE L.Numer_linii = @Numer_lini
    )
    BEGIN
        RAISERROR ('Linia o takim numerze już istnieje', 16, 1)
        RETURN;
    END

    IF (@Typ_pojazdu = 'autobus' AND (@Numer_lini BETWEEN 100 AND 999)) OR (@Typ_pojazdu = 'tramwaj' AND (@Numer_lini BETWEEN 1 AND 99))
    BEGIN
        INSERT INTO Linie
        VALUES (@Numer_lini, @Typ_pojazdu)
    END
    ELSE
        RAISERROR ('Niepoprawny numer linii', 16, 2)
        RETURN;
```

[link do kodu](../../procs/Dodaj_linię.sql)
