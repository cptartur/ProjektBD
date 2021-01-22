# Statystyki_mandatów_kontrolerów

## Opis działania

Tebale z danymi kontrolera, wystawioną liczbą mandatów oraz łącznym zyskiem z mandatów per kontroler.

## Kod źródłowy

```sql
CREATE VIEW Statystyki_mandatów_kontrolerów AS
SELECT K.ID_kontrolera,K.Imie,K.Nazwisko, COUNT(Kwota) AS [Liczba danych mandatów], SUM(Kwota) AS [Suma zł za wszystkie mandaty dane przez kontrolera] 
FROM Kontrolerzy AS K
JOIN Mandaty AS M 
ON K.ID_kontrolera = M.ID_wystawiającego
GROUP BY K.ID_kontrolera,K.Imie,K.Nazwisko
```

[link do kodu](../../views/Statystyki_mandatów_kontrolerów.sql)
