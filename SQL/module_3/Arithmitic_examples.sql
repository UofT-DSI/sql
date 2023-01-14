--Arithmitic

/*
SELECT 5*5, 5.0*5.5, (CAST(10 AS INT) / CAST(3 AS INT))
,10 % 3

*/

/*
SELECT *,vendor_id % 2
FROM vendor

WHERE vendor_id % 2 = 0

*/

SELECT market_date,market_max_temp,market_min_temp,
 market_max_temp - market_min_temp as temp_range

FROM market_date_info