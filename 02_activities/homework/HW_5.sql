--HW_5
--CROSS JOIN

-- SELECT v.vendor_name, p.product_name, 
-- 		(vi.original_price*5)*COUNT(DISTINCT c.customer_id) as revenue
-- FROM vendor_inventory as vi
-- JOIN vendor as v ON vi.vendor_id = v.vendor_id
-- JOIN product as p ON vi.product_id = p.product_id
-- CROSS JOIN customer as c  
-- GROUP BY v.vendor_name, p.product_name


--INSERT

-- CREATE TABLE product_units as
-- SELECT*, CURRENT_TIMESTAMP as snapshot_timestamp
-- FROM product
-- WHERE product_qty_type = 'unit'

-- INSERT INTO product_units
-- VALUES (100, 'Indian Tea', '5_oz', 11, 'unit', CURRENT_TIMESTAMP)


--DELETE

-- DELETE FROM product_units
-- WHERE product_id = 100


--UPDATE

-- ALTER TABLE product_units
-- ADD COLUMN current_quantity INT

-- UPDATE product_units as pu
-- SET current_quantity  = (
-- 	SELECT coalesce(vi.quantity,0)
-- 	FROM vendor_inventory as vi
-- 	WHERE pu.product_id = vi.product_id
-- 	ORDER BY vi.market_date DESC
-- 	LIMIT 1
-- )
-- WHERE pu.product_id IN(
-- 		SELECT DISTINCT product_id
-- 		FROM vendor_inventory
-- 	);
	

