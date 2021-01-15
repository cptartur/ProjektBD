# Ulgi

## Kolumny

| Nazwa                | Typ          | Nullable | Default | Constraints               | Klucze obce | Opis                       |
| -------------------- | ------------ | -------- | ------- | ------------------------- | ----------- | -------------------------- |
| **Rodzaj_ulgi (PK)** | NVARCHAR(50) | Nie      | -       | `PRIMARY KEY`             |             | Rodzaj ulgi                |
| Zniżka               | INT          | Tak      | -       | `CHECK BETWEEN 0 AND 100` | -           | Wartośc ulgii w procentach |

## Opis tabeli

Tablela zawiera informacje o możliwych ulgach i przysługjących w związku z nimi ulgach.
