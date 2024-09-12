-- CASE

SELECT *
,CASE WHEN vendor_type = 'Fresh Focused' 
	THEN 'Wednesday'
	WHEN vendor_type = 'Prepared Foods'
	THEN 'Thursday'
	ELSE 'Saturday'
	END as day_of_speciality
,CASE WHEN vendor_type = 'Fresh Focused' 
	THEN 'Wednesday'
	WHEN vendor_name LIKE '%pie%'
	THEN 'Thursday'
	ELSE 'Saturday'
	END as day_of_speciality2

FROM vendor