--MIN & MAX

-- on a string?
-- SELECT min(product_category_name)
-- FROM product_category

-- SELECT MIN(booth_number) , MAX(booth_number)
-- FROM booth

/*
SELECT vendor_id,min(cost_to_customer_per_qty),max(cost_to_customer_per_qty)

FROM customer_purchases
GROUP BY vendor_id
*/

--ARITHMITIC

--??
SELECT cost_to_customer_per_qty / 2
,CAST(cost_to_customer_per_qty AS INT)/2 as int_version
,CAST(cost_to_customer_per_qty AS INT) % 2 as remainer
FROM customer_purchases