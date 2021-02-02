# Wygasające_przeglądy

## Parametry wejściowe

| Nazwa   | Typ |
| ------- | --- |
| Rok     | INT |
| Miesiąc | INT |
| Dzień   | INT |

## Wyjście

| Nazwa                | Typ   |
| -------------------- | ----- |
| Wygasające_przeglądy | TABLE |

## Opis działania

Zwróć tabelę zawierającą wszystkie pojazdy, których przeglądy wygasną przed datą podaną w parametrach wejściowych.

## Kod źródłowy

```sql
CREATE OR ALTER FUNCTION Wygasające_przeglądy (@Rok INT, @Miesiąc INT = 1, @Dzień INT = 1)
RETURNS @Wygasające_przeglądy TABLE
(
    ID_pojazdu INT PRIMARY KEY NOT NULL,
    Data_wygaśnięcia DATE NOT NULL
)
AS
BEGIN
    DECLARE @Data DATE
    SET @Data = CAST(CAST(@Miesiąc AS varchar) + '-' + CAST(@Dzień AS varchar) + '-' + CAST(@Rok AS varchar) AS date)
    
    INSERT INTO @Wygasające_przeglądy(ID_pojazdu, Data_wygaśnięcia)
    SELECT P.ID_pojazdu, P.Data_wygaśnięcia
    FROM Przeglądy AS P
    WHERE P.Data_wygaśnięcia < @Data
    RETURN
END
```

[link do kodu](../../functions/Wygasające_przeglądy.sql)
