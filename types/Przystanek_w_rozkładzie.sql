DROP TYPE Przystanek_w_rozkładzie
CREATE TYPE Przystanek_w_rozkładzie AS TABLE
(
	Nazwa_przystanku NVARCHAR(50),
	Godzina_odjazdu TIME(0),
	Numer_przystanku INT
)
