# UNION vs OR in Joining Tables

Create  the first table:
```sql
DROP TABLE IF EXISTS production_status;

CREATE TABLE production_status (
product_id VARCHAR(10) PRIMARY KEY,
production_date DATE,
batch INTEGER,
total_product INTEGER,
status VARCHAR(25)
);

INSERT INTO production_status
VALUES
('P101', '2023-08-17', 1, 100, 'Delivered'),
('P102', '2024-01-01', 2, 200, 'Shipped'),
('P103', '2024-05-11', 3, 300, 'Check Out'),
('P104', '2024-12-31', 4, 400, 'Delivered'),
('P105', '2025-02-21', 5, 500, 'Delivered'),
('P106', '2025-07-30', 6, 600, 'Shipped');

SELECT * FROM production_status
```
![Library_project](https://github.com/imdwipayana/DB-Browser-for-SQLite/blob/main/Best%20Practices/UNION%20vs%20OR/image/production_status.png)

Create  the second table:
```sql
DROP TABLE IF EXISTS sales_product;

CREATE TABLE sales_product (
main_id VARCHAR(10),
backup_id VARCHAR(10),
warehouse VARCHAR(50),
total_sales FLOAT
);

INSERT INTO sales_product
VALUES
('P101', NULL,   'Edmonton',  200000),
(NULL,   'P102', 'Toronto',   300000),
(NULL,   'P103', 'Regina',    400000),
('P104', NULL,   'Saskatoon', 500000),
(NULL,   'P105', 'Vancouver', 600000),
('P106', NULL,   'Ottawa',    700000),
('P107', 'P107', 'Winnippeg', 800000),
('P108', 'P108', 'Calgary',   900000);

SELECT * FROM sales_product
```
![Library_project](https://github.com/imdwipayana/DB-Browser-for-SQLite/blob/main/Best%20Practices/UNION%20vs%20OR/image/sales_product.png)

### 1. The product_id value on first table is noted on two columns, either in main_id or backup_in on second table. Find the total sales of all products.
First method: using OR in the process of joining the two tables.

First method first step:
```sql
SELECT
	*
FROM production_status AS ps
INNER JOIN sales_product AS sp
ON ps.product_id = sp.main_id OR ps.product_id = sp.backup_id;
```
![Library_project](https://github.com/imdwipayana/DB-Browser-for-SQLite/blob/main/Best%20Practices/UNION%20vs%20OR/image/method_1_step_1.png)

First method second step: selected the required columns only.
```sql
SELECT
	ps.product_id,
	sp.total_sales
FROM production_status AS ps
INNER JOIN sales_product AS sp
ON ps.product_id = sp.main_id OR ps.product_id = sp.backup_id
```
![Library_project](https://github.com/imdwipayana/DB-Browser-for-SQLite/blob/main/Best%20Practices/UNION%20vs%20OR/image/method_1_step_2.png)

Second method first step:
```sql
SELECT
	*
FROM production_status AS ps
INNER JOIN sales_product AS sp
ON ps.product_id = sp.main_id
UNION
SELECT
*
FROM production_status AS ps
INNER JOIN sales_product AS sp
ON ps.product_id = sp.backup_id;
```
![Library_project](https://github.com/imdwipayana/DB-Browser-for-SQLite/blob/main/Best%20Practices/UNION%20vs%20OR/image/method_2_step_1.png)

Second method second step: selected the required columns only.
```sql
SELECT
	ps.product_id,
	sp.total_sales
FROM production_status AS ps
INNER JOIN sales_product AS sp
ON ps.product_id = sp.main_id
UNION
SELECT
	ps.product_id,
	sp.total_sales
FROM production_status AS ps
INNER JOIN sales_product AS sp
ON ps.product_id = sp.backup_id;
```
![Library_project](https://github.com/imdwipayana/DB-Browser-for-SQLite/blob/main/Best%20Practices/UNION%20vs%20OR/image/method_2_step_2.png)


Note: The second method is considered as best practice for big data.
