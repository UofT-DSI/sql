
SELECT vendor_id, 'top_query' as query_name

from vendor_inventory

UNION 

SELECT vendor_id, 'bottom_query' as query_name

from vendor_inventory

UNION 

SELECT vendor_id, 'middle_query' as query_name

from vendor_inventory