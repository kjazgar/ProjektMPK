USE ProjektMPK;

IF OBJECT_ID('Przystanki', 'U') IS NOT NULL DROP TABLE Przystanki
CREATE TABLE Przystanki(
	ID INT IDENTITY, 
	Nazwa VARCHAR(100),
	PRIMARY KEY(ID)
)

IF OBJECT_ID('Linie', 'U') IS NOT NULL DROP TABLE Linie
CREATE TABLE Linie(
	ID INT IDENTITY, 
	Numer_linii INT NOT NULL UNIQUE,
	Czy_tramwaj BIT,
	PRIMARY KEY(ID)
)

IF OBJECT_ID('Relacje', 'U') IS NOT NULL DROP TABLE Relacje
CREATE TABLE Relacje(
	ID INT IDENTITY,
	ID_linii INT,
	ID_przystanku_poczatkowego INT,
	ID_przystanku_koncowego INT,
	PRIMARY KEY(ID),
	FOREIGN KEY (ID_linii) REFERENCES Linie(ID) ON DELETE CASCADE,
	FOREIGN KEY(ID_przystanku_poczatkowego) REFERENCES Przystanki(ID),
	FOREIGN KEY(ID_przystanku_koncowego) REFERENCES Przystanki(ID)
)

IF OBJECT_ID('Opis_trasy', 'U') IS NOT NULL DROP TABLE Opis_trasy
CREATE TABLE Opis_trasy(
	ID INT IDENTITY, 
	ID_relacji INT,
	ID_przystanku INT,
	ID_przystanku_poprzedniego INT,
	ID_przystanku_nastepnego INT,
	PRIMARY KEY(ID),
	FOREIGN KEY(ID_relacji) REFERENCES Relacje(ID) ON DELETE CASCADE,
	FOREIGN KEY(ID_przystanku) REFERENCES Przystanki(ID) ON DELETE CASCADE
)

IF OBJECT_ID('Godziny_odjazdow', 'U') IS NOT NULL DROP TABLE Godziny_odjazdow
CREATE TABLE Godziny_odjazdow(
	ID INT IDENTITY, 
	ID_opis_trasy INT,
	Godzina TIME,
	Rodzaj_dnia VARCHAR(50),
	PRIMARY KEY(ID),
	FOREIGN KEY(ID_opis_trasy) REFERENCES Opis_trasy(ID) ON DELETE CASCADE
)

IF OBJECT_ID('Poziomy_uprawnien', 'U') IS NOT NULL DROP TABLE Poziomy_uprawnien
CREATE TABLE Poziomy_uprawnien(
	ID INT IDENTITY,
	nazwa VARCHAR(10),
	PRIMARY KEY(ID)
)

IF OBJECT_ID('Pracownicy', 'U') IS NOT NULL DROP TABLE Pracownicy
CREATE TABLE Pracownicy(
	ID INT IDENTITY, 
	Imie VARCHAR(50),
	Nazwisko VARCHAR(50),
	Plec VARCHAR(1)
	PRIMARY KEY(ID)
)

IF OBJECT_ID('Motorniczy', 'U') IS NOT NULL DROP TABLE Motorniczy
CREATE TABLE Motorniczy(
	ID INT,
	Poziom_uprawnien INT,
	PRIMARY KEY(ID), 
	FOREIGN KEY(ID) REFERENCES Pracownicy(ID) ON DELETE CASCADE,
	FOREIGN KEY(Poziom_uprawnien) REFERENCES Poziomy_uprawnien(ID)
)

IF OBJECT_ID('Kierowcy_autobusow', 'U') IS NOT NULL DROP TABLE Kierowcy_autobusow
CREATE TABLE Kierowcy_autobusow(
	ID INT,
	Uprawnienia_do_autobusu_elektrycznego BIT,
	PRIMARY KEY(ID),
	FOREIGN KEY(ID) REFERENCES Pracownicy(ID) ON DELETE CASCADE
)

IF OBJECT_ID('Pojazdy', 'U') IS NOT NULL DROP TABLE Pojazdy
CREATE TABLE Pojazdy(
	ID INT IDENTITY, 
	Nazwa_pojazdu VARCHAR(50),
	PRIMARY KEY(ID)
)

IF OBJECT_ID('Tramwaje', 'U') IS NOT NULL DROP TABLE Tramwaje
CREATE TABLE Tramwaje(
	ID INT, 
	Wymagane_uprawnienia INT,
	PRIMARY KEY(ID),
	FOREIGN KEY(ID) REFERENCES Pojazdy(ID) ON DELETE CASCADE,
	FOREIGN KEY(Wymagane_uprawnienia) REFERENCES Poziomy_uprawnien
)

IF OBJECT_ID('Autobusy', 'U') IS NOT NULL DROP TABLE Autobusy
CREATE TABLE Autobusy(
	ID INT,
	Czy_elektryczny BIT,
	PRIMARY KEY(ID),
	FOREIGN KEY(ID) REFERENCES Pojazdy(ID) ON DELETE CASCADE
)

IF OBJECT_ID('Godziny_pracy', 'U') IS NOT NULL DROP TABLE Godziny_pracy
CREATE TABLE Godziny_pracy(
	ID INT IDENTITY,
	ID_pracownika INT,
	Data_rozpoczecia DATE,
	Data_zakonczenia DATE,
	ID_linii INT,
	ID_pojazdu INT,
	PRIMARY KEY(ID),
	FOREIGN KEY(ID_pracownika) REFERENCES Pracownicy(ID) ON DELETE CASCADE,
	FOREIGN KEY(ID_linii) REFERENCES Linie(ID),
	FOREIGN KEY(ID_pojazdu) REFERENCES Pojazdy(ID),
	--CHECK (Data_rozpoczecia < Data_zakonczenia)
)
