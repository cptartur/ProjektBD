# # Rozklad_jazdy_kierowcy

## Parametry wejściowe

| Nazwa     | Typ |
| --------- | --- |
| Identyfikator kierowcy | INT |

## Wyjście

| Nazwa              | Typ   |
| ------------------ | ----- |
| Rozklad_jazdy_kierowcy | TABLE |

## Opis działania

Wypisz wszystkie kursy kierowcy o podanym id. Dostajemy pełne informacje o kierowcy, przystanek początkowy, końcowy kursu oraz przystanki wraz z godzinami odjazdu.

## Kod źródłowy

```sql
GO
CREATE FUNCTION Rozklad_jazdy_kierowcy (@Id_k AS INT)
RETURNS TABLE
AS
RETURN
	SELECT K.ID_kierowcy,K.Imię,K.Nazwisko,K.Data_urodzenia,K.PESEL,Ku.Pierwszy_przystanek,Ku.Ostatni_przystanek,
	R.* FROM Kierowcy as K
	LEFT JOIN Kursy as Ku on K.ID_kierowcy = Ku.ID_kierowcy
	LEFT JOIN Rozkłady_jazdy as R on Ku.Nr_kursu = R.Nr_kursu
	WHERE K.ID_kierowcy = @Id_k
GO
```

[link do kodu](../../functions/Rozklad_jazdy_kierowcy.sql)
