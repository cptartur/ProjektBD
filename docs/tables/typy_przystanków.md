# Typy_przystanków

## Kolumny

| Nazwa             | Typ          | Nullable | Default | Constraints | Klucze obce | Opis                                    |
| ----------------- | ------------ | -------- | ------- | ----------- | ----------- | --------------------------------------- |
| Typ               | NVARCHAR(50) | Nie      | -       | -           | -           | Typ przystanku (tramwajowy, autobusowy) |
| **Kod_typu (PK)** | NCHAR(3)     | Nie      | -       | -           | -           | Kod typu przystanku                     |

## Opis tabeli

Tablela zawiera możliwe typy przystanków.
