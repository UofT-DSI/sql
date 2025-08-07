
--CASE add some logic which vendors come which days
SELECT *, 
CASE WHEN vendor_type ='Fresh Focused' THEN 'Wednesday'
	WHEN vendor_type ='Prepared Foods' THEN 'Thursday'
	ELSE 'Saturday'
END AS day_of_speciality,
CASE WHEN vendor_name = "Annie's Pies" THEN 'Annie is the best'
END AS annie_is_the_king,

CASE WHEN vendor_name = '%pie' THEN 'Wednesday' 
ELSE 'Friday'
END AS pie_day

FROM vendor
