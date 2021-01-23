CREATE OR ALTER VIEW Statystyki_mandatów_kontrolerów AS
SELECT K.ID_kontrolera,K.Imie,K.Nazwisko, COUNT(Kwota) AS [Liczba danych mandatów], SUM(Kwota) AS [Suma zł za wszystkie mandaty dane przez kontrolera] 
FROM Kontrolerzy AS K
JOIN Mandaty AS M 
ON K.ID_kontrolera = M.ID_wystawiającego
GROUP BY K.ID_kontrolera,K.Imie,K.Nazwisko, M.Data_wystawienia
