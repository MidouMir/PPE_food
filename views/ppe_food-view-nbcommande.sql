CREATE VIEW
	lesCommandes
	(client, nbCommande, nbReduc)
AS
	SELECT
		compte.idU,
		COUNT(commande.idC),
		COUNT(compte.nbReduc)
	FROM
		compte
	LEFT JOIN
		commande
	ON
		compte.idU = commande.idU
	GROUP BY
		compte.idU;