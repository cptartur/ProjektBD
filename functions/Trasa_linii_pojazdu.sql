GO
CREATE FUNCTION Trasa_linii_pojazdu (@Num_l AS INT)
RETURNS TABLE
AS
RETURN
	SELECT L.Numer_linii,Typ_pojazdu,Nr_kursu,Nazwa_przystanku, Godzina_odjazu FROM Linie as L
	LEFT JOIN Rozkłady_jazdy as R on L.Numer_linii = R.Numer_linii
	WHERE L.Numer_linii = @Num_l
GO
