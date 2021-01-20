# Mandaty

## Kolumny

| Nazwa               | Typ           | Nullable | Default | Constraints                                          | Klucze obce                 | Opis                                |
| ------------------- | ------------- | -------- | ------- | ---------------------------------------------------- | --------------------------- | ----------------------------------- |
| **ID_mandatu (PK)** | INT           | Nie      | -       | `PRIMARY KEY`                                        | -                           | ID mandatu                          |
| Imię                | NVARCHAR(50)  | Nie      | -       | -                                                    | -                           | Imię ukaranego                      |
| Imię                | NVARCHAR(50)  | Nie      | -       | -                                                    | -                           | Nazwisko ukaranego                  |
| PESEL               | BIGINT        | Nie      | -       | `CHECK PESEL >= 10000000000 AND PESEL<= 99999999999` | -                           | PESEL ukaranego                     |
| Adres               | NVARCHAR(150) | Nie      | -       | -                                                    | -                           | Adres ukaranego                     |
| Kwota               | MONEY         | Nie      | -       | -                                                    | -                           | Kwota mandatu                       |
| ID_wystawiającego   | INT           | Tak      | -       | -                                                    | `Kontrolerzy.ID_kontrolera` | ID kontrolera wystawiającego mandat |
| ID_klienta          | INT           | Tak      | -       | -                                                    | `Klienci.ID_klienta` | ID klienta, który otrzymał mandat   |

## Opis tabeli

Tabela zawiera informacje o wystawionych mandatach oraz opcjonalnie o klientach które je otrzymali. 
