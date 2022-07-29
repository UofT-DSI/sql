SELECT *
v.* 
--,booth_number
--,market_date
--v.vendor_id,vba.vendor_id

FROM vendor v
INNER JOIN vendor_booth_assignments  vba
	ON v.vendor_id = vba.vendor_id