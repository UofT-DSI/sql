-- RANK

--Find the most expensive item a given vendor sells, allow for ties (cherry and apple pie, both cost $18) 

/*
SELECT DISTINCT x.*, product_name

FROM (

	SELECT
	vendor_id
	,market_date
	,product_id
	,original_price
	,RANK() OVER (PARTITION BY vendor_id ORDER BY original_price DESC, market_date ASC) as price_rank
	
	FROM vendor_inventory ) x
JOIN product p
	ON x.product_id = p.product_id
	
WHERE price_rank = 1
*/


SELECT x.*,b.*

FROM (

	SELECT DISTINCT 
	vendor_id,
	booth_number,
	market_date,

	RANK() OVER (PARTITION BY vendor_id ORDER BY market_date DESC) last_time_at_farmers_market

	FROM vendor_booth_assignments ) x

JOIN booth b
	ON x.booth_number = b.booth_number

WHERE x.last_time_at_farmers_market = 1