CREATE TABLE "booth_backup" (
	"booth_number"	int(11) NOT NULL,
	"booth_price_level"	varchar(45) NOT NULL,
	"booth_description"	varchar(255) NOT NULL,
	"booth_type"	varchar(45) NOT NULL,
	PRIMARY KEY("booth_number"),
	UNIQUE("booth_number")
);

INSERT INTO booth_backup
SELECT * FROM booth