CREATE VIEW history AS 
SELECT
	title,
	datetime(
		visit_date / 1000000,
		'unixepoch',
		'localtime'
	) AS visit_date,
	url,
	(
		CASE visit_type
		WHEN 1 THEN
			'Link'
		WHEN 2 THEN
			'Entered URL'
		WHEN 3 THEN
			'Bookmarked'
		WHEN 4 THEN
			'Embedded'
		WHEN 5 THEN
			'Permanent redirect'
		WHEN 6 THEN
			'Temporary redirect'
		WHEN 7 THEN
			'download'
		WHEN 8 THEN
			'Inline frame'
		WHEN 9 THEN
			'Refresh'
		ELSE
			'other'
		END
	) AS access_type,
	visit_count ,
	datetime(
		last_visit_date / 1000000,
		'unixepoch',
		'localtime'
	) AS last_visit_date,
	from_visit
FROM
	moz_historyvisits,
	moz_places
WHERE
	moz_historyvisits.place_id = moz_places.id
ORDER BY
	moz_historyvisits.visit_date DESC