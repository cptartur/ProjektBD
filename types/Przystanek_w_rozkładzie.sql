DROP TYPE Przystanek_w_rozk�adzie
CREATE TYPE Przystanek_w_rozk�adzie AS TABLE
(
	Nazwa_przystanku NVARCHAR(50),
	Godzina_odjazdu TIME(0),
	Numer_przystanku INT
)
