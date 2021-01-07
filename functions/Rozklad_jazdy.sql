GO
CREATE FUNCTION Rozklad_jazdy (@Id_k AS INT)
RETURNS TABLE
AS
RETURN
	SELECT K.ID_kierowcy,K.Imię,K.Nazwisko,K.Data_urodzenia,K.PESEL,Ku.Pierwszy_przystanek,Ku.Ostatni_przystanek,
	R.* FROM Kierowcy as K
	LEFT JOIN Kursy as Ku on K.ID_kierowcy = Ku.ID_kierowcy
	LEFT JOIN Rozkłady_jazdy as R on Ku.Nr_kursu = R.Nr_kursu
	WHERE K.ID_kierowcy = @Id_k
GO
