/* MODULE 3 */
/* Arithmitic */


/* 1. power, pi(), ceiling, division, integer division, etc */
SELECT 
power(2,3) as [power]
,pi() as [pi]
,10.0 / 3.0 as division
,cast(10.0 as INT) / cast(3.0 as int) as integer_division
,ceiling(4.5) as [ceilign];

/* 2. Every even vendor_id with modulo */
SELECT *

FROM vendor
WHERE vendor_id % 2 = 0;


/* 3. What about every third?  */
SELECT *

FROM vendor
WHERE vendor_id % 3 = 1;
