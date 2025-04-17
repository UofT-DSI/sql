SELECT 

-- Specifying a limited number of fields
product_id
,customer_purchases.vendor_id
-- Data we can get because of the join
,vendor_name
,market_date
,quantity
-- just for fun ;)
,CASE WHEN quantity >=10 
THEN 'No more Fridge Space'
ElSE 'We have space'
END as Fridge_Capacity_Indicator

FROM
customer_purchases

-- Joining data from the vendor table
LEFT JOIN 
vendor
ON
customer_purchases.vendor_id =
vendor.vendor_id
WHERE 
-- Arbitary date filter
market_date >= '2023-09-01'
AND 
vendor.vendor_name = 
-- Here is a single quote in the value 
"Annie's Pies"