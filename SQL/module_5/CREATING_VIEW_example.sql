CREATE VIEW product_view  AS

SELECT p.*, product_category_name
FROM product p
JOIN product_category pc ON p.product_category_id = pc.product_category_id