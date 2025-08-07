--WHERE

SELECT * from customer
WHERE customer_id = 1
OR customer_id = 2;

--IN
SELECT * from customer
WHERE customer_id IN (3,4,5)
OR customer_postal_code IN ('M4H');


SELECT * from product
WHERE product_name LIKE '%peppers%';


--customer with a last name startinf with a 
SELECT * from customer
WHERE customer_last_name like 'a%';

--Nulls and blanks
SELECT * from product
WHERE product_size IS NULL
OR product_size IS '';

SELECT * from customer
WHERE customer_id BETWEEN 1 AND 5;




