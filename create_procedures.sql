IF OBJECT_ID('Wstaw_kierowce', 'P') IS NOT NULL DROP PROCEDURE Wstaw_kierowce

GO
CREATE PROCEDURE Wstaw_kierowce(
	@Imie VARCHAR(50), 
	@Nazwisko VARCHAR(50), 
	@Plec VARCHAR(1), 
	@Uprawnienia_do_autobusu_elektrycznego BIT
) AS 
BEGIN
	INSERT INTO Pracownicy VALUES(
		@Imie, @Nazwisko, @Plec
	)
	DECLARE @Id INT
	SET @Id = (SELECT TOP 1 ID FROM Pracownicy WHERE Imie = @Imie AND Nazwisko = @Nazwisko AND Plec = @Plec ORDER BY ID DESC)
	INSERT INTO Kierowcy_autobusow VALUES(
		@Id, @Uprawnienia_do_autobusu_elektrycznego
	)
END



IF OBJECT_ID('Wstaw_motorniczego', 'P') IS NOT NULL DROP PROCEDURE Wstaw_motorniczego
GO
CREATE PROCEDURE Wstaw_motorniczego(
	@Imie VARCHAR(50), 
	@Nazwisko VARCHAR(50), 
	@Plec VARCHAR(1), 
	@Poziom_uprawnien INT
) AS
BEGIN
	INSERT INTO Pracownicy VALUES(
		@Imie, @Nazwisko, @Plec
	)
	DECLARE @Id INT 
	SET @Id = (SELECT TOP 1 ID FROM Pracownicy WHERE Imie = @Imie AND Nazwisko = @Nazwisko AND Plec = @Plec ORDER BY ID DESC)
	INSERT INTO Motorniczy VALUES(
		@Id, @Poziom_uprawnien
	)
END


IF OBJECT_ID('Wstaw_tramwaj', 'P') IS NOT NULL DROP PROCEDURE Wstaw_tramwaj

GO
CREATE PROCEDURE Wstaw_tramwaj(
	@Nazwa_pojazdu VARCHAR(50),
	@Wymagane_uprawnienia INT
) AS 
BEGIN 
	INSERT INTO Pojazdy VALUES(
		@Nazwa_pojazdu
	)

	DECLARE @Id INT 
	SET @Id = (SELECT TOP 1 ID FROM Pojazdy WHERE Nazwa_pojazdu = @Nazwa_pojazdu)
	INSERT INTO Tramwaje VALUES(
		@Id,
		@Wymagane_uprawnienia
	)
END


IF OBJECT_ID('Wstaw_autobus', 'P') IS NOT NULL DROP PROCEDURE Wstaw_autobus

GO
CREATE PROCEDURE Wstaw_autobus(
	@Nazwa_pojazdu VARCHAR(50),
	@Czy_elektryczny BIT
) AS
BEGIN
	INSERT INTO Pojazdy VALUES(
		@Nazwa_pojazdu
	)


	DECLARE @Id INT
	SET @Id = (SELECT TOP 1 ID FROM Pojazdy WHERE Nazwa_pojazdu = @Nazwa_pojazdu)

	INSERT INTO Autobusy VALUES(
		@Id,
		@Czy_elektryczny
	)
END

