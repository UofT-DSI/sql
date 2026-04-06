--JSON TO TABLE

-- create a temp table 
-- insert the json as "long" string, aka BLOB
-- write a json_each statement
--use the json_each statement as a subquery with a json_extract to create our column values

DROP TABLE IF EXISTS temp.[new_json];
CREATE TEMP TABLE IF NOT EXISTS temp.new_json
(
the_json BLOB -- the column and the column type
);

INSERT INTO temp.new_json
VALUES(
'[
    {
        "country": "Afghanistan",
        "city": "Kabul"
    },
    {
        "country": "Albania",
        "city": "Tirana"
    }]'
    );
    
    
    SELECT key
    ,JSON_EXTRACT(value,'$.country') as country
    ,JSON_EXTRACT(value,'$.city') as city
    
  FROM (
	 SELECT * 
	 FROM new_json,JSON_EACH(new_json.the_json, '$')
	 )
