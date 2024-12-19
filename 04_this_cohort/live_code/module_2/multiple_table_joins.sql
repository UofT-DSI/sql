-- multiple table joins
/* which vendor has sold products to a customer AND which product was it  and which customer bought it? */


SELECT DISTINCT --vendor_id, product_id, customer_id -- im unsatisified with the ids! 
vendor_name
,product_name
,customer_first_name, customer_last_name

FROM customer_purchases cp 
INNER JOIN customer c
	ON c.customer_id = cp.customer_id
INNER JOIN vendor v
	ON v.vendor_id = cp.vendor_id
INNER JOIN product p
	ON p.product_id = cp.product_id;
	
/* what if we add the dates they purchased these products? */
SELECT DISTINCT --vendor_id, product_id, customer_id -- im unsatisified with the ids! 
vendor_name
,product_name
,customer_first_name, customer_last_name
,md.market_date, market_day -- added a row every day that the product was purchased -- many more rows!

FROM customer_purchases cp 
INNER JOIN customer c
	ON c.customer_id = cp.customer_id
INNER JOIN vendor v
	ON v.vendor_id = cp.vendor_id
INNER JOIN product p
	ON p.product_id = cp.product_id
INNER JOIN market_date_info md
	ON md.market_date = cp.market_date;

SELECT DISTINCT --vendor_id, product_id, customer_id -- im unsatisified with the ids! 
vendor_name
,product_name
,customer_first_name, customer_last_name
,customer_postal_code, postal_code_3

FROM customer_purchases cp 
INNER JOIN customer c
	ON c.customer_id = cp.customer_id
INNER JOIN vendor v
	ON v.vendor_id = cp.vendor_id
INNER JOIN product p
	ON p.product_id = cp.product_id
INNER JOIN postal_data pd
	ON c.customer_postal_code = pd.postal_code_3 -- different names!
	