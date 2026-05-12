with cte as (
select 
to_timestamp_ntz(started_at) as started_at,
DATE(to_timestamp_ntz(started_at)) as date_started_at,
HOUR(to_timestamp_ntz(started_at)) as hour_started_at,
MONTH(to_timestamp_ntz(started_at)) as month_started_at,
dayname(to_timestamp_ntz(started_at)) as day_name_started_at,
{{ is_businessday('started_at') }} AS day_type,
{{ station_of_year('started_at') }} AS STATION_OF_YEAR,
{{functions('started_at')}} as is_past
from 
{{ source('DEMO', 'CITI_BIKE_TRIP') }} 
where started_at != 'started_at'
)

select * from cte