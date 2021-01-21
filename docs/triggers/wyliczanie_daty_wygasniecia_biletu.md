# wyliczanie_daty_wygasniecia_biletu

## Warunek uruchomienia

`ON Bilety AFTER INSERT`

## Opis działania

Zaktualizuj dodany bilet w tabeli `Bilety` o datę wygaśnięcia biletu wyliczaną na bazie daty zakupu + liczbie dni ważności biletu na podstawie kupowanego rodzaju biletu z tabeli `Rodzaje_biletów`.

## Kod źródłowy

```sql
CREATE OR ALTER TRIGGER wyliczanie_daty_wygasniecia_biletu ON Bilety
AFTER INSERT
AS
	IF (ROWCOUNT_BIG() = 0)
	RETURN;
	UPDATE Bilety
	SET Data_wygaśnięcia = DATEADD (DD, R.Okres_w_dniach, I.Data_zakupu)
	FROM Bilety AS B
	JOIN Rodzaje_biletów AS R 
	ON B.Rodzaj_biletu = R.Rodzaj_biletu
	JOIN inserted AS I 
	ON I.ID_biletu = B.ID_biletu
```

[link do kodu](../../triggers/wyliczanie_daty_wygasniecia_biletu.sql)
