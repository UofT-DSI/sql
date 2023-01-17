

SELECT
vendor_id
,product_id
,max(original_price) AS highest_price

FROM vendor_inventory
GROUP BY
vendor_id
,product_id