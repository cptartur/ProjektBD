# Nazwa tabeli

## Kolumny

| Nazwa               | Typ  | Nullable | Default | Constraints                                | Klucze obce          | Opis                       |
| ------------------- | ---- | -------- | ------- | ------------------------------------------ | -------------------- | -------------------------- |
| **ID_pojazdu (PK)** | INT  | Nie      | -       | `PRIMARY KEY`                              | `Pojazdy.ID_pojazdu` | ID pojazdu                 |
| Data_przeglądu      | DATE | Nie      | -       | `CHECK Data_wygaśnięcia >= Data_przeglądu` | -                    | Data przeglądu             |
| Data_wygaśnięcia    | DATE | Nie      | -       | `CHECK Data_wygaśnięcia >= Data_przeglądu` | -                    | Data wygaśnięcia przeglądu |

## Opis tabeli

Tabela zawiera informacje o ważności przeglądów wszystkich pojazdów.
