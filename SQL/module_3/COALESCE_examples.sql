--COALESCE (this may vary from yours, I lost our in class code, sorry! but should be similar concepts!)


--SELECT COALESCE(NULL,"thomas")

/*
SELECT 
product_name || ', ' || COALESCE(product_size,'')|| ' (' || COALESCE(product_qty_type,'unit') || ')',
product_name || ', ' || COALESCE(product_size,'')|| ' (' || COALESCE(product_qty_type,product_size,product_name) || ')'
FROM product
*/


SELECT market_date,
md.market_day,
COALESCE(market_min_temp,avg_temp)

FROM market_date_info md
JOIN (
	SELECT 
	market_day,
	AVG(market_min_temp) as avg_temp
	
	FROM market_date_info
	GROUP BY market_day
) x on md.market_day = x.market_day

