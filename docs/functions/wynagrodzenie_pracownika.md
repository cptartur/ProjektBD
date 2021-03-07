# Wynagrodzenie_pracownika

## Parametry wejściowe

| Nazwa         | Typ |
| ------------- | --- |
| ID_pracownika | INT |
| Rok           | INT |
| Miesiąc       | INT |

## Wyjście

| Nazwa   | Typ   |
| ------- | ----- |
| Results | TABLE |

## Opis działania

Zwróć tabelę zawierającą całkowite wynagrodzenie danego pracownika w danym roku i miesiącu. Korzysta z widoku `Wynagrodzenia`.

## Kod źródłowy

```sql
CREATE OR ALTER FUNCTION Wynagrodzenie_pracownika(@ID_pracownika INT, @Rok INT, @Miesiąc INT)
RETURNS TABLE
AS
RETURN
(
    SELECT ID_kierowcy AS ID_pracownika,  Wynagrodzenie AS Wynagrodzenie_w_miesiącu
    FROM Wynagrodzenia
    WHERE (ID_kierowcy = @ID_pracownika) AND
        (Rok = @Rok) AND (Miesiąc = @Miesiąc)
)
```

[link do kodu](../../functions/Wynagrodzenie_pracownika.sql)
