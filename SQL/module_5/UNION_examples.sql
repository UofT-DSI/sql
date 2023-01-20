--UNION

SELECT vendor_id,'top query' AS column_whatever
FROM vendor

UNION

SELECT vendor_id,'bottom query' AS different_name
FROM vendor

UNION 

SELECT vendor_id,'middle query'
FROM vendor