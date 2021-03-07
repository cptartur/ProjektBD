CREATE OR ALTER VIEW Wynagrodzenia
AS
SELECT C.ID_kierowcy, C.Rok, C.Miesi¹c,
	CAST((C.Godziny_pracy * S.Stawka_podstawowa + C.Nadgodziny * S.Stawka_za_nadgodziny) AS money) AS Wynagrodzenie
FROM Czas_pracy AS C
LEFT JOIN Stawki_miesiêczne AS S
	ON (C.Rok = S.Rok) AND (C.Miesi¹c = S.Miesi¹c)