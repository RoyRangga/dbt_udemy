{% macro functions(x) %}
    CASE
        WHEN to_timestamp_ntz({{x}}) < CURRENT_DATE THEN 'PAST'
        WHEN to_timestamp_ntz({{x}}) = CURRENT_DATE THEN 'TODAY'
        ELSE 'FUTURE'
    END
{% endmacro %}

{% macro station_of_year(x)%}
CASE
    WHEN MONTH(to_timestamp_ntz({{x}})) in (12,1,2) THEN 'WINTER'
    WHEN MONTH(to_timestamp_ntz({{x}})) in (3,4,5) THEN 'SPRING'
    WHEN MONTH(to_timestamp_ntz({{x}})) in (6,7,8) THEN 'SUMMER'
    ELSE 'AUTUMN'
END
{% endmacro %}

{% macro is_businessday(x) %}
CASE
    WHEN dayname(to_timestamp_ntz({{x}})) in ('sat','sun') THEN 'WEEKEND'
    ELSE 'BUSINESSDAY'
END
{%endmacro%}