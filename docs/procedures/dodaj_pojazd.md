# Dodaj_pojazd

## Parametry wejściowe

| Nazwa               | Typ          |
| ------------------- | ------------ |
| ID_pojazdu          | INT          |
| Typ_pojazdu         | NVARCHAR(50) |
| Producent           | NVARCHAR(50) |
| Model               | NVARCHAR(50) |
| Data_zakupu         | DATE         |
| Numer_rejestracyjny | NCHAR(10)    |
| ID_zajezdni         | INT          |

## Opis działania

Dodaj do bazy danych nowy pojazd o podanych parametrach. Sprawdź czy w zajezdni, do której pojazd jest dodawany, jest wolne miejsce, oraz zaktualizuj pojemnośc zajezdni. Jeżeli nie podano `ID_zajezdni` to dodaj pojazd do magazynu (zajezdni o `ID_zajezdni = 1`).

## Kod źródłowy

```sql
CREATE OR ALTER PROCEDURE Dodaj_pojazd
    @ID_pojazdu INT,
    @Typ_pojazdu NVARCHAR(50),
    @Producent NVARCHAR(50),
    @Model NVARCHAR(50),
    @Data_zakupu DATE,
    @Numer_rejestracyjny NCHAR(10) = NULL,
    @ID_zajezdni INT = NULL
AS
    SET NOCOUNT ON
    IF @ID_zajezdni IS NOT NULL AND EXISTS (
            SELECT *
            FROM Zajezdnie AS Z
            WHERE Z.ID_zajezdni = @ID_zajezdni
        )
    BEGIN
        DECLARE @miejsce int = 0;
        IF @Typ_pojazdu = 'autobus'
            SELECT @miejsce  = (
                SELECT (Pojemność_autobusów - Liczba_autobusów) AS Miejsce
                FROM Zajezdnie AS Z
                WHERE Z.ID_zajezdni = @ID_zajezdni
            )
        ELSE
            SELECT @miejsce = (
                SELECT (Pojemność_tramwajów - Liczba_tramwajów) AS Miejsce
                FROM Zajezdnie AS Z
                WHERE Z.ID_zajezdni = @ID_zajezdni
            )
        IF @miejsce > 0
            BEGIN
                INSERT INTO Pojazdy
                VALUES
                (@ID_pojazdu, @Typ_pojazdu, @Producent, @Model, @Data_zakupu, @Numer_rejestracyjny, @ID_zajezdni);

                IF @Typ_pojazdu = 'autobus'
                BEGIN
                    UPDATE Zajezdnie
                    SET Liczba_autobusów = Liczba_autobusów + 1
                    WHERE ID_zajezdni = @ID_zajezdni
                END
                ELSE
                BEGIN
                    UPDATE Zajezdnie
                    SET Liczba_tramwajów = Liczba_tramwajów + 1
                    WHERE ID_zajezdni = @ID_zajezdni
                END
            END
        ELSE
            RAISERROR ('Wybrana zajezdnia jest pełna', 1, 1)
            RETURN
    END
    ELSE
    BEGIN
        INSERT INTO Pojazdy
        VALUES
        (@ID_pojazdu, @Typ_pojazdu, @Producent, @Model, @Data_zakupu, @Numer_rejestracyjny, NULL);
    END
```

[link do kodu](../../procs/Dodaj_pojazd.sql)
