# Przenieś_pojazd

## Parametry wejściowe

| Nazwa                   | Typ |
| ----------------------- | --- |
| ID_pojazdu              | INT |
| ID_zajezdni_początkowej | INT |
| ID_zajezdni_docelowej   | INT |

## Opis działania

Przenieś pojazd między zajezdniami i zaktualizuj stan zapełnienia odpowiednich zajezdni.

## Kod źródłowy

```sql
CREATE OR ALTER PROCEDURE Przenieś_pojazd
    @ID_pojazdu INT,
    @ID_zajezdni_początkowej INT,
    @ID_zajezdni_docelowej INT
AS
    IF NOT EXISTS (
        SELECT P.ID_pojazdu
        FROM Pojazdy AS P
        WHERE (P.ID_pojazdu = @ID_pojazdu) AND (P.ID_zajezdni = @ID_zajezdni_początkowej)
    )
    BEGIN
        RAISERROR('Podanego pojazdu nie ma w zajezdni', 16, 1)
        RETURN
    END

    IF NOT EXISTS (
        SELECT Z.ID_zajezdni
        FROM Zajezdnie AS Z
        WHERE @ID_zajezdni_docelowej = Z.ID_zajezdni
    )
    BEGIN
        RAISERROR ('Zajezdnia początkowa nie istnieje', 16, 2)
        RETURN
    END

    IF NOT EXISTS (
        SELECT Z.ID_zajezdni
        FROM Zajezdnie AS Z
        WHERE @ID_zajezdni_docelowej = Z.ID_zajezdni
    )
    BEGIN
        RAISERROR ('Zajezdnia docelowa nie istnieje', 16, 3)
        RETURN
    END

    IF NOT EXISTS (
        SELECT P.ID_pojazdu
        FROM Pojazdy AS P
        WHERE @ID_pojazdu = P.ID_pojazdu
    )
    BEGIN
        RAISERROR ('Pojazd nie istnieje', 16, 4)
        RETURN
    END

    IF @ID_zajezdni_docelowej = @ID_zajezdni_początkowej
    BEGIN
        RAISERROR('Zajednia początkowa nie może być taka sama jak docelowa', 16, 5)
        RETURN
    END

    DECLARE @Typ_pojazdu VARCHAR(50)
    SET @Typ_pojazdu = (
        SELECT Typ_pojazdu
        FROM Pojazdy AS P
        WHERE @ID_pojazdu = P.ID_pojazdu
    )

    IF @Typ_pojazdu = 'autobus'
    BEGIN
        DECLARE @Pojemność_autobusów INT
        SET @Pojemność_autobusów = (
            SELECT (Z.Pojemność_autobusów - Z.Liczba_autobusów)
            FROM Zajezdnie AS Z
            WHERE Z.ID_zajezdni = @ID_zajezdni_docelowej
        )

        IF @Pojemność_autobusów <= 0
        BEGIN
            RAISERROR ('Zajezdnia docelowa jest pełna', 16, 6)
            RETURN
        END

        UPDATE Zajezdnie
        SET Liczba_autobusów = 
        (
            CASE
                WHEN ID_zajezdni = @ID_zajezdni_początkowej THEN (Liczba_autobusów - 1)
                WHEN ID_zajezdni = @ID_zajezdni_docelowej THEN (Liczba_autobusów + 1)
                ELSE Liczba_autobusów
            END
        )
        UPDATE Pojazdy
        SET ID_zajezdni = @ID_zajezdni_docelowej
        WHERE ID_pojazdu = @ID_pojazdu
    END
    ELSE
    BEGIN
        DECLARE @Pojemność_tramwajów INT
        SET @Pojemność_tramwajów = (
            SELECT (Z.Pojemność_tramwajów - Z.Pojemność_tramwajów)
            FROM Zajezdnie AS Z
            WHERE Z.ID_zajezdni = @ID_zajezdni_docelowej
        )

        IF @Pojemność_tramwajów <= 0
        BEGIN
            RAISERROR ('Zajezdnia docelowa jest pełna', 16, 6)
            RETURN
        END
        
        UPDATE Zajezdnie
        SET Liczba_tramwajów = 
        (
            CASE
                WHEN ID_zajezdni = @ID_zajezdni_początkowej THEN (Liczba_tramwajów - 1)
                WHEN ID_zajezdni = @ID_zajezdni_docelowej THEN (Liczba_tramwajów + 1)
                ELSE Liczba_autobusów
            END
        )
        UPDATE Pojazdy
        SET ID_zajezdni = @ID_zajezdni_docelowej
        WHERE ID_pojazdu = @ID_pojazdu
    END
```

[link do kodu](../../procs/Przenieś_pojazd.sql)
