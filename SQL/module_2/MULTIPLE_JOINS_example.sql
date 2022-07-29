SELECT DISTINCT

v.*, vba.*, vi.*

FROM vendor v
INNER JOIN vendor_booth_assignments vba
	ON v.vendor_id = vba.vendor_id
INNER JOIN vendor_inventory vi
	ON vi.vendor_id = v.vendor_id AND vi.market_date = vba.market_date