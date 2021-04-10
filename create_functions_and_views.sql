IF OBJECT_ID('Pobierz_trase_relacji', 'TF') IS NOT NULL DROP FUNCTION Pobierz_trase_relacji
IF TYPE_ID('Trasa') IS NOT NULL DROP TYPE Trasa

CREATE TYPE Trasa AS TABLE(
	id_przystanku INT,
	przystanek VARCHAR(100)
)

GO

CREATE FUNCTION Pobierz_trase_relacji(
	@id_relacji INT) RETURNS  @Trasa TABLE(
	id_przystanku INT, przystanek VARCHAR(100)
) AS BEGIN 
	DECLARE @start INT
	DECLARE @stop INT
	SET @start = (SELECT ID_przystanku_poczatkowego FROM Relacje WHERE ID = @id_relacji)
	SET @stop = (SELECT ID_przystanku_koncowego FROM Relacje WHERE ID = @id_relacji)
	DECLARE @iterator INT 
	DECLARE @next INT
	SET @iterator = @start

	WHILE (@iterator <> @stop) BEGIN
		DECLARE @nazwa_przystanku VARCHAR(100)
		SET @nazwa_przystanku = (SELECT Nazwa FROM Przystanki WHERE ID = @iterator)

		INSERT INTO @Trasa 
		VALUES (@iterator, @nazwa_przystanku)

		
		SET @next = (SELECT ID_przystanku_nastepnego FROM Opis_trasy WHERE ID_relacji = @id_relacji AND ID_przystanku = @iterator)
		SET @iterator = @next

	END

	RETURN

END

GO

IF OBJECT_ID('Sprawdz_uprawnienia','FN') IS NOT NULL DROP FUNCTION Sprawdz_uprawnienia

GO
CREATE FUNCTION Sprawdz_uprawnienia(
	@id_pracownika INT, 
	@id_pojazdu INT
) RETURNS BIT AS BEGIN 
--	SET NOCOUNT ON 
	IF (EXISTS (SELECT * FROM Autobusy WHERE ID = @id_pojazdu)) BEGIN 
		IF (NOT EXISTS(SELECT * FROM Kierowcy_autobusow WHERE ID = @id_pracownika)) BEGIN
			RETURN 0
		END
		DECLARE @czy_elektryczny BIT 
		SET @czy_elektryczny = (SELECT Czy_elektryczny FROM Autobusy WHERE ID = @id_pojazdu)

		IF (@czy_elektryczny = 0) BEGIN
			RETURN 1
		END

		DECLARE @uprawnienia_do_ele BIT
		SET @uprawnienia_do_ele = (SELECT Uprawnienia_do_autobusu_elektrycznego FROM Kierowcy_autobusow WHERE ID = @id_pracownika)
		
		RETURN @uprawnienia_do_ele
	END
	ELSE 
	BEGIN
		IF (NOT EXISTS(SELECT * FROM Motorniczy WHERE ID = @id_pojazdu)) BEGIN
			RETURN 0
		END

		DECLARE @wymagane_uprawnienia INT 
		DECLARE @posiadane_uprawnienia INT 
		SET @wymagane_uprawnienia = (SELECT Wymagane_uprawnienia FROM Tramwaje WHERE ID = @id_pojazdu)
		SET @posiadane_uprawnienia = (SELECT Poziom_uprawnien FROM Motorniczy WHERE ID = @id_pracownika)

		IF (@posiadane_uprawnienia >= @wymagane_uprawnienia) BEGIN
			RETURN 1
		END
	END

	RETURN 0
END

GO


