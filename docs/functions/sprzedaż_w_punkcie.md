# Sprzedaż_w_punkcie

## Parametry wejściowe

| Nazwa     | Typ |
| --------- | --- |
| ID_punktu | INT |

## Wyjście

| Nazwa              | Typ   |
| ------------------ | ----- |
| Sprzedaż_w_punkcie | TABLE |

## Opis działania

Wybierz z tabeli `Bilety` sumę zysku ze sprzedanych biletów sprzedanych w podanym punkcie (`ID_punktu`), pogrupowane wedługo lat i miesięcy.

## Kod źródłowy

```sql
CREATE OR ALTER FUNCTION Sprzedaż_w_punkcie (@ID_punktu INT)
RETURNS TABLE
AS
RETURN
(
    SELECT YEAR(B.Data_zakupu) AS Rok, MONTH(B.Data_zakupu) AS Miesiąc, SUM(B.Cena) AS Zysk
    FROM Bilety AS B
    GROUP BY YEAR(B.Data_zakupu), MONTH(B.Data_zakupu)
);
```

[link do kodu](../../functions/Sprzedaż_w_punkcie.sql)
