-- MIN & max

--what is the most expensive product
SELECT product_name, max(original_price) -- doesnt handle ties well!

FROM product p 
INNER JOIN vendor_inventory as vi
	ON p.product_id = vi.product_id;
	
-- minimum price per each type of the unit/lbs
SELECT product_name, product_qty_type,
min(original_price) 

FROM product p 
INNER JOIN vendor_inventory as vi
	ON p.product_id = vi.product_id

GROUP BY product_qty_type;

--PROVE IT
SELECT DISTINCT product_name, product_qty_type,original_price

FROM product p 
INNER JOIN vendor_inventory as vi
	ON p.product_id = vi.product_id
ORDER BY product_qty_type, original_price
