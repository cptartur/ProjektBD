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

## Wyzwalacze

`Blokada_zakupu_biletu AFTER INSERT`

## Opis tabeli

Tabela zawiera informacje o aktywnych i wygasłych biletach oraz o ich rzeczywistych cenach (uwzględniających wszystkie ulgi). Cena biletów zmienia się w czasie -- aktualna cena biletów jest przechowywana w tabeli `Rodzaje_biletów`, a przy zakupie biletu jest mu przypisywana jego aktualna cena. Po zmianie ceny w `Rodzaje_biletów`, cena w `Bilety` pozostaje bez zmian.
