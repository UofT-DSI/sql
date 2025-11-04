/* MODULE 3 */
/* Arithmitic */


/* 1. power, pi(), ceiling, division, integer division, etc */
SELECT power(4,2), pi();

SELECT 10.0 / 3.0 as division,
CAST(10.0 as INT) / CAST(3.0 as INT) as integer_division;

/* 2. Every even vendor_id with modulo */
SELECT * FROM vendor
WHERE vendor_id % 2 = 0;

/* 3. What about every third?  */
SELECT * FROM vendor
WHERE vendor_id % 3 = 0;

