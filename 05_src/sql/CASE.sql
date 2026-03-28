/* MODULE 2 */
/* CASE */


SELECT * 
/* 1. Add a CASE statement declaring which days vendors should come */
,CASE WHEN vendor_type = "Fresh Focused" THEN "WEDNESDAY"
WHEN vendor_type = "EGGS & MEATS" THEN "THURSDAY"
ELSE "SATURDAY"
END AS DAY_OF_SPECIALTY

/* 2. Add another CASE statement for Pie Day */



/* 3. Add another CASE statement with an ELSE clause to handle rows evaluating to False */



/* 4. Experiment with selecting a different column instead of just a string value */


FROM vendor


--------------------------------------------------------------------------------------------------------------------------------------------
