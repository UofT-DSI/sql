# AGGREGATE
1. Write a query that determines how many times each vendor has rented aInsert the original vendor table into  booth 
at the farmer’s market by counting the vendor booth assignments per `vendor_id`.

SELECT VENDOR_NAME, COUNT(BOOTH_NUMBER) AS Booth_Cxt
FROM VENDOR v
JOIN vendor_booth_assignments vba ON V.VENDOR_ID = VBA.vendor_id
GROUP BY VENDOR_NAME;

2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper sticker to everyone who has ever 
spent more than $2000 at the market. Write a query that generates a list of customers for them to give stickers to, 
sorted by last name, then first name. 

SELECT customer_first_name, customer_last_name, SUM(quantity * cost_to_customer_per_qty) AS Amt_spent
FROM customer c
JOIN customer_purchases cp ON C.customer_id = CP.customer_id
GROUP BY customer_last_name, customer_first_name
HAVING amt_spent > 2000
ORDER BY customer_last_name, customer_first_name;

# Temp Table
1. a temp.new_vendor and then add a 10th vendor: Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal

create temporary table temp.new_vendor as
select * from vendor;


Insert into temp.new_vendor
(vendor_id, vendor_name, vendor_type, vendor_owner_first_name, vendor_owner_last_name)
VALUES(10, "Thomass Superfood Store","a Fresh Focused store","Thomas","Rosenthal")

# Date
1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.

SELECT customer_id, strftime('%m',market_date) AS MTH, strftime('%Y',market_date) AS YR
FROM customer_purchases;



