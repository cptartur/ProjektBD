USE [master]
GO
/****** Object:  Database [MPK]    Script Date: 05.02.2021 19:43:23 ******/
CREATE DATABASE [MPK]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MPK', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\MPK.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MPK_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\MPK_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [MPK] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MPK].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MPK] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MPK] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MPK] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MPK] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MPK] SET ARITHABORT OFF 
GO
ALTER DATABASE [MPK] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MPK] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MPK] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MPK] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MPK] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MPK] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MPK] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MPK] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MPK] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MPK] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MPK] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MPK] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MPK] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MPK] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MPK] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MPK] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MPK] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MPK] SET RECOVERY FULL 
GO
ALTER DATABASE [MPK] SET  MULTI_USER 
GO
ALTER DATABASE [MPK] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MPK] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MPK] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MPK] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MPK] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MPK] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'MPK', N'ON'
GO
ALTER DATABASE [MPK] SET QUERY_STORE = OFF
GO
USE [MPK]
GO
/****** Object:  UserDefinedTableType [dbo].[Przystanek_w_rozkładzie]    Script Date: 05.02.2021 19:43:23 ******/
CREATE TYPE [dbo].[Przystanek_w_rozkładzie] AS TABLE(
	[Nazwa_przystanku] [nvarchar](50) NULL,
	[Godzina_odjazdu] [time](0) NULL,
	[Numer_przystanku] [int] NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[Wygasające_przeglądy]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[Wygasające_przeglądy] (@Rok INT, @Miesiąc INT = 1, @Dzień INT = 1)
RETURNS @Wygasające_przeglądy TABLE
(
	ID_pojazdu INT PRIMARY KEY NOT NULL,
	Data_wygaśnięcia DATE NOT NULL
)
AS
BEGIN
	DECLARE @Data DATE
	SET @Data = CAST(CAST(@Miesiąc AS varchar) + '-' + CAST(@Dzień AS varchar) + '-' + CAST(@Rok AS varchar) AS date)
	
	INSERT INTO @Wygasające_przeglądy(ID_pojazdu, Data_wygaśnięcia)
	SELECT P.ID_pojazdu, P.Data_wygaśnięcia
	FROM Przeglądy AS P
	WHERE P.Data_wygaśnięcia < @Data
	RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[WygasającePrzeglądy]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[WygasającePrzeglądy] (@Rok INT, @Miesiąc INT = 1, @Dzień INT = 1)
RETURNS @Wygasające_przeglądy TABLE
(
	ID_pojazdu INT PRIMARY KEY NOT NULL,
	Data_wygaśnięcia DATE NOT NULL
)
AS
BEGIN
	DECLARE @Data DATE
	SET @Data = CAST(CAST(@Miesiąc AS varchar) + '-' + CAST(@Dzień AS varchar) + '-' + CAST(@Rok AS varchar) AS date)
	
	INSERT INTO @Wygasające_przeglądy(ID_pojazdu, Data_wygaśnięcia)
	SELECT P.ID_pojazdu, P.Data_wygaśnięcia
	FROM Przeglądy AS P
	WHERE P.Data_wygaśnięcia < @Data
	RETURN
END
GO
/****** Object:  Table [dbo].[Klienci]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Klienci](
	[ID_klienta] [int] IDENTITY(1,1) NOT NULL,
	[Imię] [nvarchar](50) NOT NULL,
	[Nazwisko] [nvarchar](50) NOT NULL,
	[PESEL] [bigint] NOT NULL,
	[Ulga] [nvarchar](50) NULL,
 CONSTRAINT [PK_Klienci] PRIMARY KEY CLUSTERED 
(
	[ID_klienta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bilety]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bilety](
	[ID_biletu] [bigint] IDENTITY(1,1) NOT NULL,
	[ID_klienta] [int] NOT NULL,
	[Rodzaj_biletu] [nvarchar](50) NOT NULL,
	[Cena] [money] NOT NULL,
	[Data_zakupu] [date] NOT NULL,
	[Data_wygaśnięcia] [date] NOT NULL,
	[ID_punktu_sprzedaży] [int] NULL,
 CONSTRAINT [PK_Bilety] PRIMARY KEY CLUSTERED 
(
	[ID_biletu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Historia_biletow_osoby]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[Historia_biletow_osoby] (@klient AS INT)
RETURNS TABLE
AS
RETURN
	SELECT ID_biletu,Rodzaj_biletu,Cena,Data_zakupu,Data_wygaśnięcia,ID_punktu_sprzedaży,
	K.ID_klienta,Imię,Nazwisko,PESEL,Ulga FROM Bilety as B
	JOIN Klienci as K on B.ID_klienta = K.ID_klienta
	WHERE K.ID_klienta = @klient
GO
/****** Object:  Table [dbo].[Kierowcy]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kierowcy](
	[ID_kierowcy] [int] IDENTITY(1,1) NOT NULL,
	[Imię] [nvarchar](50) NOT NULL,
	[Nazwisko] [nvarchar](50) NOT NULL,
	[Data_urodzenia] [date] NOT NULL,
	[PESEL] [bigint] NOT NULL,
 CONSTRAINT [PK_Kierowcy] PRIMARY KEY CLUSTERED 
(
	[ID_kierowcy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_Kierowcy] UNIQUE NONCLUSTERED 
(
	[PESEL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Czas_pracy]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Czas_pracy](
	[ID_kierowcy] [int] NOT NULL,
	[Rok] [int] NOT NULL,
	[Miesiąc] [int] NOT NULL,
	[Godziny_pracy] [int] NULL,
	[Nadgodziny] [int] NULL,
 CONSTRAINT [PK_Czas_pracy] PRIMARY KEY CLUSTERED 
(
	[ID_kierowcy] ASC,
	[Rok] ASC,
	[Miesiąc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Ranking_Kierowców]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[Ranking_Kierowców] as
SELECT Rok, Miesiąc, ROW_NUMBER() 
	OVER(PARTITION BY Rok,Miesiąc ORDER BY Godziny_pracy+Nadgodziny DESC) as Ranking_Miesiąca,
K.ID_kierowcy, Imię, Nazwisko, Data_urodzenia, PESEL, Godziny_pracy,Nadgodziny,Godziny_pracy+Nadgodziny AS Sumaryczna_Praca 
FROM Kierowcy AS K
JOIN Czas_pracy AS C 
	ON K.ID_kierowcy = C.ID_kierowcy
GO
/****** Object:  Table [dbo].[Pojazdy]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pojazdy](
	[ID_pojazdu] [int] NOT NULL,
	[Typ_pojazdu] [nvarchar](50) NOT NULL,
	[Producent] [nvarchar](50) NOT NULL,
	[Model] [nvarchar](50) NOT NULL,
	[Data_zakupu] [date] NOT NULL,
	[Numer_rejestracyjny] [nchar](10) NULL,
	[ID_zajezdni] [int] NULL,
 CONSTRAINT [PK_Pojazdy] PRIMARY KEY CLUSTERED 
(
	[ID_pojazdu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Pojazdy_od_producenta]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[Pojazdy_od_producenta]
AS
SELECT P.Producent, COUNT(*) AS Ilość
FROM Pojazdy AS P
GROUP BY P.Producent
GO
/****** Object:  Table [dbo].[Stawki_miesięczne]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stawki_miesięczne](
	[Rok] [int] NOT NULL,
	[Miesiąc] [int] NOT NULL,
	[Stawka_podstawowa] [money] NOT NULL,
	[Stawka_za_nadgodziny] [money] NOT NULL,
 CONSTRAINT [PK_Stawki_miesięczne] PRIMARY KEY CLUSTERED 
(
	[Rok] ASC,
	[Miesiąc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Wynagrodzenia]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[Wynagrodzenia]
AS
SELECT C.ID_kierowcy, C.Rok, C.Miesiąc,
	CAST((C.Godziny_pracy * S.Stawka_podstawowa + C.Nadgodziny * S.Stawka_za_nadgodziny) AS money) AS Wynagrodzenie
FROM Czas_pracy AS C
LEFT JOIN Stawki_miesięczne AS S
	ON (C.Rok = S.Rok) AND (C.Miesiąc = S.Miesiąc)
GO
/****** Object:  UserDefinedFunction [dbo].[Wynagrodzenie_pracownika]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[Wynagrodzenie_pracownika](@ID_pracownika INT, @Rok INT, @Miesiąc INT)
RETURNS TABLE
AS
RETURN
(
	SELECT ID_kierowcy AS ID_pracownika,  Wynagrodzenie AS Wynagrodzenie_w_miesiącu
	FROM Wynagrodzenia
	WHERE (ID_kierowcy = @ID_pracownika) AND
		(Rok = @Rok) AND (Miesiąc = @Miesiąc)
)
GO
/****** Object:  Table [dbo].[Linie]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Linie](
	[Numer_linii] [int] NOT NULL,
	[Typ_pojazdu] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Linie] PRIMARY KEY CLUSTERED 
(
	[Numer_linii] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rozkłady_jazdy]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rozkłady_jazdy](
	[Numer_linii] [int] NOT NULL,
	[Nazwa_przystanku] [nvarchar](50) NOT NULL,
	[Nr_kursu] [int] NOT NULL,
	[Godzina_odjazu] [time](0) NOT NULL,
 CONSTRAINT [PK_Rozkłady_jazdy] PRIMARY KEY CLUSTERED 
(
	[Numer_linii] ASC,
	[Nazwa_przystanku] ASC,
	[Nr_kursu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Trasa_linii_pojazdu]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Trasa_linii_pojazdu] (@Num_l AS INT)
RETURNS TABLE
AS
RETURN
	SELECT L.Numer_linii,Typ_pojazdu,Nr_kursu,Nazwa_przystanku, Godzina_odjazu FROM Linie as L
	LEFT JOIN Rozkłady_jazdy as R on L.Numer_linii = R.Numer_linii
	WHERE L.Numer_linii = @Num_l
GO
/****** Object:  Table [dbo].[Kursy]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kursy](
	[Nr_kursu] [int] NOT NULL,
	[Numer_linii] [int] NOT NULL,
	[ID_pojazdu] [int] NULL,
	[Pierwszy_przystanek] [nvarchar](50) NOT NULL,
	[Ostatni_przystanek] [nvarchar](50) NOT NULL,
	[ID_kierowcy] [int] NOT NULL,
 CONSTRAINT [PK_Kursy] PRIMARY KEY CLUSTERED 
(
	[Nr_kursu] ASC,
	[Numer_linii] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Rozklad_jazdy_kierowcy]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Rozklad_jazdy_kierowcy] (@Id_k AS INT)
RETURNS TABLE
AS
RETURN
	SELECT K.ID_kierowcy,K.Imię,K.Nazwisko,K.Data_urodzenia,K.PESEL,Ku.Pierwszy_przystanek,Ku.Ostatni_przystanek,
	R.* FROM Kierowcy as K
	LEFT JOIN Kursy as Ku on K.ID_kierowcy = Ku.ID_kierowcy
	LEFT JOIN Rozkłady_jazdy as R on Ku.Nr_kursu = R.Nr_kursu
	WHERE K.ID_kierowcy = @Id_k
GO
/****** Object:  Table [dbo].[Zajezdnie]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zajezdnie](
	[ID_zajezdni] [int] NOT NULL,
	[Nazwa] [nvarchar](50) NOT NULL,
	[Adres] [nvarchar](50) NOT NULL,
	[Pojemność_autobusów] [int] NULL,
	[Pojemność_tramwajów] [int] NULL,
	[Liczba_autobusów] [int] NULL,
	[Liczba_tramwajów] [int] NULL,
 CONSTRAINT [PK_Zajezdnie] PRIMARY KEY CLUSTERED 
(
	[ID_zajezdni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Widok_Zajezdni]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[Widok_Zajezdni] AS
SELECT Z.ID_zajezdni, Nazwa,Adres,Pojemność_autobusów,Pojemność_tramwajów,Liczba_autobusów,Liczba_tramwajów,
ID_pojazdu,Typ_pojazdu,Producent,Model,Data_zakupu,Numer_rejestracyjny FROM Zajezdnie as Z
LEFT JOIN Pojazdy as P on Z.ID_zajezdni = P.ID_zajezdni
GO
/****** Object:  Table [dbo].[Kontrolerzy]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kontrolerzy](
	[ID_kontrolera] [int] IDENTITY(1,1) NOT NULL,
	[Imie] [nvarchar](50) NOT NULL,
	[Nazwisko] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Kontrolerzy] PRIMARY KEY CLUSTERED 
(
	[ID_kontrolera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mandaty]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mandaty](
	[ID_mandatu] [int] NOT NULL,
	[Imię] [nvarchar](50) NOT NULL,
	[Nazwisko] [nvarchar](50) NOT NULL,
	[PESEL] [bigint] NOT NULL,
	[Adres] [nvarchar](150) NOT NULL,
	[Kwota] [money] NOT NULL,
	[ID_wystawiającego] [int] NULL,
	[ID_klienta] [int] NULL,
	[Data_wystawienia] [date] NOT NULL,
 CONSTRAINT [PK_Mandaty] PRIMARY KEY CLUSTERED 
(
	[ID_mandatu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Statystyki_mandatów_kontrolerów]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[Statystyki_mandatów_kontrolerów] AS
SELECT K.ID_kontrolera,K.Imie,K.Nazwisko, COUNT(Kwota) AS [Liczba danych mandatów], SUM(Kwota) AS [Suma zł za wszystkie mandaty dane przez kontrolera] 
FROM Kontrolerzy AS K
JOIN Mandaty AS M 
ON K.ID_kontrolera = M.ID_wystawiającego
GROUP BY K.ID_kontrolera, K.Imie, K.Nazwisko, M.Data_wystawienia
GO
/****** Object:  UserDefinedFunction [dbo].[Sprzedaż_w_punkcie]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[Sprzedaż_w_punkcie] (@ID_punktu INT)
RETURNS TABLE
AS
RETURN
(
	SELECT YEAR(B.Data_zakupu) AS Rok, MONTH(B.Data_zakupu) AS Miesiąc, SUM(B.Cena) AS Zysk
	FROM Bilety AS B
	GROUP BY YEAR(B.Data_zakupu), MONTH(B.Data_zakupu)
);
GO
/****** Object:  UserDefinedFunction [dbo].[Znajdź_trasę]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[Znajdź_trasę] 
(
	@Przystanek_początkowy NVARCHAR(50), 
	@Przystanek_docelowy NVARCHAR(50), 
	@Godzina_odjazdu TIME(0)
)
RETURNS TABLE
AS
RETURN
(
	SELECT TOP 5 Numer_linii, Godzina_odjazu
	FROM Rozkłady_jazdy R1
	WHERE (Nazwa_przystanku LIKE @Przystanek_początkowy) AND EXISTS 
	(
		SELECT *
		FROM Rozkłady_jazdy R2
		WHERE (Nazwa_przystanku LIKE @Przystanek_docelowy) AND (R1.Numer_linii = R2.Numer_linii) AND (R2.Godzina_odjazu >= R1.Godzina_odjazu)
	) AND Godzina_odjazu >= @Godzina_odjazdu
	ORDER BY Godzina_odjazu
);
GO
/****** Object:  Table [dbo].[Punkty_sprzedaży]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Punkty_sprzedaży](
	[ID_punktu] [int] IDENTITY(1,1) NOT NULL,
	[Nazwa_przystanku] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Punkty_sprzedaży] PRIMARY KEY CLUSTERED 
(
	[ID_punktu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Sprzedaż_biletów]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[Sprzedaż_biletów]
AS
SELECT YEAR(B.Data_zakupu) AS Rok, MONTH(B.Data_zakupu) AS Miesiąc, SUM(B.Cena) AS Suma_sprzedanych_biletów 
FROM Bilety AS B
INNER JOIN Punkty_sprzedaży AS P
	ON P.ID_punktu = B.ID_punktu_sprzedaży
GROUP BY YEAR(B.Data_zakupu), MONTH(B.Data_zakupu)
GO
/****** Object:  UserDefinedFunction [dbo].[Wynagrodzenie_w_danym_roku]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[Wynagrodzenie_w_danym_roku] (@rok INT)
RETURNS TABLE
AS
RETURN
(
	SELECT SUM(W.Pensja) AS Wynagrodzenie
	FROM Wynagrodzenia W
	WHERE W.Rok = @rok
);
GO
/****** Object:  Table [dbo].[Przeglądy]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Przeglądy](
	[ID_pojazdu] [int] NOT NULL,
	[Data_przeglądu] [date] NOT NULL,
	[Data_wygaśnięcia] [date] NOT NULL,
 CONSTRAINT [PK_Przeglądy] PRIMARY KEY CLUSTERED 
(
	[ID_pojazdu] ASC,
	[Data_przeglądu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Przystanki]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Przystanki](
	[Nazwa_przystanku] [nvarchar](50) NOT NULL,
	[Współrzędne_geograficzne] [nvarchar](50) NOT NULL,
	[Kod_typu_przystanku] [nchar](3) NOT NULL,
	[Czy_pętla] [bit] NULL,
 CONSTRAINT [PK_Przystanki] PRIMARY KEY CLUSTERED 
(
	[Nazwa_przystanku] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rodzaje_biletów]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rodzaje_biletów](
	[Rodzaj_biletu] [nvarchar](50) NOT NULL,
	[Cena_bazowa] [money] NOT NULL,
	[Okres_w_dniach] [int] NOT NULL,
 CONSTRAINT [PK_Rodzaje_biletów] PRIMARY KEY CLUSTERED 
(
	[Rodzaj_biletu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Typy_przystanków]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Typy_przystanków](
	[Typ] [nvarchar](50) NOT NULL,
	[Kod_typu] [nchar](3) NOT NULL,
 CONSTRAINT [PK_Typy_przystanków] PRIMARY KEY CLUSTERED 
(
	[Kod_typu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ulgi]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ulgi](
	[Rodzaj_ulgi] [nvarchar](50) NOT NULL,
	[Zniżka] [int] NULL,
 CONSTRAINT [PK_Ulgi] PRIMARY KEY CLUSTERED 
(
	[Rodzaj_ulgi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Bilety]  WITH CHECK ADD  CONSTRAINT [FK_Bilety_Klienci] FOREIGN KEY([ID_klienta])
REFERENCES [dbo].[Klienci] ([ID_klienta])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Bilety] CHECK CONSTRAINT [FK_Bilety_Klienci]
GO
ALTER TABLE [dbo].[Bilety]  WITH CHECK ADD  CONSTRAINT [FK_Bilety_Punkty_sprzedaży] FOREIGN KEY([ID_punktu_sprzedaży])
REFERENCES [dbo].[Punkty_sprzedaży] ([ID_punktu])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Bilety] CHECK CONSTRAINT [FK_Bilety_Punkty_sprzedaży]
GO
ALTER TABLE [dbo].[Bilety]  WITH CHECK ADD  CONSTRAINT [FK_Bilety_Rodzaje_biletów] FOREIGN KEY([Rodzaj_biletu])
REFERENCES [dbo].[Rodzaje_biletów] ([Rodzaj_biletu])
GO
ALTER TABLE [dbo].[Bilety] CHECK CONSTRAINT [FK_Bilety_Rodzaje_biletów]
GO
ALTER TABLE [dbo].[Czas_pracy]  WITH CHECK ADD  CONSTRAINT [FK_Czas_pracy_Kierowcy] FOREIGN KEY([ID_kierowcy])
REFERENCES [dbo].[Kierowcy] ([ID_kierowcy])
GO
ALTER TABLE [dbo].[Czas_pracy] CHECK CONSTRAINT [FK_Czas_pracy_Kierowcy]
GO
ALTER TABLE [dbo].[Klienci]  WITH CHECK ADD  CONSTRAINT [FK_Klienci_Ulgi] FOREIGN KEY([Ulga])
REFERENCES [dbo].[Ulgi] ([Rodzaj_ulgi])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Klienci] CHECK CONSTRAINT [FK_Klienci_Ulgi]
GO
ALTER TABLE [dbo].[Kursy]  WITH CHECK ADD  CONSTRAINT [FK_Kursy_Kierowcy] FOREIGN KEY([ID_kierowcy])
REFERENCES [dbo].[Kierowcy] ([ID_kierowcy])
GO
ALTER TABLE [dbo].[Kursy] CHECK CONSTRAINT [FK_Kursy_Kierowcy]
GO
ALTER TABLE [dbo].[Kursy]  WITH CHECK ADD  CONSTRAINT [FK_Kursy_Linie] FOREIGN KEY([Numer_linii])
REFERENCES [dbo].[Linie] ([Numer_linii])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Kursy] CHECK CONSTRAINT [FK_Kursy_Linie]
GO
ALTER TABLE [dbo].[Kursy]  WITH CHECK ADD  CONSTRAINT [FK_Kursy_Pojazdy] FOREIGN KEY([ID_pojazdu])
REFERENCES [dbo].[Pojazdy] ([ID_pojazdu])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Kursy] CHECK CONSTRAINT [FK_Kursy_Pojazdy]
GO
ALTER TABLE [dbo].[Kursy]  WITH CHECK ADD  CONSTRAINT [FK_Kursy_Przystanki] FOREIGN KEY([Pierwszy_przystanek])
REFERENCES [dbo].[Przystanki] ([Nazwa_przystanku])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Kursy] CHECK CONSTRAINT [FK_Kursy_Przystanki]
GO
ALTER TABLE [dbo].[Mandaty]  WITH CHECK ADD  CONSTRAINT [FK_Mandaty_Klienci] FOREIGN KEY([ID_klienta])
REFERENCES [dbo].[Klienci] ([ID_klienta])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Mandaty] CHECK CONSTRAINT [FK_Mandaty_Klienci]
GO
ALTER TABLE [dbo].[Mandaty]  WITH CHECK ADD  CONSTRAINT [FK_Mandaty_Kontrolerzy] FOREIGN KEY([ID_wystawiającego])
REFERENCES [dbo].[Kontrolerzy] ([ID_kontrolera])
GO
ALTER TABLE [dbo].[Mandaty] CHECK CONSTRAINT [FK_Mandaty_Kontrolerzy]
GO
ALTER TABLE [dbo].[Pojazdy]  WITH CHECK ADD  CONSTRAINT [FK_Pojazdy_Zajezdnie] FOREIGN KEY([ID_zajezdni])
REFERENCES [dbo].[Zajezdnie] ([ID_zajezdni])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Pojazdy] CHECK CONSTRAINT [FK_Pojazdy_Zajezdnie]
GO
ALTER TABLE [dbo].[Przeglądy]  WITH CHECK ADD  CONSTRAINT [FK_Przeglądy_Pojazdy] FOREIGN KEY([ID_pojazdu])
REFERENCES [dbo].[Pojazdy] ([ID_pojazdu])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Przeglądy] CHECK CONSTRAINT [FK_Przeglądy_Pojazdy]
GO
ALTER TABLE [dbo].[Przystanki]  WITH CHECK ADD  CONSTRAINT [FK_Przystanki_Typy_przystanków] FOREIGN KEY([Kod_typu_przystanku])
REFERENCES [dbo].[Typy_przystanków] ([Kod_typu])
GO
ALTER TABLE [dbo].[Przystanki] CHECK CONSTRAINT [FK_Przystanki_Typy_przystanków]
GO
ALTER TABLE [dbo].[Punkty_sprzedaży]  WITH CHECK ADD  CONSTRAINT [FK_Punkty_sprzedaży_Przystanki] FOREIGN KEY([Nazwa_przystanku])
REFERENCES [dbo].[Przystanki] ([Nazwa_przystanku])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Punkty_sprzedaży] CHECK CONSTRAINT [FK_Punkty_sprzedaży_Przystanki]
GO
ALTER TABLE [dbo].[Rozkłady_jazdy]  WITH CHECK ADD  CONSTRAINT [FK_Rozkłady_jazdy_Kursy] FOREIGN KEY([Nr_kursu], [Numer_linii])
REFERENCES [dbo].[Kursy] ([Nr_kursu], [Numer_linii])
GO
ALTER TABLE [dbo].[Rozkłady_jazdy] CHECK CONSTRAINT [FK_Rozkłady_jazdy_Kursy]
GO
ALTER TABLE [dbo].[Rozkłady_jazdy]  WITH CHECK ADD  CONSTRAINT [FK_Rozkłady_jazdy_Linie] FOREIGN KEY([Numer_linii])
REFERENCES [dbo].[Linie] ([Numer_linii])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Rozkłady_jazdy] CHECK CONSTRAINT [FK_Rozkłady_jazdy_Linie]
GO
ALTER TABLE [dbo].[Rozkłady_jazdy]  WITH CHECK ADD  CONSTRAINT [FK_Rozkłady_jazdy_Przystanki] FOREIGN KEY([Nazwa_przystanku])
REFERENCES [dbo].[Przystanki] ([Nazwa_przystanku])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Rozkłady_jazdy] CHECK CONSTRAINT [FK_Rozkłady_jazdy_Przystanki]
GO
ALTER TABLE [dbo].[Czas_pracy]  WITH CHECK ADD  CONSTRAINT [CK_Czas_pracy] CHECK  (([Miesiąc]<=(12) AND [Miesiąc]>=(1)))
GO
ALTER TABLE [dbo].[Czas_pracy] CHECK CONSTRAINT [CK_Czas_pracy]
GO
ALTER TABLE [dbo].[Kierowcy]  WITH CHECK ADD  CONSTRAINT [CK_Kierowcy] CHECK  (([PESEL]>=(10000000000.) AND [PESEL]<=(99999999999.)))
GO
ALTER TABLE [dbo].[Kierowcy] CHECK CONSTRAINT [CK_Kierowcy]
GO
ALTER TABLE [dbo].[Klienci]  WITH CHECK ADD  CONSTRAINT [CK_Klienci] CHECK  (([PESEL]>=(10000000000.) AND [PESEL]<=(99999999999.)))
GO
ALTER TABLE [dbo].[Klienci] CHECK CONSTRAINT [CK_Klienci]
GO
ALTER TABLE [dbo].[Linie]  WITH CHECK ADD  CONSTRAINT [CK_Numer_linii] CHECK  (([Typ_pojazdu] like 'tramwaj' AND ([Numer_linii]>=(0) AND [Numer_linii]<=(100)) OR [Typ_pojazdu] like 'autobus' AND ([Numer_linii]>=(100) AND [Numer_linii]<=(999))))
GO
ALTER TABLE [dbo].[Linie] CHECK CONSTRAINT [CK_Numer_linii]
GO
ALTER TABLE [dbo].[Mandaty]  WITH CHECK ADD  CONSTRAINT [CK_Mandaty] CHECK  (([PESEL]>=(10000000000.) AND [PESEL]<=(99999999999.)))
GO
ALTER TABLE [dbo].[Mandaty] CHECK CONSTRAINT [CK_Mandaty]
GO
ALTER TABLE [dbo].[Pojazdy]  WITH CHECK ADD  CONSTRAINT [CK_Pojazdy_1] CHECK  (([Typ_pojazdu]='autobus' OR [Typ_pojazdu]='tramwaj'))
GO
ALTER TABLE [dbo].[Pojazdy] CHECK CONSTRAINT [CK_Pojazdy_1]
GO
ALTER TABLE [dbo].[Przeglądy]  WITH CHECK ADD  CONSTRAINT [CK_Przeglądy] CHECK  (([Data_wygaśnięcia]>[Data_przeglądu]))
GO
ALTER TABLE [dbo].[Przeglądy] CHECK CONSTRAINT [CK_Przeglądy]
GO
ALTER TABLE [dbo].[Ulgi]  WITH CHECK ADD  CONSTRAINT [CK_Ulgi] CHECK  (([Zniżka]>=(0) AND [Zniżka]<=(100)))
GO
ALTER TABLE [dbo].[Ulgi] CHECK CONSTRAINT [CK_Ulgi]
GO
/****** Object:  StoredProcedure [dbo].[Dodaj_bilet]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[Dodaj_bilet]
	@Id_klienta INT,
	@Rodzaj_biletu nvarchar(50),
	@Data_zakupu date,
	@Id_punktu_sprzedaży INT
AS
	IF NOT EXISTS (
					SELECT * 
					FROM Punkty_sprzedaży
					WHERE ID_punktu = @Id_punktu_sprzedaży)
	BEGIN
		RAISERROR('Nie ma takiego punktu sprzedaży',16,1)
		RETURN;
	END
	ELSE IF NOT EXISTS (
					SELECT * 
					FROM Klienci
					WHERE ID_klienta = @Id_klienta)
	BEGIN
		RAISERROR('Nie ma takiego klienta',16,2)
		RETURN;
	END
	ELSE IF EXISTS (
					SELECT * FROM Bilety
					WHERE ID_klienta = @Id_klienta AND Data_wygaśnięcia>@Data_zakupu)
	BEGIN
		RAISERROR('Twój bilet jest już ważny',16,2)
		RETURN;
	END
	ELSE
	BEGIN
		INSERT INTO Bilety
		VALUES(@Id_klienta,@Rodzaj_biletu,-1,@Data_zakupu,@Data_zakupu,@Id_punktu_sprzedaży)
	END
GO
/****** Object:  StoredProcedure [dbo].[Dodaj_kurs]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[Dodaj_kurs]
	@Nr_kursu INT,
	@Nr_linii INT,
	@ID_pojazdu INT,
	@ID_kierowcy INT,
	@Rozkład [Przystanek_w_rozkładzie] READONLY
AS
	SET NOCOUNT ON
	IF NOT EXISTS (
		SELECT L.Numer_linii
		FROM Linie AS L
		WHERE L.Numer_linii = @Nr_linii
	)
	BEGIN
		RAISERROR ('Taka linia nie istnieje', 16, 1)
		RETURN;
	END

	IF EXISTS (
		SELECT K.Nr_kursu
		FROM Kursy AS K
		WHERE (K.Nr_kursu = @Nr_kursu) AND (K.Numer_linii = @Nr_linii)
	)
	BEGIN
		RAISERROR ('Kurs o podanym numerze już istnieje', 16, 2)
		RETURN;
	END

	IF EXISTS (
		SELECT *
		FROM @Rozkład AS L
		CROSS JOIN @Rozkład AS R
		WHERE (L.Numer_przystanku < R.Numer_przystanku) AND (L.Godzina_odjazdu > R.Godzina_odjazdu)
	)
	BEGIN
		RAISERROR ('Nieprawidłowa kolejność przystanków', 16, 3)
		RETURN;
	END

	IF NOT EXISTS (
		SELECT P.ID_pojazdu
		FROM Pojazdy AS P
		WHERE P.ID_pojazdu = @ID_pojazdu
	)
	BEGIN
		RAISERROR ('Pojazd o podanym ID nie istnieje', 16, 4)
		RETURN;
	END

	IF NOT EXISTS (
		SELECT K.ID_kierowcy
		FROM Kierowcy AS K
		WHERE K.ID_kierowcy = @ID_kierowcy
	)
	BEGIN
		RAISERROR ('Kierowca o podanym ID nie istnieje', 16, 5)
		RETURN;
	END

	IF EXISTS (
		SELECT R.Numer_przystanku
		FROM @Rozkład AS R
		LEFT JOIN Przystanki AS P
			ON P.Nazwa_przystanku = R.Nazwa_przystanku
		WHERE P.Nazwa_przystanku IS NULL
	)
	BEGIN
		RAISERROR ('Niektóre z podanych przystanków nie istnieją', 16, 6)
		RETURN;
	END

	BEGIN
		DECLARE @Pierwszy_przystanek NVARCHAR(50)
		DECLARE @Ostatni_przystanek NVARCHAR(50)
		SET @Pierwszy_przystanek = (
			SELECT TOP 1 Nazwa_przystanku
			FROM @Rozkład
			ORDER BY Numer_przystanku 
		)
		SET @Ostatni_przystanek = (
			SELECT TOP 1 Nazwa_przystanku
			FROM @Rozkład
			ORDER BY Numer_przystanku DESC
		)

		INSERT INTO Kursy
		VALUES (@Nr_kursu, @Nr_linii, @ID_pojazdu, @Pierwszy_przystanek, @Ostatni_przystanek, @ID_kierowcy)

		INSERT INTO Rozkłady_jazdy
		SELECT @Nr_linii, R.Nazwa_przystanku, @Nr_kursu, R.Godzina_odjazdu
		FROM @Rozkład AS R
	END
GO
/****** Object:  StoredProcedure [dbo].[Dodaj_linię]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[Dodaj_linię] 
	@Numer_lini INT, 
	@Typ_pojazdu NVARCHAR(50)
AS
	SET NOCOUNT ON
	IF EXISTS (
		SELECT L.Numer_linii
		FROM Linie AS L
		WHERE L.Numer_linii = @Numer_lini
	)
	BEGIN
		RAISERROR ('Linia o takim numerze już istnieje', 16, 1)
		RETURN;
	END

	IF (@Typ_pojazdu = 'autobus' AND (@Numer_lini BETWEEN 100 AND 999)) OR (@Typ_pojazdu = 'tramwaj' AND (@Numer_lini BETWEEN 1 AND 99))
	BEGIN
		INSERT INTO Linie
		VALUES (@Numer_lini, @Typ_pojazdu)
	END
	ELSE
		RAISERROR ('Niepoprawny numer linii', 16, 2)
		RETURN;
GO
/****** Object:  StoredProcedure [dbo].[Dodaj_mandat]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[Dodaj_mandat]	
	@Id_mandatu INT,
	@Imię nvarchar(50),
	@Nazwisko nvarchar(50),
	@PESEL BIGINT,
	@Adres nvarchar(150),
	@Kwota MONEY,
	@Id_kontrolera INT,
	@Data_wystawienia DATE
AS
	IF EXISTS (
		SELECT *
		FROM Mandaty
		WHERE ID_mandatu = @Id_mandatu)
	BEGIN
		RAISERROR('Mandat o takim ID już istnieje',16,1)
		RETURN;
	END
	ELSE IF NOT EXISTS (
		SELECT * 		
		FROM Kontrolerzy
		WHERE ID_kontrolera = @Id_kontrolera)
		AND @Id_kontrolera IS NOT NULL
	BEGIN
		RAISERROR('Próbujesz wystawić mandat na nieistniejącego kontrolera',16,2)
		RETURN;
	END
	ELSE
	BEGIN
		INSERT INTO Mandaty
		VALUES(@Id_mandatu,@Imię,@Nazwisko,@PESEL,@Adres,@Kwota,@Id_kontrolera,NULL,@Data_wystawienia)
	END
GO
/****** Object:  StoredProcedure [dbo].[Dodaj_pojazd]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[Dodaj_pojazd]
	@ID_pojazdu INT,
	@Typ_pojazdu NVARCHAR(50),
	@Producent NVARCHAR(50),
	@Model NVARCHAR(50),
	@Data_zakupu DATE,
	@Numer_rejestracyjny NCHAR(10) = NULL,
	@ID_zajezdni INT = 1
AS
	SET NOCOUNT ON
	IF @ID_zajezdni IS NOT NULL AND EXISTS (
			SELECT *
			FROM Zajezdnie AS Z
			WHERE Z.ID_zajezdni = @ID_zajezdni
		)
	BEGIN
		DECLARE @miejsce int = 0;
		IF @Typ_pojazdu = 'autobus'
			SELECT @miejsce  = (
				SELECT (Pojemność_autobusów - Liczba_autobusów) AS Miejsce
				FROM Zajezdnie AS Z
				WHERE Z.ID_zajezdni = @ID_zajezdni
			)
		ELSE
			SELECT @miejsce = (
				SELECT (Pojemność_tramwajów - Liczba_tramwajów) AS Miejsce
				FROM Zajezdnie AS Z
				WHERE Z.ID_zajezdni = @ID_zajezdni
			)
		IF @miejsce > 0
			BEGIN
				INSERT INTO Pojazdy
				VALUES
				(@ID_pojazdu, @Typ_pojazdu, @Producent, @Model, @Data_zakupu, @Numer_rejestracyjny, @ID_zajezdni);

				IF @Typ_pojazdu = 'autobus'
				BEGIN
					UPDATE Zajezdnie
					SET Liczba_autobusów = Liczba_autobusów + 1
					WHERE ID_zajezdni = @ID_zajezdni
				END
				ELSE
				BEGIN
					UPDATE Zajezdnie
					SET Liczba_tramwajów = Liczba_tramwajów + 1
					WHERE ID_zajezdni = @ID_zajezdni
				END
			END
		ELSE
			RAISERROR ('Wybrana zajezdnia jest pełna', 1, 1)
			RETURN
	END
GO
/****** Object:  StoredProcedure [dbo].[Przenieś_pojazd]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[Przenieś_pojazd]
	@ID_pojazdu INT,
	@ID_zajezdni_początkowej INT,
	@ID_zajezdni_docelowej INT
AS
	IF NOT EXISTS (
		SELECT P.ID_pojazdu
		FROM Pojazdy AS P
		WHERE (P.ID_pojazdu = @ID_pojazdu) AND (P.ID_zajezdni = @ID_zajezdni_początkowej)
	)
	BEGIN
		RAISERROR('Podanego pojazdu nie ma w zajezdni', 16, 1)
		RETURN
	END

	IF NOT EXISTS (
		SELECT Z.ID_zajezdni
		FROM Zajezdnie AS Z
		WHERE @ID_zajezdni_docelowej = Z.ID_zajezdni
	)
	BEGIN
		RAISERROR ('Zajezdnia początkowa nie istnieje', 16, 2)
		RETURN
	END

	IF NOT EXISTS (
		SELECT Z.ID_zajezdni
		FROM Zajezdnie AS Z
		WHERE @ID_zajezdni_docelowej = Z.ID_zajezdni
	)
	BEGIN
		RAISERROR ('Zajezdnia docelowa nie istnieje', 16, 3)
		RETURN
	END

	IF NOT EXISTS (
		SELECT P.ID_pojazdu
		FROM Pojazdy AS P
		WHERE @ID_pojazdu = P.ID_pojazdu
	)
	BEGIN
		RAISERROR ('Pojazd nie istnieje', 16, 4)
		RETURN
	END

	IF @ID_zajezdni_docelowej = @ID_zajezdni_początkowej
	BEGIN
		RAISERROR('Zajednia początkowa nie może być taka sama jak docelowa', 16, 5)
		RETURN
	END

	DECLARE @Typ_pojazdu VARCHAR(50)
	SET @Typ_pojazdu = (
		SELECT Typ_pojazdu
		FROM Pojazdy AS P
		WHERE @ID_pojazdu = P.ID_pojazdu
	)

	IF @Typ_pojazdu = 'autobus'
	BEGIN
		DECLARE @Pojemność_autobusów INT
		SET @Pojemność_autobusów = (
			SELECT (Z.Pojemność_autobusów - Z.Liczba_autobusów)
			FROM Zajezdnie AS Z
			WHERE Z.ID_zajezdni = @ID_zajezdni_docelowej
		)

		IF @Pojemność_autobusów <= 0
		BEGIN
			RAISERROR ('Zajezdnia docelowa jest pełna', 16, 6)
			RETURN
		END

		UPDATE Zajezdnie
		SET Liczba_autobusów = 
		(
			CASE
				WHEN ID_zajezdni = @ID_zajezdni_początkowej THEN (Liczba_autobusów - 1)
				WHEN ID_zajezdni = @ID_zajezdni_docelowej THEN (Liczba_autobusów + 1)
				ELSE Liczba_autobusów
			END
		)
		UPDATE Pojazdy
		SET ID_zajezdni = @ID_zajezdni_docelowej
		WHERE ID_pojazdu = @ID_pojazdu
	END
	ELSE
	BEGIN
		DECLARE @Pojemność_tramwajów INT
		SET @Pojemność_tramwajów = (
			SELECT (Z.Pojemność_tramwajów - Z.Pojemność_tramwajów)
			FROM Zajezdnie AS Z
			WHERE Z.ID_zajezdni = @ID_zajezdni_docelowej
		)

		IF @Pojemność_tramwajów <= 0
		BEGIN
			RAISERROR ('Zajezdnia docelowa jest pełna', 16, 6)
			RETURN
		END
		
		UPDATE Zajezdnie
		SET Liczba_tramwajów = 
		(
			CASE
				WHEN ID_zajezdni = @ID_zajezdni_początkowej THEN (Liczba_tramwajów - 1)
				WHEN ID_zajezdni = @ID_zajezdni_docelowej THEN (Liczba_tramwajów + 1)
				ELSE Liczba_autobusów
			END
		)
		UPDATE Pojazdy
		SET ID_zajezdni = @ID_zajezdni_docelowej
		WHERE ID_pojazdu = @ID_pojazdu
	END
GO
/****** Object:  StoredProcedure [dbo].[Usuń_pojazd]    Script Date: 05.02.2021 19:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[Usuń_pojazd] @ID_pojazdu INT
AS
	SET NOCOUNT ON
	IF NOT EXISTS (SELECT *
		FROM Pojazdy
		WHERE ID_pojazdu = @ID_pojazdu
	)
	BEGIN
		RAISERROR('Pojazd nie istnieje', 16, 1)
		RETURN
	END

	DECLARE @Typ_pojazdu VARCHAR(50)
	SELECT @Typ_pojazdu = (
		SELECT Typ_pojazdu
		FROM Pojazdy AS P
		WHERE P.ID_pojazdu = @ID_pojazdu
	)

	DECLARE @ID_zajezdni INT
	SET @ID_zajezdni = (
		SELECT ID_zajezdni
		FROM Pojazdy AS P
		WHERE P.ID_pojazdu = @ID_pojazdu
	)

	IF @Typ_pojazdu = 'autobus'
	BEGIN
		UPDATE Zajezdnie
		SET Liczba_autobusów = Liczba_autobusów - 1
		WHERE ID_zajezdni = @ID_zajezdni
	END
	ELSE
	BEGIN
		UPDATE Zajezdnie
		SET Liczba_tramwajów = Liczba_tramwajów - 1
		WHERE ID_zajezdni = @ID_zajezdni
	END

	BEGIN
		DELETE FROM Pojazdy
		WHERE ID_pojazdu = @ID_pojazdu
	END
GO
USE [master]
GO
ALTER DATABASE [MPK] SET  READ_WRITE 
GO
