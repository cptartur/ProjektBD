# Rodzaje_biletów

## Kolumny

| Nazwa                  | Typ   | Nullable | Default | Constraints               | Klucze obce | Opis                                |
| ---------------------- | ----- | -------- | ------- | ------------------------- | ----------- | ----------------------------------- |
| **Rodzaj_biletu (PK)** | INT   | Nie      | `-`     | `PRIMARY KEY`, `IDENTITY` | `tab2.ID`   | Typ biletu (normalny, ulgowy, itd.) |
| Cena_bazowa            | MONEY | Nie      | -       | -                         | -           | Podstawowa cena biletu              |
| Okres_w_dniach         | INT   | Nie      | -       | -                         | -           | Okres ważności biletu w dniach      |

## Opis tabeli

Tabela zawiera podstawowe informacje o dostępnych rodzajach biletów (normalny, ulgowy, itd.).
