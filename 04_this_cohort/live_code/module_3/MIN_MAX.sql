--MIN & MAX 

-- what is the most expensive product
SELECT 
--product_id
product_name
,MAX(original_price) -- doesnt handle ties very well

FROM vendor_inventory vi
INNER JOIN product p 
	ON p.product_id = vi.product_id;
	
-- what is the least expensive per each type 
SELECT 
product_name
,product_qty_type
,MIN(original_price) -- doesnt handle ties very well

FROM vendor_inventory vi
INNER JOIN product p 
	ON p.product_id = vi.product_id

GROUP BY product_qty_type;

--PROVE THE ABOVE QUERY
SELECT DISTINCT
product_name
,product_qty_type
,original_price

FROM vendor_inventory vi
INNER JOIN product p 
	ON p.product_id = vi.product_id
ORDER BY product_qty_type, original_price