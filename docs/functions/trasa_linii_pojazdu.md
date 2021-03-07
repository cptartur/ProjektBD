# Trasa_linii_pojazdu

## Parametry wejściowe

| Nazwa     | Typ |
| --------- | --- |
| Numer_linii | INT |

## Wyjście

| Nazwa              | Typ   |
| ------------------ | ----- |
| Trasa_linii_pojazdu | TABLE |

## Opis działania

Wypisz wszystkie kursy pojazdu o podanym numerze linii, przystanki przez które przejeżdża oraz godziny odjazdu.

## Kod źródłowy

```sql
GO
CREATE FUNCTION Trasa_linii_pojazdu (@Num_l AS INT)
RETURNS TABLE
AS
RETURN
	SELECT L.Numer_linii,Typ_pojazdu,Nr_kursu,Nazwa_przystanku, Godzina_odjazu FROM Linie as L
	LEFT JOIN Rozkłady_jazdy as R on L.Numer_linii = R.Numer_linii
	WHERE L.Numer_linii = @Num_l
GO
```

[link do kodu](../../functions/Trasa_linii_pojazdu.sql)
