# Kursy

## Kolumny

| Nazwa                | Typ          | Nullable | Default | Constraints   | Klucze obce                   | Opis                                                      |
| -------------------- | ------------ | -------- | ------- | ------------- | ----------------------------- | --------------------------------------------------------- |
| **Nr_kursu (PK)**    | INT          | Nie      | -       | `PRIMARY KEY` | -                             | Numer kursu                                               |
| **Numer_linii (PK)** | INT          | Nie      | -       | `PRIMARY KEY` | `Linie.Numer_linii`           | Numer linii, której dotyczy kurs                          |
| ID_pojazdu           | INT          | Tak      | -       | -             | `Pojazdy.ID_pojazdu`          | ID_pojazdu przypisanego do kursu                          |
| Pierwszy_przystanek  | NVARCHAR(50) | Nie      | -       | -             | `Przystanki.Nazwa_przystanku` | Nazwa pierwszego przystanku w kursie                      |
| Ostatni_przystanek   | NVARCHAR(50) | Nie      | -       | -             | `Przystanki.Nazwa_przystanku` | Nazwa ostatniego przystanku w kursie                      |
| ID_kierowcy          | INT          | Nie      | -       | -             | `Kierowcy.ID_kierowcy`        | ID_kierowcy, który będzie prowadził pojazd w danym kursie |

## Opis tabeli

Tablela zawiera podstawowe informacje o pojedynczym kursie linii.
