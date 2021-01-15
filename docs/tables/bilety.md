# Bilety

## Kolumny

| Nazwa               | Typ          | Nullable | Default | Constraints                    | Klucze obce                     | Opis                                   |
| ------------------- | ------------ | -------- | ------- | ------------------------------ | ------------------------------- | -------------------------------------- |
| **ID_biletu (PK)**  | INT          | Nie      | -       | `PRIMARY KEY`, `IDENTITY(1,1)` | -                               | ID biletu                              |
| ID_klienta          | INT          | Nie      | -       | -                              | `Klienci.ID_klienta`            | ID klienta, który kupił bilet          |
| Rodzaj_biletu       | NVARCHAR(50) | Nie      | -       | -                              | `Rodzaje_biletów.Rodzaj_biletu` | Rodzaj biletu (normalny, ulgowy, itd.) |
| Cena                | MONEY        | Nie      | -       | -                              | -                               | Rzeczywista cena biletu                |
| Data_zakupu         | DATE         | Nie      | -       | -                              | -                               | Data zakupu biletu                     |
| Data_wygaśnięcia    | DATE         | Nie      | -       | -                              | -                               | Data utraty ważności biletu            |
| ID_punktu_sprzedaży | INT          | Tak      | -       | -                              | `Punkty_sprzedaży.ID_punktu`    | Data utraty ważności biletu            |

## Opis tabeli

Tablela zawiera informacje o aktywnych i wygasłych biletach oraz o ich rzeczywistych cenach (uwzględniających wszystkie ulgi).
