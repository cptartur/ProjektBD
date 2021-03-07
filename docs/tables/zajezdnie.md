# Zajezdnie

## Kolumny

| Nazwa                | Typ          | Nullable | Default | Constraints   | Klucze obce | Opis                                              |
| -------------------- | ------------ | -------- | ------- | ------------- | ----------- | ------------------------------------------------- |
| **ID_zajezdni (PK)** | INT          | Nie      | -       | `PRIMARY KEY` | -           | ID zajezdni                                       |
| Nazwa                | NVARCHAR(50) | Nie      | -       | -             | -           | Nazwa zajezdni                                    |
| Adres                | NVARCHAR(50) | Nie      | -       | -             | -           | Adres zajezdni                                    |
| Pojemność_autobusów  | INT          | Tak      | -       | -             | -           | Maksymalna pojemność autobusów                    |
| Pojemność_tramwajów  | INT          | Tak      | -       | -             | -           | Maksymalna pojemność tramwajów                    |
| Liczba_autobusów     | INT          | Tak      | -       | -             | -           | Liczba autobusów obecnie przypisanych do zajezdni |
| Liczba_tramwajów     | INT          | Tak      | -       | -             | -           | Liczba pojazdów obecnie przypisanych do zajezdni  |

## Opis tabeli

Tabela zawiera informacje o zajezdniach i ich aktualnym stanie zapełnienia.
