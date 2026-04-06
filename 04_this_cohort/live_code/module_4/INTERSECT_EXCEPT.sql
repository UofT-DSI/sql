/* MODULE 4 */
/* INTERSECT & EXCEPT */

/* 1. Find products that have been sold (e.g. are in customer purchases AND product) */ 
SELECT product_id FROM product
INTERSECT
SELECT product_id FROM customer_purchases;


/* 2. Find products that have NOT been sold (e.g. are NOT in customer purchases even though in product) */
SELECT product_id FROM product
EXCEPT
SELECT product_id FROM customer_purchases;


/* 3. Directions matter... if we switch the order here:
products that do not exist, because no products purchased are NOT in the product table (e.g. are NOT in product even though in customer purchases)*/
SELECT product_id FROM customer_purchases
EXCEPT
SELECT product_id FROM product; -- results in nothing, no products in cust_pur that arent in product


/* 4. We can remake the intersect with a WHERE subquery for more details ...  */

SELECT * FROM product
WHERE product_id IN 
	(SELECT product_id FROM product
	INTERSECT
	SELECT product_id FROM customer_purchases)

