--LEFT JOIN

SELECT m.market_date, cp.*
FROM market_date_info m
LEFT JOIN customer_purchases cp
	ON m.market_date = cp.market_date