--UPDATE the new_customer_purchases table to be "today"

UPDATE new_customer_purchases
SET market_date = '2025-08-13';

-- Add today's info to the market_date_info 
INSERT INTO market_date_info
VALUES('2025-08-13','Wednesday','33','2025','8:00 AM','2:00 PM','nothing interesting','Summer','25','28',0,0);

SELECT  * FROM todays_vendor_daily_sales


