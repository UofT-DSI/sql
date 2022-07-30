SELECT
vendor_id,
MAX(original_price) AS highest_price

FROM vendor_inventory
GROUP BY vendor_id
ORDER BY vendor_id
