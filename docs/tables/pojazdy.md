# Pojazdy

## Kolumny

| Nazwa               | Typ          | Nullable | Default | Constraints                    | Klucze obce             | Opis                                                    |
| ------------------- | ------------ | -------- | ------- | ------------------------------ | ----------------------- | ------------------------------------------------------- |
| **ID_pojazdu (PK)** | INT          | Nie      | -       | `PRIMARY KEY`                  | -                       | ID pojazdu                                              |
| Typ_pojazdu         | NVARCHAR(50) | Nie      | -       | `CHECK 'autobus' OR 'tramwaj'` | -                       | Typ pojazdu                                             |
| Producent           | NVARCHAR(50) | Nie      | -       | -                              | -                       | Producent pojazdu                                       |
| Model               | NVARCHAR(50) | Nie      | -       | -                              | -                       | Model pojazdu                                           |
| Data_zakupu         | DATE         | Nie      | -       | -                              | -                       | Model pojazdu                                           |
| Numer_rejestracyjny | NCHAR(10)    | Tak      | -       | -                              | -                       | Numer rejestracyjny pojazdu                             |
| ID_zajezdni         | INT          | Tak      | -       | -                              | `Zajezdnie.ID_zajezdni` | ID zajezdni, do której aktualnie przypisany jest pojazd |

## Wyzwalacze

`Dodaj_przegląd AFTER INSERT`

## Opis tabeli

Tabela zawiera podstawowe informacje o pojazdach.
