--DISTINCT

--make a selection of columns distinct
--what does each vendor have on inventory and their price
SELECT DISTINCT vendor_id, product_id, original_price
FROM vendor_inventory;

--what prices does the vendor sell things at
SELECT DISTINCT vendor_id, original_price
FROM vendor_inventory;

-- what products does each vendor have on inventory and their price every day they were at the farmers market
SELECT DISTINCT vendor_id, product_id, original_price, market_date
FROM vendor_inventory