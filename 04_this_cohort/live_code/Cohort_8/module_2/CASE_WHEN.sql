/* MODULE 2 */
/* CASE */


SELECT *,
/* 1. Add a CASE statement declaring which days vendors should come */ 
CASE WHEN vendor_type = 'Fresh Focused' THEN 'Wednesday'
	WHEN vendor_type = 'Prepared Foods' THEN 'Thursday'
	ELSE 'Saturday'
	END as day_of_specialty

/* 2. Add another CASE statement for Pie Day */
,CASE WHEN vendor_name = "Annie's Pies" -- double quotes will work just this once 
	THEN 'Annie is the best'
	END AS annie_is_queen


/* 3. Add another CASE statement with an ELSE clause to handle rows evaluating to False */
,CASE WHEN vendor_name LIKE '%pie%'
THEN 'Wednesday'
ELSE 'Friday' -- with this else, we get values for all the FALSE statements
END AS pie_day


/* 4. Experiment with selecting a different column instead of just a string value */
,CASE WHEN vendor_type = 'Fresh Focused' THEN vendor_owner_first_name
	WHEN vendor_type = 'Eggs & Meats' THEN vendor_owner_last_name
	END as first_or_last


FROM vendor