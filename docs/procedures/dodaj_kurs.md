# Dodaj_kurs

## Parametry wejściowe

| Nazwa       | Typ                     |
| ----------- | ----------------------- |
| Nr_kursu    | INT                     |
| Nr_linii    | INT                     |
| ID_pojazdu  | INT                     |
| ID_kierowcy | INT                     |
| Rozkład     | Przystanek_w_rozkładzie |

## Opis działania

Sprawdź czy dane są poprawne, sprawdź czy kolejne przystanki podane w rozkładzie mają coraz późniejsze godziny odjazdu. Dodaj kurs do tabeli `Kursy` oraz rozkład jazdy do tabeli `Rozkłady_jazdy`.

## Kod źródłowy

```sql
CREATE OR ALTER PROCEDURE Dodaj_kurs
    @Nr_kursu INT,
    @Nr_linii INT,
    @ID_pojazdu INT,
    @ID_kierowcy INT,
    @Rozkład [Przystanek_w_rozkładzie] READONLY
AS
    SET NOCOUNT ON
    IF NOT EXISTS (
        SELECT L.Numer_linii
        FROM Linie AS L
        WHERE L.Numer_linii = @Nr_linii
    )
    BEGIN
        RAISERROR ('Taka linia nie istnieje', 16, 1)
        RETURN;
    END

    IF EXISTS (
        SELECT K.Nr_kursu
        FROM Kursy AS K
        WHERE (K.Nr_kursu = @Nr_kursu) AND (K.Numer_linii = @Nr_linii)
    )
    BEGIN
        RAISERROR ('Kurs o podanym numerze już istnieje', 16, 2)
        RETURN;
    END

    IF EXISTS (
        SELECT *
        FROM @Rozkład AS L
        CROSS JOIN @Rozkład AS R
        WHERE (L.Numer_przystanku < R.Numer_przystanku) AND (L.Godzina_odjazdu > R.Godzina_odjazdu)
    )
    BEGIN
        RAISERROR ('Nieprawidłowa kolejność przystanków', 16, 3)
        RETURN;
    END

    IF NOT EXISTS (
        SELECT P.ID_pojazdu
        FROM Pojazdy AS P
        WHERE P.ID_pojazdu = @ID_pojazdu
    )
    BEGIN
        RAISERROR ('Pojazd o podanym ID nie istnieje', 16, 4)
        RETURN;
    END

    IF NOT EXISTS (
        SELECT K.ID_kierowcy
        FROM Kierowcy AS K
        WHERE K.ID_kierowcy = @ID_kierowcy
    )
    BEGIN
        RAISERROR ('Kierowca o podanym ID nie istnieje', 16, 5)
        RETURN;
    END

    IF EXISTS (
        SELECT R.Numer_przystanku
        FROM @Rozkład AS R
        LEFT JOIN Przystanki AS P
            ON P.Nazwa_przystanku = R.Nazwa_przystanku
        WHERE P.Nazwa_przystanku IS NULL
    )
    BEGIN
        RAISERROR ('Niektóre z podanych przystanków nie istnieją', 16, 6)
        RETURN;
    END

    BEGIN
        DECLARE @Pierwszy_przystanek NVARCHAR(50)
        DECLARE @Ostatni_przystanek NVARCHAR(50)
        SET @Pierwszy_przystanek = (
            SELECT TOP 1 Nazwa_przystanku
            FROM @Rozkład
            ORDER BY Numer_przystanku 
        )
        SET @Ostatni_przystanek = (
            SELECT TOP 1 Nazwa_przystanku
            FROM @Rozkład
            ORDER BY Numer_przystanku DESC
        )

        INSERT INTO Kursy
        VALUES (@Nr_kursu, @Nr_linii, @ID_pojazdu, @Pierwszy_przystanek, @Ostatni_przystanek, @ID_kierowcy)

        INSERT INTO Rozkłady_jazdy
        SELECT @Nr_linii, R.Nazwa_przystanku, @Nr_kursu, R.Godzina_odjazdu
        FROM @Rozkład AS R
    END
```

[link do kodu](../../procs/Dodaj_kurs.sql)
