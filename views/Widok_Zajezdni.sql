CREATE VIEW Widok_Zajezdni AS
SELECT Z.ID_zajezdni, Nazwa,Adres,Pojemność_autobusów,Pojemność_tramwajów,Liczba_autobusów,Liczba_tramwajów,
ID_pojazdu,Typ_pojazdu,Producent,Model,Data_zakupu,Numer_rejestracyjny FROM Zajezdnie as Z
LEFT JOIN Pojazdy as P on Z.ID_zajezdni = P.ID_zajezdni
