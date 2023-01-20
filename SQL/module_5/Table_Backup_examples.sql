--backup a table


CREATE TABLE temp."booth_backup" (
	"booth_number"	int(11) NOT NULL,
	"booth_price_level"	varchar(45) NOT NULL,
	"booth_description"	varchar(255) NOT NULL,
	"booth_type"	varchar(45) NOT NULL,
	PRIMARY KEY("booth_number"),
	UNIQUE("booth_number")
);

INSERT INTO temp.booth_backup
SELECT * FROM booth


INSERT INTO booth
SELECT * FROM temp.booth_backup