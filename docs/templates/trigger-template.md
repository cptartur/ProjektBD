# Nazwa wyzwalacza

## Warunek uruchomienia

`AFTER INSERT`

## Opis działania

Po dodaniu wierszy do tabeli `db`, dodaj do niej wartości `(1, 2, '3')`.

## Kod źródłowy

```sql
CREATE OR ALTER TRIGGER Przykład ON db
AFTER INSERT
AS
ALTER TABLE db
INSERT VALUES
(1, 2, '3')
GO
```

[link do kodu](../../triggers/example.sql)
