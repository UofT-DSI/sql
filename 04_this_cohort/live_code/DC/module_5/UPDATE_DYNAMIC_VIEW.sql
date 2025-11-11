/* MODULE 5 */
/* UPDATE statements for view */


/* 1. SET market_date equal to today for new_customer_purchases */
UPDATE new_customer_purchases
SET market_date = DATE('now');



/* 2. Add today's info to the market_date_info 

we need to add 
1. today's date
2. today's day
3. today's week number
4. today's year

INSERT INTO market_date_info
VALUES('....','....','....','....','8:00 AM','2:00 PM','nothing interesting','Summer','25','28',0,0);

*/
 INSERT INTO market_date_info
VALUES('2025-11-11','Tuesday','46','2025','8:00 AM','2:00 PM','nothing interesting','Winter','0','3',0,1);

