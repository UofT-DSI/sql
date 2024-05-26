

DROP TABLE IF EXISTS temp.[new_json];

CREATE TEMP TABLE IF NOT EXISTS temp.new_json
(
col1 BLOB
);

INSERT INTO temp.new_json(col1)
VALUES('[
    {
        "country": "Afghanistan",
        "city": "Kabul"
    },
    {
        "country": "Albania",
        "city": "Tirana"
    }]');
	
SELECT key
,JSON_EXTRACT(value,'$.country') as country
,JSON_EXTRACT(value,'$.city') as city

FROM (
	SELECT * 
	FROM new_json,JSON_EACH(new_json.col1, '$')
) x