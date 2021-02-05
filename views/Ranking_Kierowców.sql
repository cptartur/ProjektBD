CREATE OR ALTER VIEW Ranking_Kierowców as
SELECT Rok, Miesiąc, ROW_NUMBER() 
	OVER(PARTITION BY Rok,Miesiąc ORDER BY Godziny_pracy+Nadgodziny DESC) as Ranking_Miesiąca,
K.ID_kierowcy, Imię, Nazwisko, Data_urodzenia, PESEL, Godziny_pracy,Nadgodziny,Godziny_pracy+Nadgodziny AS Sumaryczna_Praca 
FROM Kierowcy AS K
JOIN Czas_pracy AS C 
	ON K.ID_kierowcy = C.ID_kierowcy
