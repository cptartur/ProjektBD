CREATE VIEW Ranking_Kierowców as
SELECT Rok, Miesiąc, ROW_NUMBER() OVER(Partition by Rok,Miesiąc order by Godziny_pracy+Nadgodziny DESC) as Ranking_Miesiąca,
K.ID_kierowcy, Imię, Nazwisko, Data_urodzenia, PESEL, Godziny_pracy,Nadgodziny,Godziny_pracy+Nadgodziny as Sumaryczna_Praca FROM Kierowcy as K
JOIN Czas_pracy as C on K.ID_kierowcy = C.ID_kierowcy
