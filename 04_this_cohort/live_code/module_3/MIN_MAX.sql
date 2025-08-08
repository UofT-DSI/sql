-- MIN & max

-- what is the most expensive product

SELECT 
product_name,
max(original_price) as most_expensive -- doesn't handle ties well

FROM product p
INNER JOIN vendor_inventory vi
	ON p.product_id = vi.product_id;
	
--prove it
SELECT DISTINCT
product_name,
original_price

FROM product p
INNER JOIN vendor_inventory vi
	ON p.product_id = vi.product_id
ORDER BY original_price DESC;

--minimum price per each product_qty_type
SELECT 
product_name,
product_qty_type,
min(original_price) as least_expensive 

FROM product p
INNER JOIN vendor_inventory vi
	ON p.product_id = vi.product_id
GROUP BY product_qty_type

order by product_qty_type ASC, original_price ASC;

--prove it
SELECT DISTINCT
product_name,
product_qty_type,
original_price

FROM product p
INNER JOIN vendor_inventory vi
	ON p.product_id = vi.product_id
ORDER BY product_qty_type, original_price


