UPDATE new_customer_purchases
SET market_date = DATE('now','localtime');

INSERT INTO market_date_info
VALUES('2025-01-30','Thursday','5','2025','8:00 AM','2:00 PM','nothing interesting','Winter','0','4',1,0);

SELECT * FROM todays_vendor_daily_sales