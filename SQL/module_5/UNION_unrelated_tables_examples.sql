-- UNION, unrelated query

SELECT booth_number, 0 as zip_code_5

FROM booth

UNION

SELECT NULL as booth_number, zip_code_5

FROM zip_data