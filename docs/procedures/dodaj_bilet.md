# Dodaj_bilet

## Parametry wejściowe

| Nazwa                | Typ                     |
| -------------------- | ----------------------- |
| Id_klienta           | INT                     |
| Rodzaj_biletu        | nvarchar(50)            |
| Data_zakupu          | date                    |
| Id_punktu_sprzedaży  | INT                     |

## Opis działania

Sprawdź czy deklarowany punkt istnieje, sprawdź czy klient istnieje, sprawdź czy nie próbujesz dodać biletu osobie, która ma już ważny bilet. Dodaj bilet do tabeli `Bilety`. 

## Kod źródłowy

```sql
CREATE OR ALTER PROCEDURE Dodaj_bilet
	@Id_klienta INT,
	@Rodzaj_biletu nvarchar(50),
	@Data_zakupu date,
	@Id_punktu_sprzedaży INT
AS
	IF NOT EXISTS (
					SELECT * 
					FROM Punkty_sprzedaży
					WHERE ID_punktu = @Id_punktu_sprzedaży)
	BEGIN
		RAISERROR('Nie ma takiego punktu sprzedaży',16,1)
		RETURN;
	END
	ELSE IF NOT EXISTS (
					SELECT * 
					FROM Klienci
					WHERE ID_klienta = @Id_klienta)
	BEGIN
		RAISERROR('Nie ma takiego klienta',16,2)
		RETURN;
	END
	ELSE IF EXISTS (
					SELECT * FROM Bilety
					WHERE ID_klienta = @Id_klienta AND Data_wygaśnięcia>@Data_zakupu)
	BEGIN
		RAISERROR('Twój bilet jest już ważny',16,2)
		RETURN;
	END
	ELSE
	BEGIN
		INSERT INTO Bilety
		VALUES(@Id_klienta,@Rodzaj_biletu,-1,@Data_zakupu,@Data_zakupu,@Id_punktu_sprzedaży)
	END
```

[link do kodu](../../procs/Dodaj_bilet.sql)
