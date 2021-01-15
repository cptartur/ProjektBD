# Znajdź_trasę

## Parametry wejściowe

| Nazwa                 | Typ          |
| --------------------- | ------------ |
| Przystanek_początkowy | NVARCHAR(50) |
| Przystanek_docelowy   | NVARCHAR(50) |
| Godzina_odjazdu       | TIME(0)      |

## Wyjście

| Nazwa | Typ   |
| ----- | ----- |
| -     | TABLE |

## Opis działania

Znajdź trasę pomiędzy podanymi przystankami (`Przystanek_początkowy` i `Przystanek_docelowy`) i odjeżdżających najwcześniej o podanej godzinie (`Godzina_odjazdu`). Zwraca maksymalnie 5 kursów, posortowanych według godziny odjazdu.

## Kod źródłowy

```sql
CREATE OR ALTER FUNCTION Znajdź_trasę 
(
    @Przystanek_początkowy NVARCHAR(50), 
    @Przystanek_docelowy NVARCHAR(50), 
    @Godzina_odjazdu TIME(0)
)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 5 Numer_linii, Godzina_odjazu
    FROM Rozkłady_jazdy R1
    WHERE (Nazwa_przystanku LIKE @Przystanek_początkowy) AND EXISTS 
    (
        SELECT *
        FROM Rozkłady_jazdy R2
        WHERE (Nazwa_przystanku LIKE @Przystanek_docelowy) AND (R1.Numer_linii = R2.Numer_linii) AND (R2.Godzina_odjazu >= R1.Godzina_odjazu)
    ) AND Godzina_odjazu >= @Godzina_odjazdu
    ORDER BY Godzina_odjazu
);
GO
```

[link do kodu](../../functions/Znajdź_trasę.sql)
