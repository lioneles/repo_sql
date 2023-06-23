-- 1 selectionner tous les stagiaires
SELECT * FROM stagiaires;

--2 sélectionner le nom date de naissance des stagiaires
SELECT nom,datedenaissance FROM stagiaires;

--3 selectionner les noms des stagiaires en supprimant les doublons
SELECT distinct nom FROM stagiaires;

--4 selectionner les stagiaires dont le cursus est asr
SELECT nom FROM stagiaires WHERE cursus like 'asr';

--5 afficher le nom en majuscule le prenom et l'age de chaque stagiaire
SELECT UPPER(nom) ,prenom, YEAR(getdate()) - YEAR(datedenaissance) AS age FROM stagiaires;

--6 filtrer la précedente requete en ne retenant que les stagiaires qui on plus de 30 ans et dont le nom contient un  O
SELECT UPPER(nom) ,prenom, YEAR(getdate()) - YEAR(datedenaissance) AS age FROM stagiaires
WHERE YEAR(getdate()) - YEAR(datedenaissance)>30 AND nom LIKE '%O%';

--7 combien il y a t-il d'ecf differente
SELECT count(*) FROM ecf;

--8 combien y a t-il de stagiaire par cursus
SELECT cursus, COUNT(cursus) AS 'Nombre de stagiaires' FROM STAGIAIRES GROUP BY cursus;

--9 quel sont les stagiaires qui ont la moyenne pour le moment
SELECT stagiaires FROM inscriptions  
GROUP BY stagiaire
HAVING AVG(note) >= 10; 
--ou 
SELECT stagiaires, cast(avg(note) as decimal (3,1)) AS moyenne FROM inscriptions  
GROUP BY stagiaire
HAVING AVG(note) >= 10;

--10 quel sont les libelle des cursus de niveau 1 et 2
SELECT libelle FROM cursus
WHERE niveau IN (1, 2);

--11 quelle est la plus haute note obtenue pour l'ecf 01
SELECT MAX(note) AS notes FROM inscriptions WHERE  codeecf = 'ECF 01';

--12 quelle est la moyenne des note pour l'ecf passé en salle 3 le 13/01/2021
SELECT note FROM inscriptions WHERE salle =3  AND datefin = '13/01/2021 16:00:00:000';

--13 combien de temps dure l'ecf 01
SELECT DATEDIFF(hour,datedebut,datefin) AS time FROM inscriptions WHERE  codeecf = 'ECF 01';

--14 afficher le nombre de cursus
SELECT COUNT(codecursus) AS nbcursus FROM cursus;

--15 affiche le nombre de cursus de niveau 2 et  3 
SELECT COUNT(codecursus) AS nbcursus FROM cursus
WHERE niveau IN (2, 3);

--16 afficher la moyenne des notes aux ecf
SELECT AVG(note) AS notes FROM inscriptions;

--17 afficher la meilleure note de la table inscriptions
SELECT MAX(note) AS notes FROM inscription;

--18 afficher la note la moins élevé de la table inscription
SELECT MIN(note) AS notes FROM inscription;

--autre base de donnees
--19 lister toutes les informations de tous les fabricants
SELECT * FROM fabricants;

--20 lister tous les numeros de salles
SELECT numsalle FROM salles;

--21 lister les machines fabriquer pas dell
SELECT * FROM machines
WHERE codefabricant = 'DELL';

--22 lister les noms, numsalle, et ip des machines pour lesquelle l'ip est valorisé
SELECT nom,addip,numsalle FROM machines
WHERE addip IS NOT NULL;

--23 lister les machines qui ne sont pas fabriquer par hp et qui ne sont pas des portables
SELECT idmachine,nom,codefabricant,addMAC FROM machines
WHERE codefabricant NOT LIKE 'hp' AND mobile = 0;

--24 lister les numeros de salles dans lesquelles il y a des machines
SELECT idmachine, numsalle FROM machines 
WHERE numsalle  > 0;

--25 depuis combien de mois chaque utilisateur dispose t-il de sa machine
SELECT iduser,DATEDIFF(month,datedebut,getdate()) AS mois  FROM affectations 
WHERE datefin IS  NULL;

--26 en reprenant la question precedente, quelle est la duree moyenne en mois
SELECT AVG(DATEDIFF(month,datedebut,getdate())) FROM affectations 
WHERE datefin IS  NULL;

--27 combien de portable ne sont pas en panne
SELECT mobile,COUNT(operationnel) AS goodtojob FROM machines
WHERE operationnel = 1 AND mobile = 1
GROUP BY mobile;

