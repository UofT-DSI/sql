-- CROSS JOIN example

DROP TABLE IF EXISTS temp.sizes;

CREATE TEMP TABLE IF NOT EXISTS temp.sizes (
    size TEXT
);

INSERT INTO temp.sizes (size)
VALUES 
    ('small'),
    ('medium'),
    ('large');

-- Preview the temp table
SELECT * FROM temp.sizes;

-- CROSS JOIN with the product table
SELECT 
    product_name,
    size
FROM product
CROSS JOIN temp.sizes;
