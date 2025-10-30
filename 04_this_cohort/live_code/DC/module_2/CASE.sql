/* MODULE 2 */
/* CASE */


SELECT * 
/* 1. Add a CASE statement declaring which days vendors should come */
,CASE WHEN vendor_type = 'Fresh Focused' THEN 'Wednesday'
	WHEN vendor_type = 'Prepared Foods' THEN 'Thursday'
	ELSE 'Saturday'
END as day_of_specialty

/* 2. Add another CASE statement for Pie Day */
,CASE WHEN vendor_name = "Annie's Pies" -- double quotes will work here!
	THEN 'Annie is great'
	END as pie_day


/* 3. Add another CASE statement with an ELSE clause to handle rows evaluating to False */
,CASE WHEN vendor_name LIKE '%pie%'
	THEN 'Wednesday'
	ELSE 'Friday'
	END as also_pie_day



FROM vendor;


/* 4. Experiment with selecting a different column instead of just a string value */
SELECT *
,CASE WHEN cost_to_customer_per_qty < '1.00' 
THEN cost_to_customer_per_qty*5
ELSE cost_to_customer_per_qty
END AS inflation

FROM customer_purchases




