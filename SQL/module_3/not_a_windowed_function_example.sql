/* this query shows that we can't use max and product_id to get the highest price per vendor_ and product_id while 
we can run max on original_price grouping by vendor_id, we cannot know the product_id (and therefore can't 
join the product table to see the name). only a windowed function would allow us this, which is shown in contrast. */

SELECT
vendor_id
, product_id,
MAX(original_price) AS highest_price

FROM vendor_inventory
GROUP BY vendor_id, product_id
ORDER BY vendor_id
