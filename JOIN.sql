SELECT *
FROM vendor v
INNER JOIN vendor_booth_assignments va
ON v.vendor_id = va.vendor_id
ORDER BY v.vendor_name, va.market_date;
