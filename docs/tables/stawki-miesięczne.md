# Stawki miesięczne

## Kolumny

| Nazwa                | Typ   | Nullable | Default | Constraints   | Klucze obce | Opis                               |
| -------------------- | ----- | -------- | ------- | ------------- | ----------- | ---------------------------------- |
| **Rok (PK)**         | INT   | Nie      | -       | `PRIMARY KEY` | -           | Rok w którym obowiązuje stawka     |
| **Miesiąc (PK)**     | INT   | Nie      | -       | `PRIMARY KEY` | -           | Miesiąc w którym obowiązuje stawka |
| Stawka_podstawowa    | MONEY | Nie      | -       | -             | -           |                                    |
| Stawka_za_nadgodziny | INT   | Nie      | -       | -             | -           |                                    |

## Opis tabeli

Tabela zawiera informacje o obwiązujących w danych miesiącach podstawowych stawkach wynagrodzenia oraz za nadgodziny. Zawiera też historyczne dane.
