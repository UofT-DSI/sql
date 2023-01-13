--WHERE

/*
SELECT *
FROM market_date_info

WHERE market_date BETWEEN '2019-03-02' AND '2019-03-16'
*/

/*
SELECT *
FROM market_date_info
WHERE market_min_temp IS NULL
*/

/*
SELECT *
FROM market_date_info
WHERE 1=1
AND (market_season = 'Spring' AND market_rain_flag = 1) 
OR market_snow_flag = 1
*/

/*
SELECT *
FROM product
WHERE product_size IN ('small','medium','large') 
*/

/*
SELECT * 
FROM product
WHERE product_name LIKE '%epper%'
*/


SELECT *
FROM market_date_info
WHERE market_week NOT IN ('9','10','11','12')


/*
SELECT *
FROM market_date_info
WHERE CAST(market_week AS INT) > 12
*/