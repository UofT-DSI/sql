--SUBQUERIES: WHERE

--"what is the name of the vendor who sells pie"

SELECT DISTINCT vendor_name--, product_id
FROM vendor_inventory vi
INNER JOIN vendor v
	ON v.vendor_id = vi.vendor_id
WHERE product_id IN 
(
	SELECT product_id
	FROM product
	WHERE product_name LIKE '%pie%'
)