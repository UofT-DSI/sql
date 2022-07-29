-- SELECT *
-- 
-- FROM vendor v 
-- LEFT JOIN customer c
-- 	ON c.customer_first_name = v.vendor_owner_first_name


SELECT m.market_date, cp.*

FROM market_date_info m
LEFT JOIN customer_purchases cp 
	ON m.market_date = cp.market_date