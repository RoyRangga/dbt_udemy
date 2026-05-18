WITH BIKE AS (
    select 
    START_STATION_ID AS start_station_id,
    START_STATION_NAME as start_station_name,
    START_LAT,
    START_LNG
    from
    {{ source('DEMO', 'CITI_BIKE_TRIP') }}
    where RIDE_ID != 'ride_id'
    -- limit 10
)

select * from BIKE