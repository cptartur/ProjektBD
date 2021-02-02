# Pojazdy_od_producenta

## Opis działania

Wyświetl wszystkich producentów posiadanych pojazdów, razem z podliczeniem całkowitej liczby pojazdów.

## Kod źródłowy

```sql
CREATE OR ALTER VIEW Pojazdy_od_producenta
AS
SELECT P.Producent, COUNT(*) AS Ilość
FROM Pojazdy AS P
GROUP BY P.Producent
```

[link do kodu](../../views/Pojazdy_od_producenta.sql)
