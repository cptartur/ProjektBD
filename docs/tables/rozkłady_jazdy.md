# Nazwa tabeli

## Kolumny

| Nazwa                     | Typ          | Nullable | Default | Constraints   | Klucze obce                   | Opis                              |
| ------------------------- | ------------ | -------- | ------- | ------------- | ----------------------------- | --------------------------------- |
| **Numer_linii (PK)**      | INT          | Nie      | -       | `PRIMARY KEY` | `Linie.Numer_linii`           | Numer linii, której dotyczy wpis  |
| **Nazwa_przystanku (PK)** | NVARCHAR(50) | Nie      | -       | `PRIMARY KEY` | `Przystanki.Nazwa_przystanku` | Nazwa przystanku                  |
| **Numer_kursu (PK)**      | INT          | Nie      | -       | `PRIMARY KEY` | `Kursy.Numer_kursu`           | Nazwa kursu, którego dotyczy wpis |
| Godzina_odjazdu           | TIME(0)      | Nie      | -       | -             | -                             | Godzina odjazdu z przystanku      |

## Opis tabeli

Tabela zawiera rozkłady jazdy wszystkich kursów wszystkich linii w bazie danych.