--28 de combien de composant de type RAM dispose t-on
SELECT SUM(qte)  FROM composants 
WHERE  codetype LIKE 'ram';

--29 lister les employés occupant le poste A22 afficher nom prenom et poste 
SELECT nomemp,prenomemp FROM employe 
WHERE poste ='A22';

--30 afficher le nom du projet ou le contact est une femme
SELECT nomprojet FROM projet 
WHERE nomcontact like 'madame%';

--31 lister les employés dont le nom de famille commence par A
SELECT  * FROM employe 
WHERE nomemp LIKE '[A]%';

--32 lister les employées qui touche un salaire entre 11.000 et 12.000 €
SELECT nomemp, prenomemp FROM employe 
WHERE salaire BETWEEN 11000.00 AND 12000.00;

--33 lister les employés dont la prime est NULL
SELECT nomemp,prenomemp FROM employe 
WHERE prime IS NULL;

--34 verifier en affichant la prime
SELECT nomemp,prenomemp,prime FROM employe;

--35 lister les employés dont la prime est null ou le montant de la prime est 0
SELECT nomemp,prenomemp,prime 
FROM employe WHERE prime IS NULL OR prime = 0.00;

--36 lister les employé dont les prenoms sont Rolland Mireille Francis
SELECT nomemp,prenomemp FROM employe  
WHERE  prenomemp LIKE 'Rolland%' OR prenomemp LIKE 'Mireille%' OR prenomemp LIKE 'Francis%';

--37 même question en utilisant IN
SELECT nomemp,prenomemp FROM employe 
WHERE  prenomemp IN ( 'Rolland','Mireille', 'Francis');

--38 lister les employé dont le salaire est superieur à 12.000 €
SELECT nomemp,prenomemp FROM employe
WHERE salaire >= 12.000;
--39 lister les employés (noms prenoms) dont la prime n'est pas null
SELECT nomemp,prenomemp FROM employe WHERE prime IS NOT NULL;

--40 lister les employé qui travaille sur le projet PR1 et dont la prime superieure a 1400€
SELECT nomemp,prenomemp,prime,codeprojet FROM employe
WHERE codeprojet IN ('PR1')  AND prime > 1400.00;


--41 lister les employé qui travaille sur le projet PR1 ou qui touchent une prime superieure a 2000€
SELECT nomemp,prenomemp,prime,codeprojet FROM employe
WHERE codeprojet IN ('PR1') OR prime > 2000.00
GROUP BY codeprojet;

-- 42 afficher le total des salaires  des employés
SELECT COUNT(salaire) AS nbsalaire, SUM(salaire) AS salairetotal FROM employe;

--43 afficher la somme par poste des salaires des employés
SELECT poste,SUM(salaire) AS salaires FROM employe
GROUP BY poste;

--44 Afficher la moyenne des primes en excluant du calcul les personnes n'ayant pas eu de primes
--Les valeurs NULL sont exclues des calculs des fonctions d'agrégation arithmétiques.
SELECT AVG(prime) AS moyennePrime FROM employe;

--45 afficher les 2 plus hautes primes
--offset supprime le nombre de lignes pour n'afficher que celle voulu 
SELECT prime FROM employe
ORDER BY prime OFFSET 19 ROWS;
--tres dependant du jeu de donnée
--ou
SELECT TOP(2) prime FROM employe
ORDER BY prime  DESC;

--46 afficher le nom et la longueur de la chaine de caratere pour le nom des employé
SELECT nomemp, LEN(nomemp) AS nbcaractere FROM employe; 

--**********************JOINTURE************************

--47 afficher les informations sur le stagiaire et le libelle de son cursus
SELECT numero,nom,prenom,libelle FROM stagiaires
INNER JOIN cursus ON
stagiaires.cursus = cursus.codesursus;

--48 afficher le produit cartesien entre les tables stagiaire et cursus
SELECT * FROM stagiaires
CROSS JOIN cursus;

--49 afficher la jointure interne entre stagiaire et cursus
SELECT * from stagiaires
INNER JOIN cursus ON
stagiaires.cursus = cursus.codecursus;

--50 continuer les jointure interne entre cursus stagiaire et inscriptions
SELECT * FROM stagiaires
INNER JOIN cursus ON
stagiaires.cursus = cursus.codesursus
INNER JOIN inscriptions ON
cursus.niveau = inscription.salle;

