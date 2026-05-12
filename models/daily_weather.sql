WITH daily_weather AS (
    SELECT
    HUMIDITY,
    PRESSURE,
    TEMP,
    DATE(TIME) as daily_weather,
    WEATHER,
    WIND_DEG,
    WIND_SPEED
    FROM 
    {{ source('DEMO', 'WEATHER') }}

),
daily_weather_agg as (
    select 
    daily_weather,
    weather,
    round(avg(HUMIDITY),2),
    round(avg(PRESSURE),2),
    round(avg(TEMP),2),    
    round(avg(WIND_DEG),2),
    round(avg(WIND_SPEED),2),    
    row_number() over (partition by daily_weather order by count(weather) desc) as rnk
    from daily_weather
    group by daily_weather, weather
    qualify row_number() over (partition by daily_weather order by count(weather) desc) = 1
)

SELECT * FROM daily_weather_agg