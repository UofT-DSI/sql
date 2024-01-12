-- CASE 

/*
SELECT *
,CASE WHEN customer_first_name LIKE ('%a%') --IN ('Jane','Bob','Jessica')
	THEN 'favourite_cust'
		WHEN customer_zip = 22801 
		THEN 'second_favourite_cust'
	ELSE ''
	END AS favourite_customer
FROM customer

*/

SELECT *,
CASE WHEN cost_to_customer_per_qty < '1.00' 
	THEN cost_to_customer_per_qty*100 
		WHEN cost_to_customer_per_qty <'5.00'
	THEN cost_to_customer_per_qty*10
	ELSE cost_to_customer_per_qty*5
	END as inflation

FROM customer_purchases

ORDER BY cost_to_customer_per_qty ASC