{{config(materialized='table', tags=['dim'])}}


select
    time_id,
    action_timestamp_,
    {% for part in ["year", "month", "week", "day", "dayofweek"] %}
        EXTRACT({{ part | upper }} FROM action_timestamp_) as action_{{ part }},
    {% endfor %} 

from {{ref('cleaned_d_time')}}
{{limit_lines_dev()}}
