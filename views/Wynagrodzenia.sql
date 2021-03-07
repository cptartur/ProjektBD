CREATE OR ALTER VIEW Wynagrodzenia
AS
SELECT C.ID_kierowcy, C.Rok, C.Miesi�c,
	CAST((C.Godziny_pracy * S.Stawka_podstawowa + C.Nadgodziny * S.Stawka_za_nadgodziny) AS money) AS Wynagrodzenie
FROM Czas_pracy AS C
LEFT JOIN Stawki_miesi�czne AS S
	ON (C.Rok = S.Rok) AND (C.Miesi�c = S.Miesi�c)