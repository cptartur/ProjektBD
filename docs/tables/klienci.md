# Klienci

## Kolumny

| Nazwa               | Typ          | Nullable | Default | Constraints                                          | Klucze obce        | Opis                                  |
| ------------------- | ------------ | -------- | ------- | ---------------------------------------------------- | ------------------ | ------------------------------------- |
| **ID_klienta (PK)** | INT          | Nie      | -       | `PRIMARY KEY`, `IDENTITY`                            | -                  | ID osoby                              |
| Imię                | NVARCHAR(50) | Nie      | -       | -                                                    | -                  | Imię klienta                          |
| Nazwisko            | NVARCHAR(50) | Nie      | -       | -                                                    | -                  | Nazwisko klienta                      |
| PESEL               | BIGINT       | Nie      | -       | `CHECK PESEL >= 10000000000 AND PESEL<= 99999999999` | -                  | PESEL klienta                         |
| Ulga                | NVARCHAR(50) | Tak      | -       | -                                                    | `Ulgi.Rodzaj_ulgi` | Rodzaj ulgii przysługującej klientowi |

## Opis tabeli

Tablela zawiera podstawowe informacje o klientach.
