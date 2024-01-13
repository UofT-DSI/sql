select vendor_id , 'top_query' as query_name 

from vendor_inventory

UNION ALL

select vendor_id , 'middle query' as query_name

from vendor_inventory

UNION ALL

select vendor_id, 'bottom query' as query_name

from vendor_inventory