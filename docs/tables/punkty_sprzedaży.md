# Punkty_sprzedaży

## Kolumny

| Nazwa              | Typ | Nullable | Default | Constraints                    | Klucze obce | Opis                |
| ------------------ | --- | -------- | ------- | ------------------------------ | ----------- | ------------------- |
| **ID_punktu (PK)** | INT | Nie      | -       | `PRIMARY KEY`, `IDENTITY(1,1)` | -           | ID punktu sprzedaży |
| Nazwa_przystanku | NVARCHAR(50) | Nie      | -       | - | `Przystanki.Nazwa_przystanku`       | Nazwa przystanku, na którym znajduje się punkt sprzedaży |

## Opis tabeli

Tabela zawiera informacje o punktach sprzedaży oraz ich lokalizacjach.
