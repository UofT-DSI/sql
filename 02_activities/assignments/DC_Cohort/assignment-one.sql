/* ASSIGNMENT 1 */
/* SECTION 2 */


--SELECT
/* 1. Write a query that returns everything in the customer table. */
/* SECTION 2 */

SELECT *
FROM customer;


/* 2. Write a query that displays all of the columns and 10 rows from the customer table, 
sorted by customer_last_name, then customer_first_ name. */

SELECT *
FROM customer
ORDER BY customer_last_name, customer_first_name
LIMIT 10;


--WHERE
/* 1. Write a query that returns all customer purchases of product IDs 4 and 9. */

SELECT *
FROM customer_purchases
WHERE product_id = 4 OR product_id = 9;


/*2. Write a query that returns all customer purchases and a new calculated column 'price' (quantity * cost_to_customer_per_qty), 
filtered by customer IDs between 8 and 10 (inclusive) using either:
	1.  two conditions using AND
	2.  one condition using BETWEEN
*/
-- option 1

SELECT 
    *,
    (quantity * cost_to_customer_per_qty) AS price
FROM 
    customer_purchases
WHERE 
    customer_id >= 8 AND customer_id <= 10;

-- option 2

SELECT 
    *,
    (quantity * cost_to_customer_per_qty) AS price
FROM 
    customer_purchases
WHERE 
    customer_id BETWEEN 8 AND 10;


--CASE
/* 1. Products can be sold by the individual unit or by bulk measures like lbs. or oz. 
Using the product table, write a query that outputs the product_id and product_name
columns and add a column called prod_qty_type_condensed that displays the word “unit” 
if the product_qty_type is “unit,” and otherwise displays the word “bulk.” */

SELECT
    product_id,
    product_name,
    CASE 
        WHEN product_qty_type = 'unit' THEN 'unit'
        ELSE 'bulk'
    END AS prod_qty_type_condensed
FROM product;


/* 2. We want to flag all of the different types of pepper products that are sold at the market. 
add a column to the previous query called pepper_flag that outputs a 1 if the product_name 
contains the word “pepper” (regardless of capitalization), and otherwise outputs 0. */

SELECT
    product_id,
    product_name,
    CASE 
        WHEN product_qty_type = 'unit' THEN 'unit'
        ELSE 'bulk'
    END AS prod_qty_type_condensed,
    CASE
        WHEN LOWER(product_name) LIKE '%pepper%' THEN 1
        ELSE 0
    END AS pepper_flag
FROM product;


--JOIN
/* 1. Write a query that INNER JOINs the vendor table to the vendor_booth_assignments table on the 
vendor_id field they both have in common, and sorts the result by vendor_name, then market_date. */

SELECT 
    vendor.vendor_id,
    vendor.vendor_name,
    vendor_booth_assignments.booth_number,
    vendor_booth_assignments.market_date
FROM 
    vendor
INNER JOIN 
    vendor_booth_assignments
ON 
    vendor.vendor_id = vendor_booth_assignments.vendor_id
ORDER BY 
    vendor.vendor_name,
    vendor_booth_assignments.market_date;

	
	
	/* SECTION 3 */

-- AGGREGATE
/* 1. Write a query that determines how many times each vendor has rented a booth 
at the farmer’s market by counting the vendor booth assignments per vendor_id. */

SELECT 
    vendor_id,
    COUNT(*) AS booth_rental_count
FROM 
    vendor_booth_assignments
GROUP BY 
    vendor_id
ORDER BY 
    booth_rental_count DESC;
	

/* 2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper 
sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list 
of customers for them to give stickers to, sorted by last name, then first name. 

HINT: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword. */

SELECT 
    c.customer_id,
    c.customer_first_name,
    c.customer_last_name,
    SUM(cp.quantity * cp.cost_to_customer_per_qty) AS total_spent
FROM 
    customer AS c
JOIN 
    customer_purchases AS cp
ON 
    c.customer_id = cp.customer_id
GROUP BY 
    c.customer_id, c.customer_first_name, c.customer_last_name
HAVING 
    total_spent > 2000
ORDER BY 
    c.customer_last_name, c.customer_first_name;


--Temp Table
/* 1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: 
Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal

HINT: This is two total queries -- first create the table from the original, then insert the new 10th vendor. 
When inserting the new vendor, you need to appropriately align the columns to be inserted 
(there are five columns to be inserted, I've given you the details, but not the syntax) 

-> To insert the new row use VALUES, specifying the value you want for each column:
VALUES(col1,col2,col3,col4,col5) 
*/
SELECT * 
FROM temp_new_vendor;

INSERT INTO temp_new_vendor (vendor_id, vendor_name, vendor_type, vendor_owner_first_name, vendor_owner_last_name)
VALUES (10, 'Thomass Superfood Store', 'Fresh Focused', 'Thomas', 'Rosenthal');

SELECT *
FROM temp_new_vendor
ORDER BY vendor_id;



