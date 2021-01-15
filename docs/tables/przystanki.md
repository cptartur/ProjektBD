# Przystanki

## Kolumny

| Nazwa                     | Typ          | Nullable | Default | Constraints   | Klucze obce                 | Opis                                                             |
| ------------------------- | ------------ | -------- | ------- | ------------- | --------------------------- | ---------------------------------------------------------------- |
| **Nazwa_przystanku (PK)** | NVARCHAR(50) | Nie      | -       | `PRIMARY KEY` | -                           | ID przystanku                                                    |
| Współrzędne_geograficzne  | NVARCHAR(50) | Nie      | -       | -             | -                           | Dokładna lokalizacja przystanku                                  |
| Kod_typu_przystanku       | NCHAR(3)     | Nie      | -       | -             | `Typy_przystanków.Kod_typu` | Kod identyfikujący typ przystanku (tramwajowy, autobusowy, itp.) |
| Czy_pętla                 | BIT          | Tak      | -       | -             | -                           | Czy przystanek jest pętlą                                        |

## Opis tabeli

Tablela zawiera informacje o przystankach i ich lokalizacjach.
