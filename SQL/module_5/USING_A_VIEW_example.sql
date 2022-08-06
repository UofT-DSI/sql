-- after creating our view, we can use it in a join as if a table
SELECT  *

FROM vendor_inventory vi
INNER JOIN product_view pv 
	ON vi.product_id = pv.product_id