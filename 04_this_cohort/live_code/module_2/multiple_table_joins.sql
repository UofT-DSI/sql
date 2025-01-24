-- Multiple Table Joins

--making the customer_purchases table have a lot more meaning and information
SELECT market_date, quantity, cost_to_customer_per_qty, 
product_name, vendor_name, customer_first_name, customer_last_name, city, district

FROM customer_purchases cp
INNER JOIN product p 
	ON p.product_id = cp.product_id
INNER JOIN vendor v
	ON v.vendor_id = cp.vendor_id
INNER JOIN customer c
	ON c.customer_id = cp.customer_id
INNER JOIN postal_data pd
	ON c.customer_postal_code = pd.postal_code_3