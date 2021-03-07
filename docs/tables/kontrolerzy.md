# Kontrolerzy

## Kolumny

| Nazwa                  | Typ          | Nullable | Default | Constraints                    | Klucze obce | Opis                |
| ---------------------- | ------------ | -------- | ------- | ------------------------------ | ----------- | ------------------- |
| **ID_kontrolera (PK)** | INT          | Nie      | -       | `PRIMARY KEY`, `IDENTITY(1,1)` | -           | ID kontrolera       |
| Imię                   | NVARCHAR(50) | Nie      | -       | -                              | -           | Imię kontrolera     |
| Nazwisko               | NVARCHAR(50) | Nie      | -       | -                              | -           | Nazwisko kontrolera |

## Opis tabeli

Tabela zawiera informacje o kontrolerach biletów.
