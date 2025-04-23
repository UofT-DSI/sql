--CASE

SELECT * 
,CASE WHEN vendor_type = 'Fresh Focused' THEN 'Wednesday'
WHEN vendor_type = 'Prepared Foods'
	THEN 'Thursday'
ELSE 'Saturday'
END as day_of_specialty
--pie day, otherwise nothing
,CASE WHEN vendor_name LIKE '%pie%'
	THEN 'Wednesday'
	END as only_pie_day
,CASE WHEN vendor_name = "Annie's Pies"  -- double quote work, but not for all editors!
	THEN 'annie is best'
	END as annie_is_king
FROM vendor