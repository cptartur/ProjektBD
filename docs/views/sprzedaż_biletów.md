# Sprzedaż_biletów

## Opis działania

Wybierz z tabeli `Bilety` sumę zysku ze sprzedanych biletów, pogrupowane wedługo lat i miesięcy.

## Kod źródłowy

```sql
CREATE OR ALTER VIEW Sprzedaż_biletów
AS
SELECT YEAR(B.Data_zakupu) AS Rok, MONTH(B.Data_zakupu) AS Miesiąc, SUM(B.Cena) AS Suma_sprzedanych_biletów 
FROM Bilety AS B
INNER JOIN Punkty_sprzedaży AS P
    ON P.ID_punktu = B.ID_punktu_sprzedaży
GROUP BY YEAR(B.Data_zakupu), MONTH(B.Data_zakupu)
```

[link do kodu](../../views/Sprzedaż_biletów.sql)
