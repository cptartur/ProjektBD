# Wynagrodzenia

## Opis działania

Wyświetl miesięczne wynagrodzenia dla wszystkich pracowników, poprzez pomnożenie czasu pracy
i nadgodzin przez z tabeli `Czas_pracy` prez stawki obowiązujące w danym miesiącu i roku z tabeli `Stawki_miesięczne`.

## Kod źródłowy

```sql
CREATE OR ALTER VIEW Wynagrodzenia
AS
SELECT C.ID_kierowcy, C.Rok, C.Miesiąc,
    CAST((C.Godziny_pracy * S.Stawka_podstawowa + C.Nadgodziny * S.Stawka_za_nadgodziny) AS money) AS Wynagrodzenie
FROM Czas_pracy AS C
LEFT JOIN Stawki_miesięczne AS S
    ON (C.Rok = S.Rok) AND (C.Miesiąc = S.Miesiąc)
```

[link do kodu](../../views/Wynagrodzenia.sql)
