CREATE TABLE PunjabiPoems (
	ID	INTEGER,
	Name	TEXT,
	Poem	LONGTEXT,
	Author	VARCHAR(15),
	PRIMARY KEY(ID)
);

INSERT INTO PunjabiPoems (Poem, Author
			 VALUES ('', 'Baba Bulle Shah');
INSERT INTO PunjabiPoems (Poem, Author)
			 VALUES ('', 'Bhai Vir Singh');
INSERT INTO PunjabiPoems (Poem, Author)
			 VALUES ('', 'Fazal Shah');
INSERT INTO PunjabiPoems (Poem, Author)
			 VALUES ('', 'Sultan Bahu');
INSERT INTO PunjabiPoems (Poem, Author)
			 VALUES ('', 'Ustad Daman');

UPDATE PunjabiPoems SET Name =
SUBSTRING_INDEX(PunjabiPoems.Poem,' 10',1);

UPDATE PunjabiPoems SET Name =
SUBSTRING_INDEX(PunjabiPoems.Name,'46 32 ',-1);

UPDATE PunjabiPoems SET Poem =
SUBSTRING(PunjabiPoems.Poem,
									LOCATE('10 ', Poem) + 3);


CREATE TABLE Features ( ID INTEGER, TempPoem LONGTEXT,
	ParaCount INTEGER, LineCount INTEGER, PuncFreq INTEGER,
	WordCount INTEGER, AkharCount INTEGER,
	AvgWordLength FLOAT, AvgSentenceLengthN FLOAT,
	AvgSentenceLengthT FLOAT, AkharSpaceRatio FLOAT,
	EndingAkhar INTEGER, Akhar1 INTEGER, Akhar2 INTEGER,
	Akhar3 INTEGER, Akhar4 INTEGER, Akhar5 INTEGER,
	Akhar6 INTEGER, Akhar7 INTEGER, Akhar8 INTEGER,
	Akhar9 INTEGER, Akhar10 INTEGER, Akhar11 INTEGER,
	Akhar12 INTEGER, Akhar13 INTEGER, Akhar14 INTEGER,
	Akhar15 INTEGER, Akhar16 INTEGER, Akhar17 INTEGER,
	Akhar18 INTEGER, Akhar19 INTEGER, Akhar20 INTEGER,
	Akhar21 INTEGER, Akhar22 INTEGER, Akhar23 INTEGER,
	Akhar24 INTEGER, Akhar25 INTEGER,
	Akhar26 INTEGER, Akhar27 INTEGER, Akhar28 INTEGER,
	Akhar29 INTEGER, Akhar30 INTEGER, Akhar31 INTEGER,
	Akhar32 INTEGER, Akhar33 INTEGER, Akhar34 INTEGER,
	Akhar35 INTEGER, Akhar36 INTEGER, Akhar37 INTEGER,
	Akhar38 INTEGER, Akhar39 INTEGER, Akhar40 INTEGER,
	Akhar41 INTEGER, Akhar42 INTEGER, Akhar43 INTEGER,
	Akhar44 INTEGER, Akhar45 INTEGER, Akhar46 INTEGER,
	Akhar47 INTEGER, Akhar48 INTEGER, Akhar49 INTEGER,
	Akhar50 INTEGER, Vowel1Count INTEGER,
	Vowel2Count INTEGER, VelarCount INTEGER,
	PalatelCount INTEGER, RetroflexCount INTEGER,
	DentalCount INTEGER, LabielCount INTEGER,
	LGCount INTEGER, Author	VARCHAR(15), PRIMARY KEY(ID) );

INSERT INTO Features (ID) VALUES ('1');

UPDATE Features INNER JOIN
     ON PunjabiPoems.ID = Features.ID
     SET Features.TempPoem = PunjabiPoems.Poem;

UPDATE Features INNER JOIN PunjabiPoems
     ON PunjabiPoems.ID = Features.ID
     SET Features.Author = PunjabiPoems.Author;

UPDATE Features SET ParaCount =
((LENGTH(TempPoem)
- LENGTH(REPLACE(TempPoem,' 10 10','')))/6) + 1;

UPDATE Features SET TempPoem =
REPLACE(TempPoem,' 10 10',' 10'); --Remove double newlines

UPDATE Features SET LineCount =
((LENGTH(TempPoem)
     - LENGTH(REPLACE(TempPoem, ' 10', '')))/6) + 1;

-- Order | , ? ! : - ; ' " ( ) ੭
UPDATE Features SET PuncFreq =
((LENGTH(TempPoem)
     - LENGTH(REPLACE(TempPoem, ' 2404', '')))/5) +
((LENGTH(TempPoem)
     - LENGTH(REPLACE(TempPoem, ' 44', '')))/3) +
((LENGTH(TempPoem)
     - LENGTH(REPLACE(TempPoem, ' 63', '')))/3) +
((LENGTH(TempPoem)
     - LENGTH(REPLACE(TempPoem, ' 33', '')))/3) +
((LENGTH(TempPoem)
     - LENGTH(REPLACE(TempPoem, ' 58', '')))/3) +
((LENGTH(TempPoem)
     - LENGTH(REPLACE(TempPoem, ' 45', '')))/3) +
((LENGTH(TempPoem)
     - LENGTH(REPLACE(TempPoem, ' 59', '')))/3) +
((LENGTH(TempPoem)
     - LENGTH(REPLACE(TempPoem, ' 39', '')))/3) +
((LENGTH(TempPoem)
     - LENGTH(REPLACE(TempPoem, ' 34', '')))/3) +
((LENGTH(TempPoem)
     - LENGTH(REPLACE(TempPoem, ' 40', '')))/3) +
((LENGTH(TempPoem)
     - LENGTH(REPLACE(TempPoem, ' 41', '')))/3) +
((LENGTH(TempPoem)
     - LENGTH(REPLACE(TempPoem, ' 2669', '')))/5) ;

-- Removing punctuation
UPDATE Features SET
     TempPoem = REPLACE(TempPoem, ' 2404', '');
UPDATE Features SET
     TempPoem = REPLACE(TempPoem, ' 44', '');
UPDATE Features SET
     TempPoem = REPLACE(TempPoem, ' 63', '');
UPDATE Features SET
     TempPoem = REPLACE(TempPoem, ' 33', '');
UPDATE Features SET
     TempPoem = REPLACE(TempPoem, ' 58', '');
UPDATE Features SET
     TempPoem = REPLACE(TempPoem, ' 45', '');
UPDATE Features SET
     TempPoem = REPLACE(TempPoem, ' 59', '');
UPDATE Features SET
     TempPoem = REPLACE(TempPoem, ' 39', '');
UPDATE Features SET
     TempPoem = REPLACE(TempPoem, ' 34', '');
UPDATE Features SET
     TempPoem = REPLACE(TempPoem, ' 40', '');
UPDATE Features SET
     TempPoem = REPLACE(TempPoem, ' 41', '');
UPDATE Features SET
     TempPoem = REPLACE(TempPoem, ' 2669', '');

-- Ending Akhar
WITH RECURSIVE cte (ID, Poem, Starts, Pos)
AS

 (SELECT ID, REPLACE(TempPoem, ' 32', ''), 1,
    LOCATE(' 10', Poem) FROM Features
    UNION ALL
    SELECT ID, REPLACE(TempPoem, ' 32', ''), Pos + 1,
    LOCATE(' 10', Poem, Pos+1) FROM cte
    WHERE Pos>0),

cte2 (ID, Poem, Starts, Pos, Token)
AS
  (SELECT ID, Poem, Starts, Pos,
     SUBSTRING(Poem, Pos-4, 4) FROM cte),

-- SELECT ID, Pos, Token FROM cte2;

UPDATE Features SET EndingAkhar =
(CASE WHEN (STRCMP(cte2.Token, '?') = 0
     OR STRCMP(cte22.Token, '?') = 0
     OR STRCMP(cte2.Token, '?') = 0)
     THEN EndingAkhar+1 ELSE EndingAkhar END)
     WHERE Features.ID = cte2.ID;

CREATE TEMPORARY TABLE cte AS
(SELECT ID, REPLACE(TempPoem, ' 32', '') AS Poem,
1 AS Starts, LOCATE(' 10', Poem) AS Pos FROM Features
UNION ALL SELECT ID, Poem, Pos + 1,
LOCATE(' 10', Poem, Pos+1) FROM cte WHERE Pos>0);


UPDATE Features SET
TempPoem = REPLACE(TempPoem,' 10',' 32'); --Remove single newlines

UPDATE Features SET
WordCount = ((LENGTH(TempPoem) -
     LENGTH(REPLACE(TempPoem,' 32','')))/3) + 1;

UPDATE Features SET
TempPoem = REPLACE(TempPoem,' 32',''); --Remove whitespaces unicode

UPDATE Features SET
AkharCount = LENGTH(TempPoem) -
     LENGTH(REPLACE(TempPoem, ' ', '')) + 1;

UPDATE Features SET
     AvgWordLength = AkharCount / WordCount;

UPDATE Features SET
     AvgSentenceLengthN = AkharCount / LineCount;

UPDATE Features SET
     AvgSentenceLengthT = WordCount / LineCount;

UPDATE Features SET
     AkharSpaceRatio = AkharCount / (WordCount + 1);


-- Basic Vowels and Fricatives (Vowel1)
UPDATE Features SET Akhar1 =
   LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2675', ''));
UPDATE Features SET Akhar2 =
   LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2565', ''));
UPDATE Features SET Akhar3 =
   LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2674', ''));
UPDATE Features SET Akhar4 =
   LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2616', ''));
UPDATE Features SET Akhar5 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2617', ''));

-- Initial Vowels (Vowel2)
UPDATE Features SET Akhar6 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2566', ''));
UPDATE Features SET Akhar7 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2567', ''));
UPDATE Features SET Akhar8 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2568', ''));
UPDATE Features SET Akhar9 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2569', ''));
UPDATE Features SET Akhar10 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2570', ''));
UPDATE Features SET Akhar11 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2575', ''));
UPDATE Features SET Akhar12 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2576', ''));
UPDATE Features SET Akhar13 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2579', ''));
UPDATE Features SET Akhar14 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2580', ''));

-- Velars
UPDATE Features SET Akhar15 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2581', ''));
UPDATE Features SET Akhar16 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2582', ''));
UPDATE Features SET Akhar17 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2583', ''));
UPDATE Features SET Akhar18 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2584', ''));
UPDATE Features SET Akhar19 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2585', ''));

-- Palatels
UPDATE Features SET Akhar20 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2586', ''));
UPDATE Features SET Akhar21 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2587', ''));
UPDATE Features SET Akhar22 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2588', ''));
UPDATE Features SET Akhar23 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2589', ''));
UPDATE Features SET Akhar24 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2590', ''));

-- Retroflex
UPDATE Features SET Akhar25 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2591', ''));
UPDATE Features SET Akhar26 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2592', ''));
UPDATE Features SET Akhar27 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2593', ''));
UPDATE Features SET Akhar28 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2594', ''));
UPDATE Features SET Akhar29 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2595', ''));

-- Dental
UPDATE Features SET Akhar30 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2596', ''));
UPDATE Features SET Akhar31 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2597', ''));
UPDATE Features SET Akhar32 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2598', ''));
UPDATE Features SET Akhar33 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2599', ''));
UPDATE Features SET Akhar34 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2600', ''));

-- Labiel
UPDATE Features SET Akhar35 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2602', ''));
UPDATE Features SET Akhar36 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2603', ''));
UPDATE Features SET Akhar37 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2604', ''));
UPDATE Features SET Akhar38 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2605', ''));
UPDATE Features SET Akhar39 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2606', ''));

-- Liquids & Glides
UPDATE Features SET Akhar40 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2607', ''));
UPDATE Features SET Akhar41 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2608', ''));
UPDATE Features SET Akhar42 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2610', ''));
UPDATE Features SET Akhar43 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2613', ''));
UPDATE Features SET Akhar44 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2652', ''));

-- Additional letters
UPDATE Features SET Akhar45 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2611', ''));
UPDATE Features SET Akhar46 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2614', ''));
UPDATE Features SET Akhar47 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2649', ''));
UPDATE Features SET Akhar48 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2650', ''));
UPDATE Features SET Akhar49 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2651', ''));
UPDATE Features SET Akhar50 =
  LENGTH(TempPoem) - LENGTH(REPLACE(TempPoem, ' 2654', ''));

UPDATE Features SET
  Vowel1Count = Akhar1 + Akhar2 + Akhar3 + Akhar4 + Akhar5;
UPDATE Features SET Vowel2Count = Akhar6 + Akhar7 + Akhar8 +
  Akhar9 + Akhar10 + Akhar11 + Akhar12 + Akhar13 + Akhar14;

UPDATE Features SET
  VelarCount = Akhar15 + Akhar16 + Akhar17 + Akhar18 + Akhar19;
UPDATE Features SET
 PalatelCount = Akhar20 + Akhar21 + Akhar22 + Akhar23 + Akhar24;
UPDATE Features SET
 RetroflexCount = Akhar25 + Akhar26 + Akhar27 + Akhar28 + Akhar29;
UPDATE Features SET
  DentalCount = Akhar30 + Akhar31 + Akhar32 + Akhar33 + Akhar34;
UPDATE Features SET
  LabielCount = Akhar35 + Akhar36 + Akhar37 + Akhar38 + Akhar39;
UPDATE Features SET
  LGCount = Akhar40 + Akhar41 + Akhar42 + Akhar43 + Akhar44;
