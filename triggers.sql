IF OBJECT_ID('Tr_Godziny_pracy_INSTEAD_OF_INSERT', 'TR') IS NOT NULL DROP TRIGGER Tr_Godziny_pracy_INSTEAD_OF_INSERT

GO
CREATE TRIGGER Tr_Godziny_pracy_INSTEAD_OF_INSERT ON Godziny_pracy 
INSTEAD OF INSERT 
AS 
BEGIN 
	DECLARE @Id_pracownika INT 
	DECLARE @Data_rozpoczecia DATE
	DECLARE @Data_zakonczenia DATE
	DECLARE @ID_linii INT
	DECLARE @ID_pojazdu INT
	DECLARE @Text VARCHAR(256)

	DECLARE Id_wstawianego_pracownika CURSOR 
		FOR SELECT Id_pracownika FROM INSERTED
		FOR READ ONLY

	OPEN Id_wstawianego_pracownika
	FETCH Id_wstawianego_pracownika INTO @Id_pracownika

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @Data_rozpoczecia = (SELECT Data_rozpoczecia FROM INSERTED WHERE ID_pracownika = @Id_pracownika)
		SET @Data_zakonczenia = (SELECT Data_zakonczenia FROM INSERTED WHERE ID_pracownika = @Id_pracownika)
		IF(@Data_rozpoczecia >= @Data_zakonczenia)
		BEGIN
			SET @Text = FORMATMESSAGE('Data rozpoczecia jest poniejsza niz data zakonczenia dla pracownika %d', @Id_pracownika)
			PRINT @Text
			FETCH Id_wstawianego_pracownika INTO @Id_pracownika
			CONTINUE
		END
		IF(NOT EXISTS(SELECT * FROM Godziny_pracy WHERE ID_pracownika = @Id_pracownika AND DATEPART(DAY, Data_rozpoczecia) = DATEPART(DAY, @Data_rozpoczecia)))
		BEGIN
			SET @ID_linii = (SELECT TOP 1 ID_linii FROM INSERTED WHERE ID_pracownika = @Id_pracownika)
			SET @ID_pojazdu = (SELECT TOP 1 ID_pojazdu FROM INSERTED WHERE ID_pracownika = @Id_pracownika)
			IF(NOT EXISTS(SELECT * FROM INSERTED WHERE ID_pracownika = @Id_pracownika AND dbo.Sprawdz_uprawnienia(ID_pracownika, ID_pojazdu) = 0)) 
			BEGIN 
				INSERT INTO Godziny_pracy VALUES(
				@Id_pracownika,
				@Data_rozpoczecia,
				@Data_zakonczenia,
				@ID_linii,
				@ID_pojazdu
			)
			FETCH Id_wstawianego_pracownika INTO @Id_pracownika
			END	
		END
		ELSE 
		BEGIN
			SET @Text = FORMATMESSAGE('Pracownik %d juz ma przypisana zmiane tego dnia', @Id_pracownika)
			PRINT @Text
			FETCH Id_wstawianego_pracownika INTO @Id_pracownika
		END
	END
	CLOSE Id_wstawianego_pracownika
	DEALLOCATE Id_wstawianego_pracownika
END



IF OBJECT_ID('Tr_Linie_INSTEAD_OF_INSERT', 'TR') IS NOT NULL DROP TRIGGER Tr_Linie_INSTEAD_OF_INSERT

GO
CREATE TRIGGER Tr_Linie_INSTEAD_OF_INSERT ON Linie
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @Id INT
	DECLARE @Numer_linii INT
	DECLARE @Czy_tramwaj BIT
	DECLARE @Text VARCHAR(256)

	DECLARE Nr_wstawianej_linii CURSOR
		FOR SELECT Numer_linii FROM INSERTED
		FOR READ ONLY



	OPEN Nr_wstawianej_linii
	FETCH Nr_wstawianej_linii INTO @Numer_linii

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF(NOT EXISTS(SELECT * FROM Linie WHERE Numer_linii = @Numer_linii))
		BEGIN
			SET @Czy_tramwaj = (SELECT TOP 1 Czy_tramwaj FROM INSERTED WHERE Numer_linii = @Numer_linii)
			INSERT INTO Linie VALUES(
				@Numer_linii,
				@Czy_tramwaj
			)			
		END
		ELSE 
		BEGIN
			SET @Text = FORMATMESSAGE('Istnieje juz linia o numerze %d', @Numer_linii)
			PRINT @Text
			
		END

		FETCH	Nr_wstawianej_linii INTO @Numer_linii
	END

	CLOSE Nr_wstawianej_linii
	DEALLOCATE Nr_wstawianej_linii
