--distinct

--SELECT DISTINCT booth_type FROM BOOTH

-- SELECT DISTINCT booth_price_level, booth_type
-- FROM booth

SELECT DISTINCT booth_price_level, booth_type, booth_description
FROM booth

/* "which vendor has sold products to a customer" */
 SELECT DISTINCT vendor_id
 FROM customer_purchases;

-- "which vendor has sold products to a customer -- and which product was it"
SELECT DISTINCT vendor_id, product_id--, product_name
FROM customer_purchases;

SELECT DISTINCT vendor_id, product_id, customer_id
FROM customer_purchases;