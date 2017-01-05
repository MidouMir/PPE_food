DROP TRIGGER IF EXISTS ajoutEntreprise;
Delimiter //
CREATE TRIGGER
	ajoutEntreprise
BEFORE INSERT ON
	entreprise
FOR EACH ROW
BEGIN
	DECLARE nbE, nbU int;
	
	SELECT COUNT(*) INTO nbE FROM compte WHERE idU = new.idU;
	IF nbE = 0
	THEN
		INSERT INTO compte
			(cpU, phoneU, mailU, passU, nomU)
		VALUES
			(new.cpU, new.phoneU, new.mailu, new.mailU, new.nomU);
	END IF;
	
	SELECT COUNT(*) INTO nbU FROM utilisateur WHERE idU = new.idU;
	IF nbU > 0
		THEN
			SIGNAL SQLSTATE '45000'
			SET Message_text = 'Ce compte apparatient à un utilisateur.';
	END IF;
END //
Delimiter ;