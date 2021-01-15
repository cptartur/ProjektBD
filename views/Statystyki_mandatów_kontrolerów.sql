CREATE VIEW Statystyki_mandatów_kontrolerów AS
SELECT K.ID_kontrolera,K.Imie,K.Nazwisko, count(Kwota) as [Liczba danych mandatów], Sum(Kwota) as [Suma zł za wszystkie mandaty dane przez kontrolera] FROM Kontrolerzy as K
JOIN Mandaty as M on K.ID_kontrolera = M.ID_wystawiającego
group by K.ID_kontrolera,K.Imie,K.Nazwisko
