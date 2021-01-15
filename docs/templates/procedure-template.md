# Nazwa procedury

## Parametry wejściowe

| Nazwa     | Typ         |
| --------- | ----------- |
| Variable1 | INT         |
| Variable2 | VARCHAR(50) |
| Variable  | MONEY       |

## Opis działania

Wybierz z bazy danych wszystkie wiersze, w których wartość kolumny `i1` jest równa parametrowi `Variable1`.

## Kod źródłowy

```sql
CREATE OR ALTER PROCEDURE Przykład
    @Variable1 INT,
    @Variable2 VARCHAR(50),
    @Variable3 MONEY
AS
    SELECT *
    FROM db
    WHERE i1 = @Variable1
```

[link do kodu](../../procs/example.sql)
