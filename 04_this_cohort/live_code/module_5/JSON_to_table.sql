--JSON to TABLE

-- create a temp TABLE
-- insert the json as "long string" aka BLOB 
-- write a json_each statement
-- use the json_each statement as a subquery with a json_extract to create our column values 

DROP TABLE IF EXISTS temp.country_json;
CREATE TABLE IF NOT EXISTS temp.country_json 
(
the_json BLOB -- the column and the column type
);

INSERT INTO temp.country_json
VALUES(
'[
    {
        "country": "Afghanistan",
        "city": "Kabul"
    },
    {
        "country": "Albania",
        "city": "Tirana"
    }
]'
);

SELECT key
,JSON_EXTRACT(value,'$.country') as country
,JSON_EXTRACT(value,'$.city') as city

FROM (
	SELECT * 
	FROM country_json,JSON_EACH(country_json.the_json, '$') -- for each of the json elements, everything
)