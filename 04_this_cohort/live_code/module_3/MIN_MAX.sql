-- MIN & MAX 

--what is the most expensive product
SELECT product_name, max(original_price)

FROM product AS p 
INNER JOIN vendor_inventory AS vi
	ON p.product_id = vi.product_id;
	
	
--minimum price per each type of the unit/lbs
SELECT product_name, product_qty_type
, min(original_price)
FROM product as p
INNER JOIN vendor_inventory AS vi
	ON p.product_id = vi.product_id
	
	group by product_qty_type


-- PROVE IT
SELECT product_name, product_qty_type, original_price
--, min(original_price)
FROM product as p
INNER JOIN vendor_inventory AS vi
	ON p.product_id = vi.product_id
	
	--group by product_name, product_qty_type
	ORDER BY product_qty_type, original_price ASC
	
	
	
