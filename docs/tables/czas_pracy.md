# Czas_pracy

## Kolumny

| Nazwa                | Typ | Nullable | Default | Constraints              | Klucze obce            | Opis                                        |
| -------------------- | --- | -------- | ------- | ------------------------ | ---------------------- | ------------------------------------------- |
| **ID_kierowcy (PK)** | INT | Nie      | -      | `PRIMARY KEY`            | `Kierowcy.ID_kierowcy` | ID kierowcy                                 |
| Rok                  | INT | Nie      | -       | -                        |                        | Rok wpisu                                   |
| Miesiąc              | INT | Nie      | -       | `CHECK BETWEEN 1 AND 12` |                        | Miesiąc wpisu                               |
| Godziny_pracy        | INT | Nie      | -       | -                        |                        | Liczba przepracowanych w miesiącu godzin    |
| Nadgodziny           | INT | Nie      | -       | -                        |                        | Liczba przepracowanych w miesiącu nadgodzin |

## Opis tabeli

Tabela zawiera historię przepracowanych godzin przez wszystkich pracowników z podziałem na lata i miesiące.
