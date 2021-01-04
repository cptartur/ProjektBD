CREATE OR ALTER VIEW Wynagrodzenia
AS
SELECT C.ID_kierowcy, K.Imiê, C.Rok, C.Miesi¹c, K.Nazwisko, (
	CAST((C.Godziny_pracy * 10 + C.Nadgodziny * 17) AS money)
) AS Pensja
FROM Czas_pracy C
INNER JOIN Kierowcy K
	ON K.ID_kierowcy = C.ID_kierowcy