END



IF OBJECT_ID('Tr_Przystanki_INSTEAD_OF_INSERT', 'TR') IS NOT NULL DROP TRIGGER Tr_Przystanki_INSTEAD_OF_INSERT
GO
CREATE TRIGGER Tr_Przystanki_INSTEAD_OF_INSERT ON Przystanki 
INSTEAD OF INSERT 
AS
BEGIN
	DECLARE @Id INT
	DECLARE @Nazwa_przystanku VARCHAR(100)

	DECLARE Id_wstawianego_przystanku CURSOR
		FOR SELECT ID FROM INSERTED
		FOR READ ONLY
	
	SELECT * FROM INSERTED

	OPEN Id_wstawianego_przystanku 
	FETCH Id_wstawianego_przystanku INTO @Id

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @Nazwa_przystanku = (SELECT Nazwa FROM INSERTED WHERE ID = @Id)

		IF (NOT EXISTS(SELECT * FROM Przystanki WHERE Nazwa = @Nazwa_przystanku))
		BEGIN
			INSERT INTO Przystanki VALUES(
				@Id,
				@Nazwa_przystanku
			)
		END
		ELSE 
		BEGIN
			DECLARE @Text VARCHAR(256)
			SET @Text = FORMATMESSAGE('Przystanek o nazwie %s juz istnieje', @Nazwa_przystanku)
		END
		FETCH Id_wstawianego_przystanku INTO @Id 
	END

	CLOSE Id_wstawianego_przystanku 
	DEALLOCATE Id_wstawianego_przystanku
	
END



IF OBJECT_ID('Tr_Pracownicy_INSTEAD_OF_DELETE', 'TR') IS NOT NULL DROP TRIGGER Tr_Pracownicy_INSTEAD_OF_DELETE

GO
CREATE TRIGGER Tr_Pracownicy_INSTEAD_OF_DELETE ON Pracownicy 
INSTEAD OF DELETE 
AS
BEGIN
	DECLARE @Id INT

	DECLARE Id_usuwanego_pracownika CURSOR
		FOR SELECT ID FROM DELETED 
		FOR READ ONLY 

	OPEN Id_usuwanego_pracownika 
	FETCH Id_usuwanego_pracownika INTO @Id 

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF(EXISTS(SELECT * FROM Motorniczy WHERE ID = @Id))
		BEGIN
			DELETE FROM Motorniczy
			SELECT * FROM Motorniczy WHERE ID = @Id

			DELETE FROM Pracownicy 
			SELECT * FROM DELETED WHERE ID = @Id
		END

		ELSE IF(EXISTS(SELECT * FROM Kierowcy_autobusow WHERE ID = @Id))
		BEGIN
			DELETE FROM Kierowcy_autobusow
			SELECT * FROM DELETED WHERE ID = @Id

			DELETE FROM Pracownicy
			SELECT * FROM DELETED WHERE ID = @Id
		END

		FETCH Id_usuwanego_pracownika INTO @Id 

	END

	CLOSE Id_usuwanego_pracownika
	DEALLOCATE Id_usuwanego_pracownika
END


IF OBJECT_ID('Tr_Pojazdy_INSTEAD_OF_DELETE', 'TR') IS NOT NULL DROP TRIGGER Tr_Pojazdy_INSTEAD_OF_DELETE

GO
CREATE TRIGGER Tr_Pojazdy_INSTEAD_OF_DELETE ON Pojazdy 
INSTEAD OF DELETE 
AS
BEGIN
	DECLARE @Id INT 

	DECLARE Id_usuwanego_pojazdu CURSOR 
		FOR SELECT ID FROM DELETED
		FOR READ ONLY

	OPEN Id_usuwanego_pojazdu 
	FETCH Id_usuwanego_pojazdu INTO @Id

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF(EXISTS(SELECT * FROM Tramwaje WHERE ID = @Id))
		BEGIN
			DELETE FROM Tramwaje 
			SELECT * FROM DELETED WHERE ID = @Id

			DELETE FROM Pojazdy 
			SELECT * FROM DELETED WHERE ID = @Id
		END
		ELSE IF (EXISTS(SELECT * FROM Autobusy WHERE ID = @Id))
		BEGIN
			DELETE FROM Autobusy
			SELECT * FROM DELETED WHERE ID = @Id

			DELETE FROM Pojazdy
			SELECT * FROM DELETED WHERE ID = @Id
			
		END
	END

	CLOSE Id_usuwanego_pojazdu
	DEALLOCATE Id_usuwanego_pojazdu
END
	