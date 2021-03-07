# Nazwa widoku

## Opis działania

Połącz tabele `db1` i `db2`.

## Kod źródłowy

```sql
CREATE OR ALTER VIEW TEST
AS
SELECT *
FROM db1
INNER JOIN db2
    ON db1.i1 = db2.i1
```

[link do kodu](../../views/example.sql)