--51 afficher le libelle du cursus le nom en maj le prenom la salle
--les notes en excluant les lignes sans note pour cursus 2et3

SELECT upper(nom),prenom,libelle,salle,note FROM stagiaires
INNER JOIN cursus ON
stagiaires.cursus = cursus.codecursus
INNER JOIN inscriptions ON
stagiaires.numero = inscription.stagiaire
WHERE note IS NOT NULL AND niveau >= 2;

--52 trier la précedente requete par nom
SELECT upper(nom),prenom,libelle,salle,note FROM stagiaires
INNER JOIN cursus ON
stagiaires.cursus = cursus.codecursus
INNER JOIN inscriptions ON
stagiaires.numero = inscription.stagiaire
WHERE note IS NOT NULL AND niveau >= 2
ORDER BY nom;

--53 quel stagiaire nom,prenom passe ecf 12 prochainement et a quelle date
SELECT upper(nom),prenom,datedebut,codeecf FROM stagiaires
INNER JOIN cursus ON
stagiaires.cursus = cursus.codecursus
INNER JOIN inscriptions ON
stagiaires.numero = inscription.stagiaire
WHERE codeecf IN ('ecf 12')
ORDER BY nom;

--54 lister les ecf passé (libelle de l'ecf et mois en toute lettre) puis année de passage (datename)
SELECT upper(nom),prenom,datename(month,datefin) AS mois,datename(year,datefin) AS année FROM stagiaires
INNER JOIN cursus ON
stagiaires.cursus = cursus.codecursus
INNER JOIN inscriptions ON
stagiaires.numero = inscription.stagiaire;

--55 ajouter à la question précédente la moyenne des notes pour chacune des ecf passées ADD
SELECT avg(note) AS note,upper(nom),prenom,datename(month,datefin) AS mois,datename(year,datefin) AS année FROM stagiaires
INNER JOIN cursus ON
stagiaires.cursus = cursus.codecursus
INNER JOIN inscriptions ON
stagiaires.numero = inscription.stagiaire
GROUP BY nom,prenom,libelle,datefin;

--56 quels utilisateurs travaillent sur des machines qui disposent d'une carte graphique ADD
SELECT dbo.utilisateurs.iduser,dbo.machines.idmachines,dbo.utilisateurs.nom,dbo.utilisateurs.prenom FROM affectations
INNER JOIN machines ON
dbo.affectations.idmachine = dbo.machines.idmachines
INNER JOIN constitutions ON
dbo.machines.idmachines = dbo.constitutions.idmachine
INNER JOIN composants ON
dbo.constitutions.idcomposant = dbo.constitutions.idcomposant
INNER JOIN utilisateurs ON
dbo.affectations.iduser = dbo.utilisateurs.iduser 
where dbo.composants.codefabricant = 'CC' AND datefin IS NULL;

--57 lister le nom des machine
SELECT machines.addmac,machines.nom,salles.descriptif,fabricants.nom FROM machines
INNER JOIN salles ON
machines.numsalle = salles.numsalle
INNER JOIN fabricants ON
machines.codefabricant = fabricants.codefabricant
WHERE dbo.fabricants.codefabricant in ('HP', 'dell')
GROUP BY addmac, dbo.fabricants.nom,dbo.machines.nom,descriptif;

--58 combien de machines ont été affecté a Gilles
SELECT dbo.machines.nom,dbo.utilisateurs.prenom FROM affectations
INNER JOIN machines ON
dbo.affectations.idmachine = dbo.machines.idmachines
INNER JOIN utilisateurs ON
dbo.affectations.iduser = dbo.utilisateurs.iduser
WHERE dbo.utilisateurs.prenom IN ('Gilles');

--59 quelle est la composition de la derniere machine utilisé par sophie
SELECT DISTINCT * FROM machines
INNER JOIN affectations ON
dbo.machines.idmachines =dbo.affectations.idmachine 
INNER JOIN constitutions ON
dbo.machines.idmachines = dbo.constitutions.idmachine
INNER JOIN composants ON
dbo.constitutions.idcomposant = dbo.composants.idcomposant
INNER JOIN utilisateurs ON
dbo.affectations.iduser = dbo.utilisateurs.iduser 
where dbo.utilisateurs.prenom IN ('sophie') AND operationnel = 1;
-- ou 
SELECT * FROM composants
INNER JOIN constitutions ON composants.idcomposant = constitutions.idcomposant
INNER JOIN affectations ON constitutions.idmachine = affectations.idmachine
INNER join utilisateurs ON affectations.iduser = utilisateurs.iduser
WHERE prenom = 'Sophie' AND datefin is not null;


--60 combien reste-il de cartes graphiques non affectées à des machines
SELECT qte - count(dbo.composants.codetype) AS carteDispo FROM composants
INNER JOIN constitutions ON composants.idcomposant = constitutions.idcomposant
INNER JOIN machines ON constitutions.idmachine = machines.idmachines
WHERE codetype = 'CC' 
GROUP BY  codetype;
--Ou
SELECT qte - count(dbo.composants.idcomposant) AS carteDispo,codetype FROM composants
INNER JOIN constitutions ON composants.idcomposant = constitutions.idcomposant
WHERE dbo.composants.idcomposant = '70' 
GROUP BY  qte, codetype

--61 combien y a t-il de composant par machine (nom de machine + nom de la salle)
--trié ayant le plus de composant a celle en ayant le moins
	SELECT count(idcomposant) AS 'NB composants',CONSTITUTIONS.idmachine, MACHINES.nom,SALLES.descriptif FROM CONSTITUTIONS
INNER JOIN MACHINES ON CONSTITUTIONS.idmachine = MACHINES.idmachines
INNER JOIN SALLES ON MACHINES.numsalle = SALLES.numsalle
GROUP BY CONSTITUTIONS.idmachine,MACHINES.nom,SALLES.descriptif
ORDER BY [NB composants] DESC;


--62 afficher les machines qui sont constituées de moins de 4 composants

SELECT DISTINCT(CONSTITUTIONS.idmachine), count(COMPOSANTS.idcomposant) AS NbComposant, MACHINES.nom, SALLES.descriptif  FROM MACHINES 
INNER JOIN CONSTITUTIONS ON MACHINES.idmachines = CONSTITUTIONS.idmachine
INNER JOIN COMPOSANTS ON CONSTITUTIONS.idcomposant = COMPOSANTS.idcomposant
INNER JOIN SALLES ON MACHINES.numsalle = SALLES.numsalle
GROUP BY CONSTITUTIONS.idmachine, MACHINES.nom, SALLES.descriptif
HAVING count(COMPOSANTS.idcomposant) < 4
ORDER BY NBcomposant DESC;

--63 quel sont les salles sans machine
SELECT s.descriptif AS descriptif_salle 
FROM SALLES s 
LEFT JOIN MACHINES m ON s.numsalle = m.numsalle 
WHERE m.idmachine IS NULL; 

--64 y'a t-il des machine qui n'ont pas de disque dur, et ces machines sont-elles opérationnelle

SELECT machines.idmachines, operationnel FROM machines 
INNER JOIN CONSTITUTIONS ON MACHINES.idmachines = CONSTITUTIONS.idmachine
INNER JOIN COMPOSANTS ON CONSTITUTIONS.idcomposant = COMPOSANTS.idcomposant
WHERE (codetype NOT LIKE 'DD' OR codetype NOT LIKE 'SSD') 

--65 afficher le nombre de machines par salle ansi que le nombre de machine au total 
SELECT SALLES.numsalle,descriptif,COUNT(idmachines) AS 'PC / Salles',
    (SELECT count(idmachines) FROM MACHINES) AS Total FROM SALLES
LEFT JOIN MACHINES ON SALLES.numsalle = MACHINES.numsalle
GROUP BY SALLES.numsalle,SALLES.descriptif;

--66 afficher la liste des utilisateurs ainsi que les machines qui leur sont ou leur ont été affecté et la durée d"affection
SELECT UTILISATEURS.nom,MACHINES.nom,DATEDIFF(DAY,datedebut,datefin) AS Ancienne_Machine,DATEDIFF(day,datedebut,GETDATE()) AS Machine_actuelle from MACHINES
INNER JOIN AFFECTATIONS on AFFECTATIONS.idmachine = MACHINES.idmachines
JOIN UTILISATEURS on UTILISATEURS.iduser = AFFECTATIONS.iduser;

--67 quels sont les utilisateur qui n'ont pas encore de machine
SELECT nom,prenom FROM utilisateurs
where iduser = (select iduser from utilisateurs EXcEPT select iduser from affectations);

--68 quel composant dispose de la plus grande quantité
SELECT DISTINCT composants.nom,composants.qte FROM composants
WHERE composants.qte = (select TOP(1) composants.qte FROM composants ORDER BY composants.qte DESC);
--ou
SELECT nom, qte FROM COMPOSANTS
WHERE qte = (SELECT MAX(qte) FROM COMPOSANTS);