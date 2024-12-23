-- CASE

-- "day of speciality for certain criteria"
SELECT *
,CASE WHEN vendor_type = 'Fresh Focused' 
	THEN 'Wednesday'
 WHEN vendor_type = 'Prepared Foods'
	THEN 'Thursday'
	ELSE 'Saturday'
	END as day_of_speciality
-- pie day, otherwise nothing
,CASE WHEN vendor_name LIKE '%pie%'
	THEN 'Wednesday'
	END as only_pie_day
--,CASE WHEN vendor_name = 'Annie's Pies' -- cant do this (yet) so we need like instead! --END as annies_day
FROM vendor