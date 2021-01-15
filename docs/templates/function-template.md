# Nazwa funkcji

## Parametry wejściowe

| Nazwa      | Typ         |
| ---------- | ----------- |
| `Variable1 | INT         |
| Variable2  | VARCHAR(50) |
| Variable   | MONEY       |

## Wyjście

| Nazwa   | Typ   |
| ------- | ----- |
| Results | TABLE |

## Opis działania

Zwróć tableę zawierającą wszystkie rekordy z tablei db, w których wartość kolumny `i1` jest równa parametrowi `Variable1`.

## Kod źródłowy

```sql
CREATE OR ALTER FUNCTION Przykład (@Variable1 INT)
RETURN TABLE
AS
RETURN
    SELECT *
    FROM db
    WHERE i1 = @Variable1
```

[link do kodu](../../functions/example.sql)
