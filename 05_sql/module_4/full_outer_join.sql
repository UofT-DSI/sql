--FULL OUTER JOIN WITH A UNION

DROP TABLE IF EXISTS temp.store1; 
CREATE TEMP TABLE IF NOT EXISTS temp.store1
(
costume TEXT,
quantity INT
);

INSERT INTO temp.store1
VALUES("tiger",6),
        ("elephant",2),
        ("princess", 4);


DROP TABLE IF EXISTS temp.store2;
CREATE TEMP TABLE IF NOT EXISTS temp.store2
(
costume TEXT,
quantity INT
);

INSERT INTO temp.store2
VALUES("tiger",2),
	("dancer",7),
	("superhero", 5);
	
SELECT s1.costume, s1.quantity as store1_quantity, s2.quantity as store2_quantity

FROM store1 s1
LEFT JOIN store2 s2 on s1.costume = s2.costume

UNION ALL

SELECT s2.costume, s1.quantity, s2.quantity
FROM store2 s2
LEFT JOIN store1 s1 on s2.costume = s1.costume
WHERE s1.quantity is NULL