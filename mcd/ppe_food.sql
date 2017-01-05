#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: compte
#------------------------------------------------------------

CREATE TABLE compte(
        idU    Int NOT NULL ,
        cpU    Int NOT NULL ,
        phoneU Float NOT NULL ,
        mailU  Varchar (35) NOT NULL ,
        passU  Varchar (25) NOT NULL ,
        nomU   Varchar (25) NOT NULL ,
        PRIMARY KEY (idU )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: commande
#------------------------------------------------------------

CREATE TABLE commande(
        idC   Int NOT NULL ,
        etat  Varchar (3) NOT NULL ,
        dateC Date NOT NULL ,
        idB   Int NOT NULL ,
        idU   Int NOT NULL ,
        idF   Int NOT NULL ,
        PRIMARY KEY (idC )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: produitFini
#------------------------------------------------------------

CREATE TABLE produitFini(
        idP           Int NOT NULL ,
        nomP          Varchar (25) NOT NULL ,
        prixP         Float NOT NULL ,
        dispoP        Varchar (3) NOT NULL ,
        photoP        Varchar (50) NOT NULL ,
        quantiteStock Int NOT NULL ,
        idCat         Int NOT NULL ,
        PRIMARY KEY (idP )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: boutique
#------------------------------------------------------------

CREATE TABLE boutique(
        idB      Int NOT NULL ,
        nomB     Varchar (25) NOT NULL ,
        descB    Mediumtext NOT NULL ,
        adresseB Varchar (50) NOT NULL ,
        villeB   Char (5) NOT NULL ,
        cpB      Char (5) NOT NULL ,
        PRIMARY KEY (idB )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: facture
#------------------------------------------------------------

CREATE TABLE facture(
        idF     Int NOT NULL ,
        dateF   Datetime NOT NULL ,
        prixF   Float NOT NULL ,
        tauxTVA Float NOT NULL ,
        idC     Int NOT NULL ,
        idU     Int NOT NULL ,
        idR     Int NOT NULL ,
        PRIMARY KEY (idF )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: typeReglement
#------------------------------------------------------------

CREATE TABLE typeReglement(
        idR     Int NOT NULL ,
        libelle Varchar (25) NOT NULL ,
        PRIMARY KEY (idR )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: matiere
#------------------------------------------------------------

CREATE TABLE matiere(
        idM              Int NOT NULL ,
        nomM             Varchar (25) NOT NULL ,
        quantiteInitiale Float NOT NULL ,
        origineM         Varchar (50) NOT NULL ,
        PRIMARY KEY (idM )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: utilisateur
#------------------------------------------------------------

CREATE TABLE utilisateur(
        prenomU Varchar (25) NOT NULL ,
        idU     Int NOT NULL ,
        PRIMARY KEY (idU )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: entreprise
#------------------------------------------------------------

CREATE TABLE entreprise(
        siret              Varchar (25) NOT NULL ,
        commentaires       Mediumtext NOT NULL ,
        adresseFacturation Mediumtext ,
        idU                Int NOT NULL ,
        PRIMARY KEY (idU )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: categorie
#------------------------------------------------------------

CREATE TABLE categorie(
        idCat      Int NOT NULL ,
        libelleCat Varchar (25) NOT NULL ,
        prixMin    Float NOT NULL ,
        prixMax    Float NOT NULL ,
        PRIMARY KEY (idCat )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: reduction
#------------------------------------------------------------

CREATE TABLE reduction(
        idR     Int NOT NULL ,
        libelle Varchar (25) NOT NULL ,
        taux    Float NOT NULL ,
        PRIMARY KEY (idR )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: photoProduit
#------------------------------------------------------------

CREATE TABLE photoProduit(
        idPhoto   Int NOT NULL ,
        urlPhoto  Varchar (100) NOT NULL ,
        descPhoto Mediumtext NOT NULL ,
        tailleMax Int NOT NULL ,
        idP       Int NOT NULL ,
        PRIMARY KEY (idPhoto )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: ligneCommande
#------------------------------------------------------------

CREATE TABLE ligneCommande(
        quantiteC Int NOT NULL ,
        idC       Int NOT NULL ,
        idP       Int NOT NULL ,
        PRIMARY KEY (idC ,idP )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: preparer
#------------------------------------------------------------

CREATE TABLE preparer(
        quantiteUtilisee Float NOT NULL ,
        idP              Int NOT NULL ,
        idM              Int NOT NULL ,
        PRIMARY KEY (idP ,idM )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: beneficier
#------------------------------------------------------------

CREATE TABLE beneficier(
        idR Int NOT NULL ,
        idU Int NOT NULL ,
        PRIMARY KEY (idR ,idU )
)ENGINE=InnoDB;

ALTER TABLE commande ADD CONSTRAINT FK_commande_idB FOREIGN KEY (idB) REFERENCES boutique(idB);
ALTER TABLE commande ADD CONSTRAINT FK_commande_idU FOREIGN KEY (idU) REFERENCES compte(idU);
ALTER TABLE commande ADD CONSTRAINT FK_commande_idF FOREIGN KEY (idF) REFERENCES facture(idF);
ALTER TABLE produitFini ADD CONSTRAINT FK_produitFini_idCat FOREIGN KEY (idCat) REFERENCES categorie(idCat);
ALTER TABLE facture ADD CONSTRAINT FK_facture_idC FOREIGN KEY (idC) REFERENCES commande(idC);
ALTER TABLE facture ADD CONSTRAINT FK_facture_idU FOREIGN KEY (idU) REFERENCES compte(idU);
ALTER TABLE facture ADD CONSTRAINT FK_facture_idR FOREIGN KEY (idR) REFERENCES typeReglement(idR);
ALTER TABLE utilisateur ADD CONSTRAINT FK_utilisateur_idU FOREIGN KEY (idU) REFERENCES compte(idU);
ALTER TABLE entreprise ADD CONSTRAINT FK_entreprise_idU FOREIGN KEY (idU) REFERENCES compte(idU);
ALTER TABLE photoProduit ADD CONSTRAINT FK_photoProduit_idP FOREIGN KEY (idP) REFERENCES produitFini(idP);
ALTER TABLE ligneCommande ADD CONSTRAINT FK_ligneCommande_idC FOREIGN KEY (idC) REFERENCES commande(idC);
ALTER TABLE ligneCommande ADD CONSTRAINT FK_ligneCommande_idP FOREIGN KEY (idP) REFERENCES produitFini(idP);
ALTER TABLE preparer ADD CONSTRAINT FK_preparer_idP FOREIGN KEY (idP) REFERENCES produitFini(idP);
ALTER TABLE preparer ADD CONSTRAINT FK_preparer_idM FOREIGN KEY (idM) REFERENCES matiere(idM);
ALTER TABLE beneficier ADD CONSTRAINT FK_beneficier_idR FOREIGN KEY (idR) REFERENCES reduction(idR);
ALTER TABLE beneficier ADD CONSTRAINT FK_beneficier_idU FOREIGN KEY (idU) REFERENCES compte(idU);
