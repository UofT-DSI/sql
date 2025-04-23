-- MIN & MAX 

-- what is the most expensive product

SELECT 
product_name, max(original_price) as most_expensive -- doesnt handle ties well

FROM product p 
INNER JOIN vendor_inventory vi
	ON p.product_id = vi.product_id;
	
-- minimum price per each product_qty_type
SELECT DISTINCT
product_name, product_qty_type,
--original_price
min(original_price)

FROM product p 
INNER JOIN vendor_inventory vi
	ON p.product_id = vi.product_id
GROUP BY product_qty_type	

order by product_qty_type, original_price;


--PROVE IT!
	
-- minimum price per each product_qty_type
SELECT DISTINCT
product_name, product_qty_type,
original_price


FROM product p 
INNER JOIN vendor_inventory vi
	ON p.product_id = vi.product_id	

order by product_qty_type, original_price
