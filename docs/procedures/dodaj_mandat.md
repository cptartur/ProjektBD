# Dodaj_mandat

## Parametry wejściowe

| Nazwa               | Typ          |
| ------------------- | ------------ |
| Id_mandatu          | INT          |
| Imię                | NVARCHAR(50) |
| Nazwisko            | NVARCHAR(50) |
| PESEL               | BIGINT       |
| Adres               | NVARCHAR(150)|
| Kwota               | MONEY        |
| Id_kontrolera       | INT          |

## Opis działania

Jeśli dodawany jest mandat o istniejącym już Id_mandatu to jest błąd.
Jeśli próbujemy wstawić mandat na nieistniejącego kontrolera to jest błąd.
W przeciwnym wypadku wstawiamy mandat o podanych parametrach.

## Kod źródłowy

```sql
CREATE OR ALTER PROCEDURE Dodaj_mandat	
	@Id_mandatu INT,
	@Imię nvarchar(50),
	@Nazwisko nvarchar(50),
	@PESEL BIGINT,
	@Adres nvarchar(150),
	@Kwota MONEY,
	@Id_kontrolera INT
AS
	IF EXISTS (
		SELECT *
		FROM Mandaty
		WHERE ID_mandatu = @Id_mandatu)
	BEGIN
		RAISERROR('Mandat o takim ID już istnieje',16,1)
		RETURN;
	END
	ELSE IF NOT EXISTS (
		SELECT * 		
		FROM Kontrolerzy
		WHERE ID_kontrolera = @Id_kontrolera)
		AND @Id_kontrolera IS NOT NULL
	BEGIN
		RAISERROR('Próbujesz wystawić mandat na nieistniejącego kontrolera',16,2)
		RETURN;
	END
	ELSE
	BEGIN
		INSERT INTO Mandaty
		VALUES(@Id_mandatu,@Imię,@Nazwisko,@PESEL,@Adres,@Kwota,@Id_kontrolera,NULL)
	END
```

[link do kodu](../../procs/Dodaj_mandat.sql)
