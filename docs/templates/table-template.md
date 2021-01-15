# Nazwa tabeli

## Kolumny

| Nazwa       | Typ         | Nullable | Default     | Constraints               | Klucze obce                      | Opis            |
| ----------- | ----------- | -------- | ----------- | ------------------------- | -------------------------------- | --------------- |
| **ID (PK)** | INT         | Nie      | `-`         | `PRIMARY KEY`, `IDENTITY` | `tab2.ID`                        | ID osoby        |
| Name        | VARCHAR(50) | Tak      | `Jan Nowak` | -                         | `names_tab.name`, `clients.name` | Imię i nazwisko |
| Age         | INT         | Tak      | `25`        | `CHECK Age >= 25`         | -                                | Wiek            |

## Opis tabeli

Tablela zawiera podstawowe informacje o osobach.
