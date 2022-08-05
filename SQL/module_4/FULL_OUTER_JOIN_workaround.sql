--FULL OUTER JOIN
drop table if exists temp.store1;
create temp table if not exists temp.store1
(
costume TEXT,
quantity INT
);

insert into temp.store1
values("tiger",6),
	("elephant",2),
	("princess", 4);

drop table if exists temp.store2;
create temp table if not exists temp.store2
(
costume TEXT,
quantity INT
);

insert into temp.store2
values("tiger",2),
	("dancer",7),
	("superhero", 5);
	
SELECT s1.quantity as store1_quantity, s1.costume, s2.quantity as store2_quantity
FROM store1 s1
LEFT JOIN store2 s2 ON s1.costume = s2.costume

UNION ALL

SELECT s1.quantity, s2.costume, s2.quantity
FROM store2 s2
LEFT JOIN store1 s1 ON s2.costume = s1.costume
WHERE s1.quantity IS NULL