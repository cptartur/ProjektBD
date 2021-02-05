# Historia_biletów_osoby

## Parametry wejściowe

| Nazwa     | Typ |
| --------- | --- |
| Identyfikator klienta | INT |

## Wyjście

| Nazwa              | Typ   |
| ------------------ | ----- |
| Historia_biletow_osoby | TABLE |

## Opis działania

Wypisz wszystkie bilety zakupione przez klienta o podanym ID. Otrzymamy informację o rodzaju biletu, cenie, dacie zakupu, dacie wygaśnięcia biletu, punkcie sprzedaży biletu oraz wszystkie dane klienta w tym przysługujące mu w danym momencie ulgi.

## Kod źródłowy

```sql
GO
CREATE FUNCTION Historia_biletow_osoby (@klient AS INT)
RETURNS TABLE
AS
RETURN
	SELECT ID_biletu,Rodzaj_biletu,Cena,Data_zakupu,Data_wygaśnięcia,ID_punktu_sprzedaży,
	K.ID_klienta,Imię,Nazwisko,PESEL,Ulga FROM Bilety as B
	JOIN Klienci as K on B.ID_klienta = K.ID_klienta
	WHERE K.ID_klienta = @klient
GO
```

[link do kodu](../../functions/Historia_biletow_osoby.sql)