-- Date
/*1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.

HINT: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month 
and year are! */

SELECT 
    customer_id,
    strftime('%m', market_date) AS month,
    strftime('%Y', market_date) AS year
FROM customer_purchases;


/* 2. Using the previous query as a base, determine how much money each customer spent in April 2022. 
Remember that money spent is quantity*cost_to_customer_per_qty. 

HINTS: you will need to AGGREGATE, GROUP BY, and filter...
but remember, STRFTIME returns a STRING for your WHERE statement!! */

SELECT 
    customer_id,
    SUM(quantity * cost_to_customer_per_qty) AS total_spent
FROM customer_purchases
WHERE strftime('%m', market_date) = '04'   -- April
  AND strftime('%Y', market_date) = '2022' -- Year 2022
GROUP BY customer_id



/* SECTION 4 */

/* What values systems are embedded in databases and data systems you encounter in your day-to-day life?

/* Databases and data systems are often presented as neutral tools for storing and analyzing information. Yet, the article “When Databases 
Get to Define Family” demonstrates that databases are not merely computational, they are socio-technical systems imbued with implicit value 
systems, social assumptions, and political choices. The Pakistani national database, NADRA, encodes normative expectations about family, gender, 
and citizenship, and illustrates how technical design choices can have profound effects on access to rights and opportunities.

A primary value embedded in NADRA’s schema is normative social order. By requiring individuals to be linked to two married parents, the system 
enforces a rigid definition of legitimate family, marginalizing single parents, children born out of wedlock, and non-traditional kinship arrangements. 
Access to services, identity validation, and even mobility are contingent on compliance with these socially encoded rules. Similarly, in my work at 
Invictus Africa, human rights and gender justice datasets often embed assumptions – sometimes unintentionally – about who counts as a survivor of 
gendered violence or which populations are “visible” to the justice system. For example, case management systems that track sexual violence often 
rely on binary gender categories or formal reporting channels, inadvertently excluding non-binary survivors or those unable to formally report due 
to social stigma.

NADRA also reflects historical and political logics. Citizenship verification is tied to genealogical relationships and migration history, privileging 
some groups while excluding others. In the context of my criminology and transitional justice work, I encounter similar challenges: the way datasets 
are structured can prioritize official state records over community-level or marginalized narratives. For example, atrocity documentation in Borno, 
Adamawa, and Yobe States of Nigeria may rely on government or NGO reports that undercount vulnerable populations, thus embedding systemic inequalities 
in the resulting analysis. The database is not neutral; it produces power dynamics through its structure.

Gender identity offers another clear example. NADRA’s original binary system excluded the khawaja sira community, later amended to include a third-gender 
option after legal and social advocacy. This illustrates that databases encode values about who is considered legitimate or visible, and that technical 
flexibility, or lack thereof, can either reinforce or challenge marginalization. In my gender justice research work, I have observed that many digital 
reporting systems fail to capture intersectional identities, such as girls with disabilities or female survivors of violence who bear unique and 
intersecting identities. Such omissions reproduce inequalities in policy attention, service provision, and advocacy.

The relational structure of databases, as NADRA exemplifies, reinforces hierarchical social structures. Every individual is required to be connected 
to a family unit, whether biological, adoptive, or artificially assigned. In human rights data systems, similar relational assumptions exist: survivors 
may be linked to households, communities, or legal cases in ways that fail to represent lived realities. For example, rape survivor testimonies or 
incident reports that cannot be verified against official records may be excluded from datasets, creating systemic invisibility for marginalized voices.

A recurring theme across NADRA and human rights, criminology, and gender justice databases is the intersection of technical design with social and 
political norms. Design choices – in terms of what fields exist, what constitutes valid input, and how relationships are encoded – carry embedded 
judgments about identity, legitimacy, and priority. For instance, in transitional justice documentation, decisions about which atrocities, communities, 
or perpetrators are included in a database inevitably reflect value judgments about which harms are deemed actionable or legitimate.

Finally, NADRA highlights the importance of flexible, human-centered database design. Large-scale systems must anticipate diversity, change, and edge 
cases. In my human rights and gender justice work, this translates to ensuring that databases are inclusive of all survivors, adaptable to emerging 
evidence, and designed to minimize harm. Values such as fairness, equity, inclusivity, and accountability must be central in the design of technical 
systems if they are to serve justice and uphold rights, rather than reproduce existing inequalities.

In conclusion, databases are not neutral repositories of facts, they are value-laden systems that encode assumptions about social norms, legitimacy, 
and identity. My work at Invictus Africa and in my PhD research repeatedly confronts these dynamics: data structures, definitions, and categories shape 
who is counted, whose experiences are visible, and what interventions are prioritized. The lessons from NADRA reinforce the necessity of critically 
examining both the technical and ethical dimensions of database design, ensuring that human rights, gender justice, and criminology data serve equity, 
inclusion, and accountability, rather than reproducing marginalization.
