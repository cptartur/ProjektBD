# Kierowcy

## Kolumny

| Nazwa                | Typ          | Nullable | Default | Constraints                                          | Klucze obce | Opis              |
| -------------------- | ------------ | -------- | ------- | ---------------------------------------------------- | ----------- | ----------------- |
| **ID_Kierowcy (PK)** | INT          | Nie      | -       | `PRIMARY KEY`, `IDENTITY(1,1)`                       | -           | ID kierowcy       |
| Imię                 | NVARCHAR(50) | Nie      | -       | -                                                    | -           | Imię kierowcy     |
| Nazwisko             | NVARCHAR(50) | Nie      | -       | -                                                    | -           | Nazwisko kierowcy |
| Data_urodzenia       | DATE         | Nie      | -       | -                                                    | -           | Data urodzenia    |
| PESEL                | BIGINT       | Nie      | -       | `CHECK PESEL >= 10000000000 AND PESEL<= 99999999999`, `UNIQUE` | -           | Data urodzenia    |

## Opis tabeli

Zawiera podstawowe informacje o kierowcach.
