DROP TRIGGER IF EXISTS ajoutUtilisateur;
Delimiter //
CREATE TRIGGER
	ajoutUtilisateur
BEFORE INSERT ON
	utilisateur
FOR EACH ROW
BEGIN
	DECLARE nbU, nbE int;
	
	SELECT COUNT(*) INTO nbU FROM compte WHERE idU = new.idU;
	IF nbU = 0
	THEN
		INSERT INTO compte
			(cpU, phoneU, mailU, passU, nomU)
		VALUES
			(new.cpU, new.phoneU, new.mailu, new.mailU, new.nomU);
	END IF;
	
	SELECT COUNT(*) INTO nbE FROM entreprise WHERE idU = new.idU;
	IF nbE > 0
		THEN
			SIGNAL SQLSTATE '45000'
			SET Message_text = 'Ce compte apparatient à une entreprise.';
	END IF;
END //
Delimiter ;