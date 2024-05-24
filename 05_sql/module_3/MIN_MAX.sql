-- MIN & max

/*
SELECT product_name, max(original_price)


FROM product as p
JOIN vendor_inventory as vi
	ON p.product_id = vi.product_id
--ORDER BY p.product_id DESC
*/

-- minimum price per differnet type of product measurement (unit vs lbs)
SELECT product_name, product_qty_type, min(original_price)


FROM product as p
JOIN vendor_inventory as vi
	ON p.product_id = vi.product_id
	
group by product_qty_type