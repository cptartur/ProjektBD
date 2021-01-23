# Linie

## Kolumny

| Nazwa                | Typ          | Nullable | Default | Constraints                                                                                                                                                 | Klucze obce | Opis        |
| -------------------- | ------------ | -------- | ------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- | ----------- |
| **Numer_linii (PK)** | INT          | Nie      | -       | `PRIMARY KEY`, `CHECK ((Typ_pojazdu LIKE 'tramwaj' AND Numer_linii BETWEEN 0 AND 100) OR (Typ_pojazdu LIKE 'autobus' AND Numer_linii BETWEEN 100 AND 999))` | -           | Numer linii |
| Typ_pojazdu          | NVARCHAR(50) | Nie      | -       | -                                                                                                                                                           | -           | Typ linii   |

## Opis tabeli

Tabela zawiera podstawowe informacje o liniach.
