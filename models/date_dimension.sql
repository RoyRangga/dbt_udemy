with cte as (
select 
to_timestamp_ntz(started_at) as started_at,
DATE(to_timestamp_ntz(started_at)) as date_started_at,
HOUR(to_timestamp_ntz(started_at)) as hour_started_at,
MONTH(to_timestamp_ntz(started_at)) as month_started_at,
dayname(to_timestamp_ntz(started_at)) as day_name_started_at,
CASE
    WHEN dayname(to_timestamp_ntz(started_at)) in ('sat', 'sun') THEN 'WEEKEND'
    ELSE 'BUSINESSDAY'
END AS day_type,
CASE
    WHEN MONTH(to_timestamp_ntz(started_at)) in (12,1,2) THEN 'WINTER'
    WHEN MONTH(to_timestamp_ntz(started_at)) in (3,4,5) THEN 'SPRING'
    WHEN MONTH(to_timestamp_ntz(started_at)) in (6,7,8) THEN 'SUMMER'
    ELSE 'AUTUMN'
END AS STATION_OF_YEAR
from 
{{ source('DEMO', 'CITI_BIKE_TRIP') }} 
where started_at != 'started_at'
)

select * from cte