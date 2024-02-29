--JSON TABLE

drop table if exists temp.[sjon];

create temp table if not exists temp.[sjon]
(
col BLOB
);

insert into temp.[sjon](col)
values('[
    {
        "country": "Afghanistan",
        "city": "Kabul"
    },
    {
        "country": "Albania",
        "city": "Tirana"
    }]');
	
SELECT key
,JSON_EXTRACT(value, '$.country') as country
,JSON_EXTRACT(value, '$.city') as city

FROM (
	SELECT *
	FROM sjon,JSON_EACH(sjon.col, '$')
) x