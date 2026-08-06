/* MODULE 3 */
/* Arithmitic */


/* 1. power, pi(), ceiling, division, integer division, etc */
SELECT power(4,2) as power, pi() as pi, sin(1) as sin;

SELECT 10.0 / 3.0 as division,
CAST(10.0 as INT) / CAST(3.0 as INT) as integer_division;

SELECT DISTINCT cost_per_quantity, cast(cost_per_quantity as INT) / 3 -- what if we do this with a column instead?
FROM customer_purchases;


/* 2. Every even vendor_id with modulo */
SELECT * FROM vendor
WHERE vendor_id % 2 = 0;


/* 3. What about every third?  */
SELECT * FROM vendor
WHERE vendor_id % 3 = 0;

--------------------------------------------------------------------------------------------------------------------------------------------
